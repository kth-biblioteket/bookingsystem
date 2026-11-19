<?php
/*
Funktioner som hämtar utbildningsprogram från Ladok (mellanlagring, Azure API Management).

Det gamla programmet-API:t (KOPPS) är ersatt.  Anropet sker i två steg:
  1. Hämta en OAuth2-token hos Microsoft (client credentials).
  2. Anropa Ladok-API:t med token (Authorization: Bearer) och prenumerationsnyckel (Ocp-Apim-Subscription-Key).

Inställningar (sätts i appens config, aldrig i repot):
  $ladok_token_url         t.ex. https://login.microsoftonline.com/<tenant-id>/oauth2/v2.0/token
  $ladok_client_id
  $ladok_client_secret
  $ladok_scope             t.ex. api://<app-id>/.default
  $ladok_api_url           t.ex. https://ladok-mellanlagring-lab.azure-api.net/sokUtbildningsinstans
  $ladok_subscription_key
  $ladok_programs_query    valfri, standard: kodEllerBenamning=*&antalTraffar=300&senasteversion=true&utbildningstypid=78,101971,101998,101372
  $ladok_cache_ttl         valfri, sekunder att behålla programlistan, standard 3600

Både token och programlista cachas i systemets temp-katalog.  Går Ladok ner används den senast
hämtade listan så att bokningsformuläret fortsätter fungera.
*/

// Läs ett attributvärde ur en utbildning i Ladok-svaret (Attributvarden -> Attributdefinition.Kod / Varden[0])
function ladok_attr($item, $kod) {
	if (!isset($item['Attributvarden']) || !is_array($item['Attributvarden'])) {
		return '';
	}
	foreach ($item['Attributvarden'] as $attr) {
		if (isset($attr['Attributdefinition']['Kod']) && $attr['Attributdefinition']['Kod'] === $kod) {
			return (isset($attr['Varden'][0]) && is_scalar($attr['Varden'][0])) ? (string) $attr['Varden'][0] : '';
		}
	}
	return '';
}

// Hjälpfunktion: skriv cachefil (endast ägaren får läsa den)
function ladok_cache_write($file, $data) {
	$tmp = $file . '.' . getmypid() . '.tmp';
	if (@file_put_contents($tmp, json_encode($data), LOCK_EX) !== FALSE) {
		@chmod($tmp, 0600);
		@rename($tmp, $file);
	}
}

// Hämtar en OAuth2-token (client credentials) och cachar den tills strax före utgång.
// Returnerar token eller NULL om den inte gick att hämta.
function ladok_get_token($force_new = FALSE) {
	global $ladok_token_url, $ladok_client_id, $ladok_client_secret, $ladok_scope;

	if (empty($ladok_token_url) || empty($ladok_client_id) || empty($ladok_client_secret)) {
		error_log('LADOK: inställningar för token saknas i configen');
		return NULL;
	}

	$cache_file = sys_get_temp_dir() . '/ladok_token_' . md5($ladok_token_url . '|' . $ladok_client_id) . '.json';
	if ($force_new) {
		@unlink($cache_file);
	} elseif (is_readable($cache_file)) {
		$cached = json_decode(@file_get_contents($cache_file), TRUE);
		if (is_array($cached) && !empty($cached['access_token']) && isset($cached['expires']) && $cached['expires'] > time() + 60) {
			return $cached['access_token'];
		}
	}

	$fields = array(
		'grant_type'    => 'client_credentials',
		'client_id'     => $ladok_client_id,
		'client_secret' => $ladok_client_secret,
	);
	if (!empty($ladok_scope)) {
		$fields['scope'] = $ladok_scope;
	}

	$ch = curl_init($ladok_token_url);
	curl_setopt($ch, CURLOPT_POST, TRUE);
	curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($fields));
	curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/x-www-form-urlencoded', 'Accept: application/json'));
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
	curl_setopt($ch, CURLOPT_TIMEOUT, 20);
	$response = curl_exec($ch);
	$status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
	$curl_error = curl_error($ch);
	curl_close($ch);

	$data = ($response === FALSE) ? NULL : json_decode($response, TRUE);
	if (!is_array($data) || empty($data['access_token'])) {
		// Logga bara felkoden, aldrig svaret eller några hemligheter
		$reason = ($response === FALSE) ? $curl_error : (is_array($data) && isset($data['error']) ? $data['error'] : 'okänt svar');
		error_log('LADOK: kunde inte hämta token, HTTP ' . $status . ' (' . $reason . ')');
		return NULL;
	}

	$expires_in = (isset($data['expires_in']) && is_numeric($data['expires_in'])) ? (int) $data['expires_in'] : 3000;
	ladok_cache_write($cache_file, array('access_token' => $data['access_token'], 'expires' => time() + $expires_in));
	return $data['access_token'];
}

// Anropar Ladok och returnerar en lista av array('code'=>..., 'sv'=>..., 'en'=>...), eller NULL om det misslyckas.
function ladok_fetch_programs() {
	global $ladok_api_url, $ladok_subscription_key, $ladok_programs_query;

	if (empty($ladok_api_url) || empty($ladok_subscription_key)) {
		error_log('LADOK: inställningar för API:t saknas i configen');
		return NULL;
	}
	$query = !empty($ladok_programs_query) ? $ladok_programs_query
	       : 'kodEllerBenamning=*&antalTraffar=300&senasteversion=true&utbildningstypid=78,101971,101998,101372';

	for ($attempt = 0; $attempt < 2; $attempt++) {
		// Andra försöket görs bara om första gav 401 (token ogiltig/utgången): hämta då en ny token
		$token = ladok_get_token($attempt > 0);
		if ($token === NULL) {
			return NULL;
		}

		$ch = curl_init($ladok_api_url . '?' . $query);
		curl_setopt($ch, CURLOPT_HTTPGET, TRUE);
		curl_setopt($ch, CURLOPT_HTTPHEADER, array(
			'Authorization: Bearer ' . $token,
			'Ocp-Apim-Subscription-Key: ' . $ladok_subscription_key,
			'Accept: application/json',
		));
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
		curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
		curl_setopt($ch, CURLOPT_TIMEOUT, 30);
		$response = curl_exec($ch);
		$status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
		$curl_error = curl_error($ch);
		curl_close($ch);

		if ($response !== FALSE && $status == 401 && $attempt == 0) {
			continue;
		}
		if ($response === FALSE || $status < 200 || $status >= 300) {
			error_log('LADOK: kunde inte hämta program, HTTP ' . $status . ($curl_error != '' ? ' (' . $curl_error . ')' : ''));
			return NULL;
		}
		break;
	}

	$data = json_decode($response, TRUE);
	if (!is_array($data)) {
		error_log('LADOK: oväntat svar från API:t (inte JSON)');
		return NULL;
	}

	// Svaret är en lista: första posten är metadata (pageResultSize, continuationToken), övriga är utbildningar.
	// Vi hämtar bara första sidan (antalTraffar=300).  Finns det fler sidor loggar vi det, så att det märks om
	// antalet program någon gång överstiger gränsen.
	if (isset($data[0]['continuationToken']) && $data[0]['continuationToken'] !== '') {
		error_log('LADOK: svaret har fler sidor (continuationToken), bara första sidan hämtades. Höj antalTraffar eller bygg stöd för sidhämtning.');
	}
	$programs = array();
	foreach ($data as $item) {
		if (!is_array($item) || !isset($item['Attributvarden'])) {
			continue;
		}
		$code = ladok_attr($item, 'utbildning.attribut.kod');
		if ($code === '') {
			continue;
		}
		$sv = ladok_attr($item, 'utbildning.attribut.svensk.benamning');
		$en = ladok_attr($item, 'utbildning.attribut.engelsk.benamning');
		$programs[$code] = array(
			'code' => $code,
			'sv'   => ($sv !== '') ? $sv : (($en !== '') ? $en : $code),
			'en'   => ($en !== '') ? $en : (($sv !== '') ? $sv : $code),
		);
	}
	$programs = array_values($programs);
	usort($programs, function ($a, $b) {
		return strnatcasecmp($a['sv'], $b['sv']);
	});
	return $programs;
}

// Programlistan, cachad.  Returnerar alltid en array (tom om inget gick att hämta och ingen cache finns).
function ladok_get_programs() {
	global $ladok_api_url, $ladok_programs_query, $ladok_cache_ttl;
	static $memory = NULL;
	if ($memory !== NULL) {
		return $memory;
	}

	$ttl = (isset($ladok_cache_ttl) && is_numeric($ladok_cache_ttl)) ? (int) $ladok_cache_ttl : 3600;
	$cache_file = sys_get_temp_dir() . '/ladok_programs_' . md5($ladok_api_url . '|' . $ladok_programs_query) . '.json';

	$cached = NULL;
	if (is_readable($cache_file)) {
		$cached = json_decode(@file_get_contents($cache_file), TRUE);
		if (is_array($cached) && isset($cached['fetched']) && isset($cached['programs']) && is_array($cached['programs'])
		    && (time() - $cached['fetched']) < $ttl) {
			$memory = $cached['programs'];
			return $memory;
		}
	}

	$programs = ladok_fetch_programs();
	if (is_array($programs) && count($programs) > 0) {
		ladok_cache_write($cache_file, array('fetched' => time(), 'programs' => $programs));
		$memory = $programs;
	} elseif (is_array($cached) && isset($cached['programs']) && is_array($cached['programs'])) {
		// Ladok svarar inte: använd den senaste listan även om den är gammal
		error_log('LADOK: använder gammal cachad programlista');
		$memory = $cached['programs'];
	} else {
		$memory = array();
	}
	return $memory;
}

/*
Funktion som hämtar utbildningsprogram.  Returnerar JSON i samma form som det gamla API:t:
{"programmes":[{"code":"KUAUT","title":{"sv":"...","en":"..."}}, ...]}
*/
function getkthprograms() {
	$list = array();
	foreach (ladok_get_programs() as $program) {
		$list[] = array(
			'code'  => $program['code'],
			'title' => array('sv' => $program['sv'], 'en' => $program['en']),
		);
	}
	return json_encode(array('programmes' => $list));
}

/*
Funktion som returnerar ett program som objekt med ->code och ->title (sträng på aktuellt språk).
Finns koden inte i listan (t.ex. en gammal KOPPS-kod på en tidigare bokning) används koden som titel.
*/
function getkthprogram($code) {
	global $mrbslang;

	$result = new stdClass();
	$result->code = $code;
	$result->title = ($code === NULL || $code === '') ? '' : (string) $code;
	if ($code === 'other') {
		$result->title = 'Other';
		return $result;
	}
	foreach (ladok_get_programs() as $program) {
		if ($program['code'] === (string) $code) {
			$result->title = (isset($mrbslang) && $mrbslang == 'sv') ? $program['sv'] : $program['en'];
			break;
		}
	}
	return $result;
}
