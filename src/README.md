# KTHB Bokningssystem
För Grupprum, handledning, talböcker, CAS mm

Open Source MRBS
- Version 1.5.0
## Funktioner

### config.inc.php: ###
```
$timezone = 

/*******************
 * Database settings
 ******************/
$dbsys =
$db_host =
$db_database =
$db_login =
$db_password =
$db_tbl_prefix =

/*******************
 * Exchange settings
 ******************/
$ews_host =
$ews_user =
$ews_password =

/*********************************
 * Site identification information
 *********************************/
$mrbs_admin =
$mrbs_admin_email =

$mrbs_company =
$mrbs_company_logo =
$app_name =
$is_kiosk =
$url_base =
$alma_api_key =
$alma_api_url =
$alma_user_domain =
$ldap_api_key =
$ldap_api_url =
$ldap_user_domain =

//Typ av bokningssätt
//alla tider bokningsbara eller otillgängliga som default (type för bokningsbar tid = "B")
$default_bookings_open =

/******************
 * Display settings
 ******************/
$weekstarts = 1;
$hidden_days = array(0,6);
$year_range['back'] = 1;
$year_range['ahead'] = 1;
$refresh_rate = 15;
$ajax_refresh_rate = 15;
$view_week_number = TRUE;
$times_along_top = TRUE;
$default_view = 0;
$default_room = 1;$rotate_room_names = FALSE;

// Text när en area är "avstängd"

$vocab_override['sv']["no_rooms_for_area"]  = "Med anledning av de skärpta allmänna råden i Stockholm är grupprummen stängda för bokning tills vidare";
$vocab_override['en']["no_rooms_for_area"]  = "Due to the stricter general guidelines in Stockholm, the group rooms are closed until further notice";

/***********************************************
 * Authentication settings - read AUTHENTICATION
 ***********************************************/
$auth["session"] =
$auth["type"] =
$session_name =

ini_set('session.gc_maxlifetime', (60*60*2)); //2 timmar

$auth["session_php"]["session_expire_time"] =
if ($is_kiosk) {
    $auth["session_php"]["inactivity_expire_time"] =
} else {
    $auth["session_php"]["inactivity_expire_time"] =
}

unset($auth["admin"]);
$auth["admin"][] =
$auth['bookingadmin'][] =
unset($auth["user"]):
$max_level =

$auth['only_admin_can_book_repeat'] =
$auth['only_admin_can_book_multiday'] =
$auth['only_admin_can_select_multiroom'] =
$auth['only_admin_can_select_area'] =

$booking_types[] = (C, B)

$vocab_override['sv']['mrbs'] =
$vocab_override['en']['mrbs'] =

$currenturl =

$mail_settings['area_admin_on_bookings'] =
$mail_settings['booker'] = 
$mail_settings['on_new'] =
$mail_settings['on_change'] =
$mail_settings['on_delete'] =
$mail_settings['details'] =
$mail_settings['html'] = 
$mail_settings['admin_lang'] =
$mail_settings['admin_backend'] =

$smtp_settings['host'] =

$mail_settings['from'] =

$vocab_override['sv']['mail_from_address_default'] =
$vocab_override['en']['mail_from_address_default'] =
$vocab_override['sv']['mail_from_address_kthb'] =
$vocab_override['en']['mail_from_address_kthb'] =
$vocab_override['sv']['mail_from_address_cas'] =
$vocab_override['en']['mail_from_address_cas'] =

$kth_www =
$cas_server =
```
