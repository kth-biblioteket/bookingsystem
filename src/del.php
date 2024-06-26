<?php
// $Id$

require "defaultincludes.inc";

// Get non-standard form variables
$type = get_form_var('type', 'string');
$confirm = get_form_var('confirm', 'string');
$instructor = get_form_var('instructor', 'int');
$place = get_form_var('place', 'int');
$email = get_form_var('email', 'string');
$closed_period = get_form_var('closed_period', 'int');


// Check the user is authorised for this page
checkAuthorised();

// This is gonna blast away something. We want them to be really
// really sure that this is what they want to do.

if ($type == "room")
{
  // We are supposed to delete a room
  if (isset($confirm))
  {
    // They have confirmed it already, so go blast!
    sql_begin();
    // First take out all appointments for this room
    sql_command("delete from $tbl_entry where room_id=$room");
    sql_command("delete from $tbl_repeat where room_id=$room");
   
    // Now take out the room itself
    sql_command("delete from $tbl_room where id=$room");
    sql_commit();
   
    // Go back to the admin page
    Header("Location: admin.php?area=$area");
  }
  else
  {
    print_header($day, $month, $year, $area, isset($room) ? $room : "");
   
    // We tell them how bad what they're about to do is
    // Find out how many appointments would be deleted
   
    $sql = "select name, start_time, end_time from $tbl_entry where room_id=$room";
    $res = sql_query($sql);
    if (! $res)
    {
      trigger_error(sql_error(), E_USER_WARNING);
      fatal_error(FALSE, get_vocab("fatal_db_error"));
    }
    else if (sql_count($res) > 0)
    {
      echo "<p>\n";
      echo get_vocab("deletefollowing") . ":\n";
      echo "</p>\n";
      
      echo "<ul>\n";
      
      for ($i = 0; ($row = sql_row_keyed($res, $i)); $i++)
      {
        echo "<li>".htmlspecialchars($row['name'])." (";
        echo time_date_string($row['start_time']) . " -> ";
        echo time_date_string($row['end_time']) . ")</li>\n";
      }
      
      echo "</ul>\n";
    }
   
    echo "<div id=\"del_room_confirm\">\n";
    echo "<p>" .  get_vocab("sure") . "</p>\n";
    echo "<div id=\"del_room_confirm_links\">\n";
    echo "<a href=\"del.php?type=room&amp;area=$area&amp;room=$room&amp;confirm=Y\"><span id=\"del_yes\">" . get_vocab("YES") . "!</span></a>\n";
    echo "<a href=\"admin.php\"><span id=\"del_no\">" . get_vocab("NO") . "!</span></a>\n";
    echo "</div>\n";
    echo "</div>\n";
    output_trailer();
  }
}

if ($type == "closed_periods")
{
  // We are supposed to delete a period
  if (isset($confirm))
  {
    // They have confirmed it already, so go blast!
    sql_begin();
   
    // Now take out the instructor itself
    sql_command("delete from mrbs_kth_closed_periods where id=$closed_period");
    sql_commit();
   
    // Go back to the admin page
    Header("Location: admin.php?area=$area");
  }
  else
  {
    print_header($day, $month, $year, $area, isset($room) ? $room : "");
   
    echo "<div id=\"del_room_confirm\">\n";
    echo "<p>" .  get_vocab("sure") . "</p>\n";
    echo "<div id=\"del_room_confirm_links\">\n";
    echo "<a href=\"del.php?type=closed_periods&amp;area=$area&amp;closed_period=$closed_period&amp;confirm=Y\"><span id=\"del_yes\">" . get_vocab("YES") . "!</span></a>\n";
    echo "<a href=\"admin.php\"><span id=\"del_no\">" . get_vocab("NO") . "!</span></a>\n";
    echo "</div>\n";
    echo "</div>\n";
    output_trailer();
  }
}

if ($type == "instructor")
{
  // We are supposed to delete an instructor
  if (isset($confirm))
  {
    // They have confirmed it already, so go blast!
    sql_begin();
    // First take out all appointments for this instructor
    sql_command("delete from $tbl_entry where instructor=$email");
    sql_command("delete from $tbl_repeat where instructor=$email");
   
    // Now take out the instructor itself
    sql_command("delete from kth_instructors where id=$instructor");
    sql_commit();
   
    // Go back to the admin page
    Header("Location: admin.php?area=$area");
  }
  else
  {
    print_header($day, $month, $year, $area, isset($room) ? $room : "");
   
    // We tell them how bad what they're about to do is
    // Find out how many appointments would be deleted
   
    $sql = "select name, start_time, end_time from $tbl_entry where instructor='$email'";
    $res = sql_query($sql);
    if (! $res)
    {
      trigger_error(sql_error(), E_USER_WARNING);
      fatal_error(FALSE, get_vocab("fatal_db_error"));
    }
    else if (sql_count($res) > 0)
    {
      echo "<p>\n";
      echo get_vocab("deletefollowing") . ":\n";
      echo "</p>\n";
      
      echo "<ul>\n";
      
      for ($i = 0; ($row = sql_row_keyed($res, $i)); $i++)
      {
        echo "<li>".htmlspecialchars($row['name'])." (";
        echo time_date_string($row['start_time']) . " -> ";
        echo time_date_string($row['end_time']) . ")</li>\n";
      }
      
      echo "</ul>\n";
    }
   
    echo "<div id=\"del_room_confirm\">\n";
    echo "<p>" .  get_vocab("sure") . "</p>\n";
    echo "<div id=\"del_room_confirm_links\">\n";
    echo "<a href=\"del.php?type=instructor&amp;area=$area&amp;instructor=$instructor&amp;email=$email&amp;confirm=Y\"><span id=\"del_yes\">" . get_vocab("YES") . "!</span></a>\n";
    echo "<a href=\"admin.php\"><span id=\"del_no\">" . get_vocab("NO") . "!</span></a>\n";
    echo "</div>\n";
    echo "</div>\n";
    output_trailer();
  }
}

if ($type == "place")
{
  // We are supposed to delete an instructor
  if (isset($confirm))
  {
    // They have confirmed it already, so go blast!
    sql_begin();
   
    // Now take out the instructor itself
    sql_command("delete from kth_places where id=$place");
    sql_commit();
   
    // Go back to the admin page
    Header("Location: admin.php?area=$area");
  }
  else
  {
    print_header($day, $month, $year, $area, isset($room) ? $room : "");
   
    echo "<div id=\"del_room_confirm\">\n";
    echo "<p>" .  get_vocab("sure") . "</p>\n";
    echo "<div id=\"del_room_confirm_links\">\n";
    echo "<a href=\"del.php?type=place&amp;area=$area&amp;place=$place&amp;confirm=Y\"><span id=\"del_yes\">" . get_vocab("YES") . "!</span></a>\n";
    echo "<a href=\"admin.php\"><span id=\"del_no\">" . get_vocab("NO") . "!</span></a>\n";
    echo "</div>\n";
    echo "</div>\n";
    output_trailer();
  }
}

if ($type == "area")
{
  // We are only going to let them delete an area if there are
  // no rooms. its easier
  $n = sql_query1("select count(*) from $tbl_room where area_id=$area");
  if ($n == 0)
  {
    // OK, nothing there, lets blast it away
    sql_command("delete from $tbl_area where id=$area");
   
    // Redirect back to the admin page
    header("Location: admin.php");
  }
  else
  {
    // There are rooms left in the area
    print_header($day, $month, $year, $area, isset($room) ? $room : "");
    echo "<p>\n";
    echo get_vocab("delarea");
    echo "<a href=\"admin.php\">" . get_vocab("backadmin") . "</a>";
    echo "</p>\n";
    output_trailer();
  }
}

