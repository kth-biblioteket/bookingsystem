<?php
// $Id$

// mrbs/week.php - Week-at-a-time view

require "defaultincludes.inc";
require_once "mincals.inc";
require_once "functions_table.inc";

// Get non-standard form variables
$timetohighlight = get_form_var('timetohighlight', 'int');
$ajax = get_form_var('ajax', 'int');
$ajaxuser = get_form_var('user', 'string');

//$times_along_top = get_times_along_top($area); //KTH
$times_along_top = FALSE; //alltid tider till vänster på veckovyn
unset($periods);
get_periods($area,$periods);

$inner_html = week_table_innerhtml($day, $month, $year, $room, $area, $timetohighlight, $ajaxuser);

if ($ajax)
{
  if (checkAuthorised(TRUE))
  {
    //191003
    //logga ut vid expire
    global $auth;
    if($auth['ajaxlogout'] == "TRUE" && isset($_SESSION['UserName']) && $_SESSION['UserName'] != ''){
      echo "ajaxlogout";
    } else {
      echo $inner_html;
    }
  }
  exit;
}

// Check the user is authorised for this page
checkAuthorised();

//KTH 
if(isset($_COOKIE["mrbslang"])) {
	if(isset($mrbslang)) {
		$lang = $mrbslang;
	} else {
		$lang = $_COOKIE["mrbslang"];
	}
}

// print the page header

print_header($day, $month, $year, $area, isset($room) ? $room : "");
// Section with areas, rooms, minicals.

echo "<div id=\"dwm_header\" class=\"screenonly\">\n";

//KTH visa bara arealänkar för de som har hide_links = 0
if(get_hide_links($area)) {

} else {
	// Show all available areas
	echo make_area_select_html('week.php', $area, $year, $month, $day);   
}

// Show all available rooms in the current area:
echo make_room_select_html('week.php', $area, $room, $year, $month, $day, $lang);

// Draw the three month calendars
if (!$display_calendar_bottom)
{
  //KTH Visa inte kalendrar
  //minicals($year, $month, $day, $area, $room, 'week');
}

echo "</div>\n";

//KTH Extra info
$extra_info = "";
$extra_info = get_area_extra_info($area,$lang);
if ($extra_info != "") {
  //Ta bort eventuella länkar för kioskdatorer
  if ($is_support_kiosk) {
    $extra_info = preg_replace("/<a\b[^>]*>/i", "<span>", $extra_info);
    $extra_info = str_replace("</a>", "</span>", $extra_info);
  }
	echo "<div id=\"extrainfo\" style=\"\">" . $extra_info ."</div>";
}

//y? are year, month and day of the previous week.
//t? are year, month and day of the next week.

$i= mktime(12,0,0,$month,$day-7,$year);
$yy = date("Y",$i);
$ym = date("m",$i);
$yd = date("d",$i);

$i= mktime(12,0,0,$month,$day+7,$year);
$ty = date("Y",$i);
$tm = date("m",$i);
$td = date("d",$i);

//KTH Modal box
//191003

get_area_settings($area);
echo "<div style=\"padding-bottom:10px;overflow:auto\">";
print_modal($area,$lang,$area_map,$area_map_image);
//200309 visa länk till nästa lediga bokning om bokningar är stängda som default
//hämta aktuell veckas sista slot och kolla om det finns lediga tider efter den
$currentviewdate = mktime(0, 0, 0, $month, $day, $year);
if (date('N',$currentviewdate == 7)) {
  $week_end = date('Y-m-d', strtotime('this week sunday', $currentviewdate));
} else {
  $week_end = date('Y-m-d', strtotime('this week next sunday', $currentviewdate));
}

$nextavailable = "";
if (!$default_bookings_open) {
  $next_start_time = get_next_available_start_time_room($room, $week_end);
  if ($next_start_time) {
    $nextavailable = "
    <div style=\"text-align:right\">
      <a class=\"btn btn-primary\" style=\"background-color: #d85497; color: #fff; border-color: #d85497\" href=\"week.php?year=" . date("Y",$next_start_time). 
            "&amp;month=". date("m",$next_start_time) . 
            "&amp;day=" .date("d",$next_start_time) . 
            "&amp;area=$area&amp;room=$room\">"
            .get_vocab("nextavailable").
          "</a>
    </div>\n";
  } else {
    $nextavailable = "
    <div style=\"text-align:right\">
      <button class=\"btn btn-info\" satyle=\"background-color: #d85497; color: #fff; border-color: #d85497\">"
            .get_vocab("noavailable").
      "</button>
    </div>\n";
  }
}
echo $nextavailable;
echo "</div>";
// Show area and room:
// Get the area and room names
$this_area_name = get_area_name($area);
$this_room_name = get_room_name($room, $lang);
$this_room_number = get_room_number($room, $lang);
//KTH capacity
$this_room_capacity = get_room_capacity($room);
// The room is invalid if it doesn't exist, or else it has been disabled, either explicitly
// or implicitly because the area has been disabled
if (!isset($this_area_name) || ($this_area_name === FALSE))
{
  $this_area_name = '';
}
if (!isset($this_room_name) || ($this_room_name === FALSE))
{
  $this_room_name = '';
}
//191003
//echo "<div id=\"dwm\">\n";
if ($this_room_number!="") {
	//echo "<h2>" .$this_room_number . ". " . $this_room_name;
} else {
	//echo "<h2>" . $this_room_name;
}
if ($this_room_capacity>0) {
	//echo "(" . $this_room_capacity. " " . get_vocab("seats") .")";
}
//echo "</h2>\n";
//KTH
$ctime = mktime(0, 0, 0, $month, $day, $year);
// How many days to skip back to first day of week:
$skipback = (date("w", $ctime) - $weekstarts + 7) % 7;
$ctime = mktime(0, 0, 0, $month, $day + 7 * 0 - $skipback, $year);
//echo "<h5>" . get_vocab("week") ." " . date("W", $ctime) . "(" . date("Y-m-d", $ctime) . " -- " . date("Y-m-d",strtotime( date("Y-m-d", $ctime). " +5 days")) . ")</h5>";
//echo "</div>\n";

// Show Go to week before and after links
//KTH
$before_after_links_html = "
<div class=\"before_after_links\">
  <div class=\"date_nav\">
    <div class=\"date_before\">
      <a href=\"week.php?year=$yy&amp;month=$ym&amp;day=$yd&amp;area=$area&amp;room=$room\">
          <img src=\"images/arrow-left-white-bold.png\" alt=\"Föregående vecka\"> ".get_vocab("weekbefore")."
      </a>
    </div>
    <div class=\"date_now\">
      <a href=\"week.php?area=$area&amp;room=$room\">"
        .get_vocab("gotothisweek").
      "</a>
    </div>
    <div class=\"date_after\">
      <a href=\"week.php?year=$ty&amp;month=$tm&amp;day=$td&amp;area=$area&amp;room=$room\">
          ".get_vocab("weekafter"). " <img src=\"images/arrow-right-white-bold.png\" alt=\"Nästa vecka\">
      </a>
    </div>
  </div>
</div>\n";
echo $before_after_links_html;
echo "<div class=\"wrapper\">\n";
echo "<table class=\"dwm_main\" id=\"week_main\" data-resolution=\"$resolution\">";
echo $inner_html; 
echo "</table>\n";
echo "</div>\n";

//KTH
//Rita upp egna färgkodningsnycklar
//show_colour_key();
show_colour_key_KTH();
// Draw the three month calendars
if ($display_calendar_bottom)
{
  //KTH Visa inte kalendrar
  //minicals($year, $month, $day, $area, $room, 'week');
}
echo "</div>\n"; // Slut contents
echo "</div>\n"; //Slut contentwrapper
// Print footer
print_footer(FALSE);

//KTH Hämta språk
if(isset($_COOKIE["mrbslang"])) {
	if(isset($mrbslang)) {
		$lang = $mrbslang;
	} else {
		$lang = $_COOKIE["mrbslang"];
	}
} 