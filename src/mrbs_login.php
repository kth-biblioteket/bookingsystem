<?php
require_once "config.inc.php";
require_once "functions.inc";
global $cas_server;
// Timezone
date_default_timezone_set("Europe/Stockholm");

if (!empty($_GET["formlanguage"])) {
	$formlanguage = $_GET["formlanguage"];
} else {
	$formlanguage = "en";
}
if (!empty($_GET["returl"])) {
	$returl = $_GET["returl"];
} else {
	$returl = "/";
}
if (!empty($_GET["area"])) {
	$area = $_GET["area"];
} else {
	$area = "1";
}
if (!empty($_GET["room"])) {
	$room = $_GET["room"];
} else {
	$room = "1";
}
if (!empty($_GET["page"])) {
	$page = $_GET["page"];
} elseif (isset($_GET["code"])) {
	// Retur från ADFS: parametrarna läses från sessionen, ingen databas behövs här
	$page = "day";
} else {
	$default_view = get_default_view($area); //KTH
	switch ($default_view) {
		case 2:
			$page = "month";
			break;
		case 1:
			$page = "week";
			break;
		case 0:
			$page = "day";
			break;
		default:
			$page = "day";
	}
}

//191003
//Egna sessionnames per app från config.inc
if(isset($session_name)) {
	$sessionname = $session_name;
	session_name($sessionname);
}

session_start();

// Parametrarna skickas inte i redirect_uri (ADFS kräver exakt matchning mot den registrerade URI:n).
// De sparas i sessionen vid första anropet och läses därifrån när ADFS skickar tillbaka användaren.
if (!isset($_GET['code'])) {
	// endast lokal sökväg, annars open redirect
	if (!preg_match('#^/[A-Za-z0-9_\-/]*$#', $returl)) {
		$returl = "/";
	}
	if (!in_array($page, array("day", "week", "month"), true)) {
		$page = "day";
	}
	$_SESSION['login_params'] = array(
		'formlanguage' => $formlanguage,
		'returl'       => $returl,
		'area'         => (int)$area,
		'room'         => (int)$room,
		'page'         => $page,
	);
}
$login_params = isset($_SESSION['login_params']) ? $_SESSION['login_params'] : array(
	'formlanguage' => 'en',
	'returl'       => '/',
	'area'         => 1,
	'room'         => 1,
	'page'         => 'day',
);

//210519 OpenID Connect framework(myits)
require_once($_SERVER['DOCUMENT_ROOT'] .  '/myits/vendor/autoload.php');

use Its\Sso\OpenIDConnectClient;
use Its\Sso\OpenIDConnectClientException;

try {
	$oidc = new OpenIDConnectClient(
		$kth_auth_endpoint,
		$kth_client_id,
		$kth_client_secret
	);

	$oidc->addScope('openid email profile');
  
	// remove this if in production mode
	$oidc->setVerifyHost(false);
	$oidc->setVerifyPeer(false);

	$oidc->setRedirectURL("https://" . $_SERVER['HTTP_HOST'] . "/" . $app_name . "/mrbs_login.php"); // must be the same as you registered (utan parametrar)

	//Skickar vidare till login på KTH om användaren inte redan är inloggad
	$oidc->authenticate();
	//Vid redan inloggad exekveras koden nedan 

	//id_token innehåller den användarinfo tjänsten prenumererar på(här används kthid)
	$_SESSION['id_token'] = $oidc->getIdToken();
	$userinfo = decodeJWT($_SESSION['id_token'], 1);
	$_SESSION['kth_id'] = $userinfo->kthid;

	//finns ett kthid så startas applikationen
	if(isset($_SESSION['kth_id']) && $_SESSION['kth_id'] != "") {
		$userid = $_SESSION['kth_id']  ;
		header("location: " . $login_params['returl'] . $login_params['page'] . ".php?area=" . $login_params['area'] . "&room=" . $login_params['room']);
	}
  
} catch (OpenIDConnectClientException $e) {
	echo $e->getMessage();
}


?>
