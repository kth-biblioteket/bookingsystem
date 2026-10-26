<?php

// $Id$

// We use require for some files rather than require_once because the values that
// are assigned to variables will change depending on the context in which the file
// is called.

// KTH: Logga fatala fel oavsett inställningarna för error_reporting/log_errors i config.
// Utan detta ger ett PHP-fel bara ett tomt 500-svar utan spår i loggen (display_errors är av i drift).
register_shutdown_function(function () {
  $e = error_get_last();
  if ($e !== NULL && in_array($e['type'], array(E_ERROR, E_PARSE, E_CORE_ERROR, E_COMPILE_ERROR, E_USER_ERROR, E_RECOVERABLE_ERROR), TRUE)) {
    error_log('PHP FATAL (shutdown): ' . $e['message'] . ' in ' . $e['file'] . ':' . $e['line']);
  }
});

require_once "lib/autoload.inc";
require "grab_globals.inc.php";
require_once "systemdefaults.inc.php";
require_once "areadefaults.inc.php";
require_once "config.inc.php";
require_once "internalconfig.inc.php";
require_once "language.inc";
require_once "trailer.inc";
require_once "theme.inc";
require_once "functions.inc";
require_once "dbsys.inc";
require_once("password_compat/password.php");
require_once "mrbs_auth.inc";
require "standard_vars.inc.php";

