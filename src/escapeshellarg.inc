<?php

/* $Id$
 *
 * Included if your PHP version is less than 4.0.3 and therefore this
 * function doesn't exist.
 *
 */

if (!function_exists('escapeshellarg'))
{
  function escapeshellarg($x)
  {
    return "'".preg_replace("/'/", "\\'", $x)."'";
  }
}

