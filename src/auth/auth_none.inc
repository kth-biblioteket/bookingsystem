<?php

/* $Id$
 *
 * Dummy authentication scheme, that accepts any user.
 * Useful for using mrbs without authentication,
 * or in combination with a session scheme that already enforces
 * its own authentication. For example that in IIS.
 *
 * To use this authentication scheme set the following
 * things in config.inc.php:
 *
 *      $auth["type"]    = "none";
 *      $auth["session"] = your choice
 *
 * Then, you may configure admin users:
 *
 * $auth["admin"][] = "nt_username1";
 * $auth["admin"][] = "nt_username2";
 *
 * See AUTHENTICATION  for more informations.
 */

/** 
 * Checks if the specified username/password pair are valid.
 *
 * For this authentication scheme always validates.
 * 
 * @param   string  $user   The user name
 * @param   string  $pass   The password
 * @return  int             non-zero - Always valid
 */
 
 
 //KTH
 /**********
Funktion som hanterar felmeddelanden från ALMA

Exempel på Error från Alma:
<web_service_result xmlns="http://com/exlibris/urm/general/xmlbeans"><errorsexist>true</errorsexist><errorlist><error><errorcode>401851</errorcode><errormessage>User with identifier alma0005@almakth.se of type Primary id already exists.
(Tracking ID: E02-2005081805-4QVEB-AWAE2122010420)</errormessage></error></errorlist></web_service_result>

***********/
function checkifAlmaerror($response,$format) {
	$xml = simplexml_load_string($response);
	if (isset($xml)){
		//gör om XML till json
		$json = json_encode($xml);
	} else {
		//finns ingen XML i svaret så är det troligen JSON
		$json = $response;
	}
	$responsearray = json_decode($response,TRUE);
	if(!empty($responsearray['errorList'])) {
		//echo "error!!!";
		$result = "Error";
		$data = array(
			"result"  => $result,
			"message" => $responsearray['errorList']['error'][0]['errorMessage']
		);
	}
	else {
		$result = "Success";
		$data = array(
			"result"  => $result,
			"message" => "No Errors"
		);
	}
	$json_data = json_encode($data);
	$error = $json_data;	
	return $error ;
}

/********** 
191003
Funktion som hämtar autentiserar användare mot KTH LDAP 

**********/
function authenticateuser($user_id, $password) {
	global $ldap_api_key;
	global $ldap_api_url;
	global $environment;

	$data = array("username" => $user_id, "password" => $password);                                                                    
	$data_string = json_encode($data);
	$ch = curl_init();
	$url = $ldap_api_url . 'login';
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
	curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
	curl_setopt($ch, CURLOPT_POSTFIELDS, $data_string);
	curl_setopt($ch, CURLOPT_HTTPHEADER, array(                                                                          
		'Content-Type: application/json',                                                                                
		'Content-Length: ' . strlen($data_string))                                                                       
	);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
	$response = curl_exec($ch);
	if(curl_errno($ch)) {
		$json = '"error":{"Error connecting to loginserver."}' . curl_errno($ch);
		$error = $json;
		curl_close($ch);
		return $error;
	}
	curl_close($ch);
	return $response;
}

/********** 
Funktion som hämtar användare från LDAP

**********/
function getldapuser($user, $type) {
	global $ldap_api_key;
	global $ldap_api_url;
	global $environment;

	$ch = curl_init();
	$url = $ldap_api_url . $type . '/' . $user . '?token=' . $ldap_api_key;
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
	curl_setopt($ch, CURLOPT_HEADER, FALSE);
	curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'GET');
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
	$response = curl_exec($ch);
	if(curl_errno($ch)) {
		$json = '"error":{"Error connecting to ldap."}' . curl_errno($ch);
		$error = $json;
		curl_close($ch);
		return $error;
	}
	curl_close($ch);
	return $response;
}

/********** 

Funktion som autentiserar användare mot ALMA

**********/

function authenticate_almauser($user_id, $code, $type='password') {
	global $alma_api_key, $alma_api_url;
	global $environment;

	$url = $alma_api_url . 'users/' . $user_id;

	$ch = curl_init();
	if( $type == 'password') {
		$queryParams = '?' . urlencode('user_id_type') . '=' . urlencode('all_unique') . '&' . urlencode('op') . '=' . urlencode('auth') . '&' . urlencode('apikey') . '=' . urlencode($alma_api_key) . '&' . urlencode('format') . '=' . urlencode('json');

		curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
		curl_setopt($ch, CURLOPT_HTTPHEADER, array( 
			'Exl-User-Pw: ' . $code,                                                                                                                                         
		));
	}

	if( $type == 'pin') {
		$queryParams = '?' . urlencode('user_id_type') . '=' . urlencode('all_unique') . '&' . urlencode('view') . '=' . urlencode('full') . '&' . urlencode('apikey') . '=' . urlencode($alma_api_key) . '&' . urlencode('format') . '=' . urlencode('json');
		curl_setopt($ch, CURLOPT_HEADER, FALSE);
		curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'GET');
	}

	curl_setopt($ch, CURLOPT_URL, $url . $queryParams);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
	$response = curl_exec($ch);
	$http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
	curl_close($ch);

	if(curl_errno($ch)) {
		$json = '"errorList":{"error":[{"errorCode":"401861","errorMessage":"Error connecting to loginserver.","trackingId":"null"}]}';
		$data = array(
			"errorList"  => array('error' => array("errorCode" => "401861", 'errorMessage' => 'Error connecting to loginserver')),
			"message" => "Error connecting to loginserver"
		);
		$json_data = json_encode($data);
		$error = $json;
		return $error;
	}

	if ($http_status === 400) {
		$data = array(
			"errorList"  => array('error' => array("errorCode" => "400", 'errorMessage' => 'Bad Request')),
			"message" => "Error wrong password"
		);
		return json_encode($data);
	}
	return "success";
}

/********** 

Funktion som hämtar användarinformation från Alma utifrån angivet ID 

**********/
function getalmauser($user_id) {
	global $alma_api_key, $alma_api_url;
	$ch = curl_init();
	$url = $alma_api_url . 'users/' . $user_id;
	$queryParams = '?' . urlencode('user_id_type') . '=' . urlencode('all_unique') . '&' . urlencode('view') . '=' . urlencode('full') . '&' . urlencode('apikey') . '=' . urlencode($alma_api_key) . '&' . urlencode('format') . '=' . urlencode('json');
	curl_setopt($ch, CURLOPT_URL, $url . $queryParams);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
	curl_setopt($ch, CURLOPT_HEADER, FALSE);
	curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'GET');
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
	$response = curl_exec($ch);
	if(curl_errno($ch)) {
		$json = '"errorList":{"error":[{"errorCode":"401861","errorMessage":"Error connecting to loginserver.","trackingId":"null"}]}';
		$data = array(
			"errorList"  => array('error' => array("errorCode" => "401861", 'errorMessage' => 'Error connecting to loginserver')),
			"message" => "Error connecting to loginserver"
		);
		$json_data = json_encode($data);
		$error = $json;
		curl_close($ch);
		return $error;
	}
	curl_close($ch);
	return $response;
}

/***************
 * 
 * 
 * Validera att användaren finns i Alma
 * 
 * 
 */
function authValidateUser($user, $pass, $kthcas)
{
	//KTH
	global $auth, $ldap_user_domain, $alma_user_domain;
	global $allowedUserGroups, $allowedUGAffiliations, $environment;
	//anropa alma här (kth-konto/lånekort plus persnr)
	$returnvalue = 0;
	$result = 0; //0=Error 1=Success
	$valid_id = FALSE;
	if (strpos($user,"@" . $alma_user_domain) !== FALSE && !$kthcas && $auth["method"] != "alma") {
		$message = "Please do not write \"@" . $alma_user_domain . "\" in the KTH-account box";
	} else {
		//191003
		if ($auth["method"] != "kthcas" && $auth["method"] != "alma") {
			$ldapusertype = 'account';
			$almauser = $user . "@" . $alma_user_domain; //Primary Id i alma
		} else {
				$ldapusertype = 'kthid';
				$almauser = $user; //identifier i alma kth_id: u1f7tfgo
		}
		//Hämta användare från LDAP
		if ($auth["method"] != "alma") {
			$currentldapuser = getldapuser($user, $ldapusertype);
			$jsonldap = json_decode($currentldapuser);
		}
		
		//Hämta användare från Alma
		$currentuser = getalmauser($almauser);
		//Kontrollera om Alma returnerat ett fel (användaren finns inte t ex)
		$almaresponse = checkifAlmaerror($currentuser,"json");
		$jsonalmaresponse = json_decode($almaresponse);
		if ($jsonalmaresponse->result == "Error") {	
			$message = $jsonalmaresponse->message;
		} else {
			$source = json_decode($currentuser,TRUE);
			//kolla om angivet userid finns(Primary_id eller BARCODE eller UNIV_ID t ex "u1f7tfgo", kolla även personnummer)
			$primary_id = $source['primary_id'];
			$full_name = $source['full_name'];
			$user_group = $source['user_group']['desc'];
			if ($source['primary_id'] == $almauser) {
				$valid_id = TRUE;
			} else {
				foreach ($source['user_identifier'] as $value) {
					if($value['id_type']['value'] == "BARCODE" || $value['id_type']['value'] == "UNIV_ID" || $value['id_type']['value'] == "PERSONAL_NUMBER" || $value['id_type']['value'] == "OTHER_ID_3") {
						if ($value['value'] == $almauser) {
							$valid_id = TRUE;
						}
					}	
				}
			}
			//Email och phone
			$email_address = "";
			$phone_number = "";
			foreach ($source['contact_info']['email'] as $value) {
				if($value['preferred'] == "true") {
					$email_address = $value['email_address'];
				}	
			}
			foreach ($source['contact_info']['phone'] as $value) {
				if($value['preferred'] == "true") {
					$phone_number = $value['phone_number'];
				}	
			}
			//kolla om användaren tillhör en behörig user group (gäller inte adminusers, authGetUserLevel($primary_id) < 2)
			$checkusergroup = TRUE;

			if ($valid_id == TRUE && (authGetUserLevel($primary_id) < 2)) {
				if ($checkusergroup) {
					// Kontrollera mot alma
					if (!in_array($source['user_group']['value'], $allowedUserGroups)) {
						$result = 0; // ERROR!!
						$message = get_vocab("not_authorized");
						error_log($message);
						$valid_id = FALSE;
					}

					// Kontrollera även mot LDAP/UG
					// För de som t ex har gruppen staff i Alma men som också är student.
					// Utför inte för alma som loginmetod(interna alma-användare finns inte i LDAP)
					if ($valid_id == FALSE && $auth["method"] != "alma") {
						$allowedUGAffiliations = isset($allowedUGAffiliations) ? $allowedUGAffiliations : array();
						$commonaff = array_intersect($allowedUGAffiliations,$jsonldap->ugusers[0]->ugAffiliation);
						if (!empty($commonaff)) {
							$valid_id = TRUE;
						} else {
							$result = 0; // ERROR!!
							$message = get_vocab("not_authorized_UG");
							error_log($message . " Användare: " . $user . " Affiliation: " . implode(', ', $jsonldap->ugusers[0]->ugAffiliation));
							$valid_id = FALSE;
						}
					}
				}
			} else {
			}
			//Om login sker via KTH SSO SAML
			if ($valid_id == TRUE && $auth["method"] == "kthcas") {
				$result = 1; //SUCCESS!!
				$message = "Success";
			}
			//behörighetskontroll för bookingadmins = har aktiv roll "User Manager" i Alma
			//Så att lånediskpersonal kan administrera alla bokningar
			$admin_level = 1;
			foreach ($source['user_role'] as $value) {		
				//User Administrator
				if($value['role_type']['value'] == "50" && $value['status']['value'] == "ACTIVE") { 
					$admin_level = 3; //sysadmin
					$result = 1; //SUCCESS!!
					$message = "Success";
					break;
				}
				//User Manager
				if($value['role_type']['value'] == "21" && $value['status']['value'] == "ACTIVE") { 
					$admin_level = 2; //bookingadmin
					$result = 1; //SUCCESS!!
					$message = "Success";
				}	
			}
		}
		if ($valid_id == TRUE && $auth["method"] == "ldap") {
			$ldapuser = $user . "@" . $ldap_user_domain;
			$ldapresponse = authenticateuser($ldapuser, $pass);
			$ldapjson = json_decode($ldapresponse,TRUE);
			
			if($ldapjson["auth"]){
				$result = 1; //SUCCESS!!
				$message = "Success";
			} else {
				$result = 0; //ERROR!!
				$message = "Error, Wrong username/password " . $ldapjson["error"]["lde_message"];
			}
		}

		//Om login sker via Alma identifier
		if ($valid_id == TRUE && $auth["method"] == "alma") {
			if($auth["logintype"] == "pin") {
				if($source['pin_number'] == $pass) {
					$result = 1; //SUCCESS!!
					$message = "Success";

				} else {
					$result = 0; //ERROR!!
					$message = "Error, Wrong username/pin " . $ldapjson["error"]["lde_message"];
				}
			} else {
				$almaauth = authenticate_almauser($almauser, $pass);
				if($almaauth == "success") {
					$result = 1; //SUCCESS!!
					$message = "Success";
				} else {
					$result = 0; //ERROR!!
					$message = "Error, Wrong username/password " . $ldapjson["error"]["lde_message"];
				}
			}
		}
	}

	$data = array(
		"result"  => $result,
		"message" => $message,
		"primary_id" => $primary_id,
		"full_name" => $full_name,
		"email_address" => $email_address,
		"phone_number" => $phone_number,
		"user_group" => $user_group,
		"admin_level" => $admin_level
	);
	$json_data = json_encode($data);
	$returnvalue = $json_data;
	return $returnvalue;
	//original return
	//return 1;
}

//210811
function getAdminlevel()
{
  	//KTH Inloggning via LDAP(kthid)
  	global $auth;
	if (isset($_SESSION) && isset($_SESSION["admin_level"]) && ($_SESSION["admin_level"] !== ''))
		{
			return $_SESSION["admin_level"];
		}
		else
		{
			global $HTTP_SESSION_VARS;
			if (isset($HTTP_SESSION_VARS["admin_level"]) && ($HTTP_SESSION_VARS["admin_level"] !== ''))
			{
				return $HTTP_SESSION_VARS["admin_level"];
			}
		}
}

/* authGetUserLevel($user)
 * 
 * Determines the users access level
 * 
 * $user - The user name
 *
 * Returns:
 *   The users access level
 */
function authGetUserLevel($user)
{
	global $auth;
	$admins = $auth['admin'];
	//KTH
	$bookingadmins = $auth['bookingadmin'];
	// User not logged in, user level '0'
	if (!isset($user))
	{
		return 0;
	}

	// Check if the user is can modify
	for ($i = 0; isset($admins[$i]); $i++)
	{
		if (strcasecmp($user, $admins[$i]) == 0)
		{
		return 3;
		}
	}
  
  
  	//Check bookingadmin from session(ldap-login)

	if (getAdminlevel() == 2) {
		return 2;
	}
	if (getAdminlevel() == 3) {
		return 3;
	}

	// Check if the user is bookingadmin
	for ($i = 0; isset($bookingadmins[$i]); $i++)
	{
		if (strcasecmp($user, $bookingadmins[$i]) == 0)
		{
		return 2;
		}
	}

  // Everybody else is access level '1'
  return 1;
}


// Gets the user's email address.   Returns an empty
// string if one can't be found
function authGetUserEmail($user)
{
  if (!isset($user) || $user === '')
  {
    return '';
  }
  
  return get_default_email($user);
}