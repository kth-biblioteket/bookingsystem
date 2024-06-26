<?php

// $Id$
require "defaultincludes.inc";
// Get non-standard form variables
$area_name = get_form_var('area_name', 'string');
$error = get_form_var('error', 'string');
// the image buttons:  need to specify edit_x rather than edit etc. because
// IE6 only returns _x and _y
$edit_x = get_form_var('edit_x', 'int');
$delete_x = get_form_var('delete_x', 'int');

// Check to see whether the Edit or Delete buttons have been pressed and redirect
// as appropriate
$std_query_string = "area=$area&day=$day&month=$month&year=$year";
if (isset($edit_x))
{
  $location = $location = "edit_area_room.php?change_area=1&phase=1&$std_query_string";
  header("Location: $location");
  exit;
}
if (isset($delete_x))
{
  $location = "del.php?type=area&$std_query_string";
  header("Location: $location");
  exit;
}
  
// Check the user is authorised for this page
checkAuthorised();
// Also need to know whether they have admin rights
$user = getUserName();
$required_level = (isset($max_level) ? $max_level : 2);
$is_admin = (authGetUserLevel($user) >= $required_level);

print_header($day, $month, $year, isset($area) ? $area : "", isset($room) ? $room : "");

// Get the details we need for this area
if (isset($area))
{ //KTH english
  $res = sql_query("SELECT area_name, custom_html, custom_html_en FROM $tbl_area WHERE id=$area LIMIT 1");
  if (! $res)
  {
    trigger_error(sql_error(), E_USER_WARNING);
    fatal_error(FALSE, get_vocab("fatal_db_error"));
  }
  if (sql_count($res) == 1)
  {
    $row = sql_row_keyed($res, 0);
    $area_name = $row['area_name'];
    $custom_html = $row['custom_html'];
	//KTH eng
	$custom_html_en = $row['custom_html_en'];
  }
  sql_free($res);
}


echo "<h2>" . get_vocab("administration") . "</h2>\n";
if (!empty($error))
{
  echo "<p class=\"error\">" . get_vocab($error) . "</p>\n";
}

// TOP SECTION:  THE FORM FOR SELECTING AN AREA
echo "<div id=\"area_form\">\n";
$sql = "SELECT id, area_name, disabled
          FROM $tbl_area
      ORDER BY disabled, area_name";
$res = sql_query($sql);
$areas_defined = $res && (sql_count($res) > 0);
if (!$areas_defined)
{
  echo "<p>" . get_vocab("noareas") . "</p>\n";
}
else
{
  // Build an array with the area info and also see if there are going
  // to be any areas to display (in other words rooms if you are not an
  // admin whether any areas are enabled)
  $areas = array();
  $n_displayable_areas = 0;
  for ($i = 0; ($row = sql_row_keyed($res, $i)); $i++)
  {
    $areas[] = $row;
    if ($is_admin || !$row['disabled'])
    {
      $n_displayable_areas++;
    }
  }

  if ($n_displayable_areas == 0)
  {
    echo "<p>" . get_vocab("noareas_enabled") . "</p>\n";
  }
  else
  {
    // If there are some areas displayable, then show the area form
    echo "<form id=\"areaChangeForm\" method=\"get\" action=\"" . htmlspecialchars(this_page()) . "\">\n";
    echo "<fieldset>\n";
    echo "<legend></legend>\n";
  
    // The area selector
    echo "<label id=\"area_label\" for=\"area_select\">" . get_vocab("area") . ":</label>\n";
    echo "<select class=\"room_area_select\" id=\"area_select\" name=\"area\" onchange=\"this.form.submit()\">";
    if ($is_admin)
    {
      if ($areas[0]['disabled'])
      {
        $done_change = TRUE;
        echo "<optgroup label=\"" . get_vocab("disabled") . "\">\n";
      }
      else
      {
        $done_change = FALSE;
        echo "<optgroup label=\"" . get_vocab("enabled") . "\">\n";
      }
    }
    foreach ($areas as $a)
    {
      if ($is_admin || !$a['disabled'])
      {
        if ($is_admin && !$done_change && $a['disabled'])
        {
          echo "</optgroup>\n";
          echo "<optgroup label=\"" . get_vocab("disabled") . "\">\n";
          $done_change = TRUE;
        }
        $selected = ($a['id'] == $area) ? "selected=\"selected\"" : "";
        echo "<option $selected value=\"". $a['id']. "\">" . htmlspecialchars($a['area_name']) . "</option>";
      }
    }
    if ($is_admin)
    {
      echo "</optgroup>\n";
    }
    echo "</select>\n";
  
    // Some hidden inputs for current day, month, year
    echo "<input type=\"hidden\" name=\"day\" value=\"$day\">\n";
    echo "<input type=\"hidden\" name=\"month\" value=\"$month\">\n";
    echo "<input type=\"hidden\" name=\"year\"  value=\"$year\">\n";
  
    // The change area button (won't be needed or displayed if JavaScript is enabled)
    echo "<input type=\"submit\" name=\"change\" class=\"js_none\" value=\"" . get_vocab("change") . "\">\n";
  
    // If they're an admin then give them edit and delete buttons for the area
    // and also a form for adding a new area
    if ($is_admin)
    {
      // Can't use <button> because IE6 does not support those properly
      echo "<input type=\"image\" class=\"button\" name=\"edit\" src=\"images/edit.png\"
             title=\"" . get_vocab("edit") . "\" alt=\"" . get_vocab("edit") . "\">\n";
      echo "<input type=\"image\" class=\"button\" name=\"delete\" src=\"images/delete.png\"
             title=\"" . get_vocab("delete") . "\" alt=\"" . get_vocab("delete") . "\">\n";
    }
  
    echo "</fieldset>\n";
    echo "</form>\n";
  }
}

if ($is_admin)
{
  // New area form
  ?>
  <form id="add_area" class="form_admin" action="add.php" method="post">
    <fieldset>
    <legend><?php echo get_vocab("addarea") ?></legend>
        
      <input type="hidden" name="type" value="area">

      <div>
        <label for="area_name"><?php echo get_vocab("name") ?>:</label>
        <input type="text" id="area_name" name="name" maxlength="<?php echo $maxlength['area.area_name'] ?>">
      </div>
          
      <div>
        <input type="submit" class="submit" value="<?php echo get_vocab("addarea") ?>">
      </div>

    </fieldset>
  </form>
  <?php
}
echo "</div>";  // area_form

// Now the custom HTML
echo "<div id=\"custom_html\">\n";
// no htmlspecialchars() because we want the HTML!
//echo (!empty($custom_html)) ? "$custom_html\n" : "";
echo "</div>\n";

echo "<div id=\"custom_html\">\n";
// no htmlspecialchars() because we want the HTML!
//echo (!empty($custom_html_en)) ? "$custom_html_en\n" : "";
echo "</div>\n";


// BOTTOM SECTION: ROOMS IN THE SELECTED AREA
// Only display the bottom section if the user is an admin or
// else if there are some areas that can be displayed
if ($is_admin || ($n_displayable_areas > 0))
{
  echo "<h2>\n";
  echo get_vocab("rooms");
  if(isset($area_name))
  { 
    echo " " . get_vocab("in") . " " . htmlspecialchars($area_name); 
  }
  echo "</h2>\n";

  echo "<div id=\"room_form\">\n";
  if (isset($area))
  {
    $res = sql_query("SELECT * FROM $tbl_room WHERE area_id=$area ORDER BY sort_key");
    if (! $res)
    {
      trigger_error(sql_error(), E_USER_WARNING);
      fatal_error(FALSE, get_vocab("fatal_db_error"));
    }
    if (sql_count($res) == 0)
    {
      echo "<p>" . get_vocab("norooms") . "</p>\n";
    }
    else
    {
       // Get the information about the fields in the room table
      $fields = sql_field_info($tbl_room);
    
      // Build an array with the room info and also see if there are going
      // to be any rooms to display (in other words rooms if you are not an
      // admin whether any rooms are enabled)
      $rooms = array();
      $n_displayable_rooms = 0;
      for ($i = 0; ($row = sql_row_keyed($res, $i)); $i++)
      {
        $rooms[] = $row;
        if ($is_admin || !$row['disabled'])
        {
          $n_displayable_rooms++;
        }
      }

      if ($n_displayable_rooms == 0)
      {
        echo "<p>" . get_vocab("norooms_enabled") . "</p>\n";
      }
      else
      {
        echo "<div id=\"room_info\" class=\"datatable_container\">\n";
        // Build the table.    We deal with the name and disabled columns
        // first because they are not necessarily the first two columns in
        // the table (eg if you are running PostgreSQL and have upgraded your
        // database)
        echo "<table id=\"rooms_table\" class=\"admin_table display\">\n";
        
        // The header
        echo "<thead>\n";
        echo "<tr>\n";

        echo "<th>" . get_vocab("name") . "</th>\n";
        if ($is_admin)
        {
        // Don't show ordinary users the disabled status:  they are only going to see enabled rooms
          echo "<th>" . get_vocab("enabled") . "</th>\n";
        }
        // ignore these columns, either because we don't want to display them,
        // or because we have already displayed them in the header column
		//KTH english
        $ignore = array('id', 'area_id', 'room_name', 'disabled', 'sort_key', 'custom_html', 'custom_html_en');
        foreach($fields as $field)
        {
          if (!in_array($field['name'], $ignore))
          {
            switch ($field['name'])
            {
              // the standard MRBS fields
              case 'description':
              case 'capacity':
              case 'room_admin_email':
                $text = get_vocab($field['name']);
                break;
              // any user defined fields
              default:
                $text = get_loc_field_name($tbl_room, $field['name']);
                break;
            }
            // We don't use htmlspecialchars() here because the column names are
            // trusted and some of them may deliberately contain HTML entities (eg &nbsp;)
            echo "<th>$text</th>\n";
          }
        }
        
        if ($is_admin)
        {
          echo "<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>\n";
        }
        
        echo "</tr>\n";
        echo "</thead>\n";
        
        // The body
        echo "<tbody>\n";
        $row_class = "odd";
        foreach ($rooms as $r)
        {
          // Don't show ordinary users disabled rooms
          if ($is_admin || !$r['disabled'])
          {
            $row_class = ($row_class == "even") ? "odd" : "even";
            echo "<tr class=\"$row_class\">\n";

            $html_name = htmlspecialchars($r['room_name']);
            // We insert an invisible span containing the sort key so that the rooms will
            // be sorted properly
            echo "<td><div>" .
                 "<span>" . htmlspecialchars($r['sort_key']) . "</span>" .
                 "<a title=\"$html_name\" href=\"edit_area_room.php?change_room=1&amp;phase=1&amp;room=" . $r['id'] . "\">$html_name</a>" .
                 "</div></td>\n";
            if ($is_admin)
            {
              // Don't show ordinary users the disabled status:  they are only going to see enabled rooms
              echo "<td class=\"boolean\"><div>" . ((!$r['disabled']) ? "<img src=\"images/check.png\" alt=\"check mark\" width=\"16\" height=\"16\">" : "&nbsp;") . "</div></td>\n";
            }
            foreach($fields as $field)
            {
              if (!in_array($field['name'], $ignore))
              {
                switch ($field['name'])
                {
                  // the standard MRBS fields
                  case 'description':
                  case 'room_admin_email':
                    echo "<td><div>" . htmlspecialchars($r[$field['name']]) . "</div></td>\n";
                    break;
                  case 'capacity':
                    echo "<td class=\"int\"><div>" . $r[$field['name']] . "</div></td>\n";
                    break;
                  // any user defined fields
                  default:
                    if (($field['nature'] == 'boolean') || 
                        (($field['nature'] == 'integer') && isset($field['length']) && ($field['length'] <= 2)) )
                    {
                      // booleans: represent by a checkmark
                      echo "<td class=\"boolean\"><div>";
                      echo (!empty($r[$field['name']])) ? "<img src=\"images/check.png\" alt=\"check mark\" width=\"16\" height=\"16\">" : "&nbsp;";
                      echo "</div></td>\n";
                    }
                    elseif (($field['nature'] == 'integer') && isset($field['length']) && ($field['length'] > 2))
                    {
                      // integer values
                      echo "<td class=\"int\"><div>" . $r[$field['name']] . "</div></td>\n";
                    }
                    else
                    {
                      // strings
                      $value = $r[$field['name']];
                      $html = "<td title=\"" . htmlspecialchars($value) . "\"><div>";
                      // Truncate before conversion, otherwise you could chop off in the middle of an entity
                      $html .= htmlspecialchars(utf8_substr($value, 0, $max_content_length));
                      $html .= (utf8_strlen($value) > $max_content_length) ? " ..." : "";
                      $html .= "</div></td>\n";
                      echo $html;
                    }
                    break;
                }  // switch
              }  // if
            }  // foreach
            
            // Give admins a delete link
            if ($is_admin)
            {
              // Delete link
              echo "<td><div>\n";
              echo "<a href=\"del.php?type=room&amp;area=$area&amp;room=" . $r['id'] . "\">\n";
              echo "<img src=\"images/delete.png\" width=\"16\" height=\"16\" 
                         alt=\"" . get_vocab("delete") . "\"
                         title=\"" . get_vocab("delete") . "\">\n";
              echo "</a>\n";
              echo "</div></td>\n";
            }
            
            echo "</tr>\n";
          }
        }

        echo "</tbody>\n";
        echo "</table>\n";
        echo "</div>\n";
        
      }
    }
  }
  else
  {
    echo get_vocab("noarea");
  }

  // Give admins a form for adding rooms to the area - provided 
  // there's an area selected
  if ($is_admin && $areas_defined && !empty($area))
  {
  ?>
    <form id="add_room" class="form_admin" action="add.php" method="post">
      <fieldset>
      <legend><?php echo get_vocab("addroom") ?></legend>
        
        <input type="hidden" name="type" value="room">
        <input type="hidden" name="area" value="<?php echo $area; ?>">
        
        <div>
          <label for="room_name"><?php echo get_vocab("name") ?>:</label>
          <input type="text" id="room_name" name="name" maxlength="<?php echo $maxlength['room.room_name'] ?>">
        </div>
        
        <div>
          <label for="room_description"><?php echo get_vocab("description") ?>:</label>
          <input type="text" id="room_description" name="description" maxlength="<?php echo $maxlength['room.description'] ?>">
        </div>
        
        <div>
          <label for="room_capacity"><?php echo get_vocab("capacity") ?>:</label>
          <input type="text" id="room_capacity" name="capacity">
        </div>
       
        <div>
          <input type="submit" class="submit" value="<?php echo get_vocab("addroom") ?>">
        </div>
        
      </fieldset>
    </form>
  <?php
  }
  echo "</div>\n";
}

// KTH
// BOTTOM SECTION: CLOSED_PERIODS IN THE SELECTED AREA
// Only display the bottom section if the user is an admin or
// else if there are some areas that can be displayed
if ($is_admin || ($n_displayable_areas > 0))
{
  echo "<h2>\n";
  echo get_vocab("closed_periods");
  if(isset($area_name))
  { 
    echo " " . get_vocab("in") . " " . htmlspecialchars($area_name); 
  }
  echo "</h2>\n";

  echo "<div id=\"closed_periods_form\">\n";
  if (isset($area))
  {
    $res = sql_query("SELECT id, from_date, to_date, description
                FROM mrbs_kth_closed_periods
                WHERE area_id = $area
                ORDER BY from_date");
    if (! $res)
    {
      trigger_error(sql_error(), E_USER_WARNING);
      fatal_error(FALSE, get_vocab("fatal_db_error"));
    }
    if (sql_count($res) == 0)
    {
      echo "<p>" . get_vocab("no_closed_periods") . "</p>\n";
    }
    else
    {
       // Get the information about the fields in the instructor table
      $fields = sql_field_info('mrbs_kth_closed_periods');
    
      // Build an array with the instructor info and also see if there are going
      // to be any instructors to display (in other words instructors if you are not an
      // admin whether any instructors are enabled)
      $closed_periods = array();
      $n_displayable_closed_periods = 0;
      for ($i = 0; ($row = sql_row_keyed($res, $i)); $i++)
      {
        $closed_periods[] = $row;
        if ($is_admin || !$row['disabled'])
        {
          $n_displayable_closed_periods++;
        }
      }

      if ($n_displayable_closed_periods == 0)
      {
        echo "<p>" . get_vocab("no_closed_periods_enabled") . "</p>\n";
      }
      else
      {
        echo "<div id=\"closed_periods_info\" class=\"datatable_container\">\n";
        // Build the table.    We deal with the name and disabled columns
        // first because they are not necessarily the first two columns in
        // the table (eg if you are running PostgreSQL and have upgraded your
        // database)
        echo "<table id=\"closed_periods_table\" class=\"admin_table display\">\n";
        
        // The header
        echo "<thead>\n";
        echo "<tr>\n";
        echo "<th>&nbsp;</th>\n";
        // ignore these columns, either because we don't want to display them,
        // or because we have already displayed them in the header column
		//KTH english
        $ignore = array('id', 'area_id');
        foreach($fields as $field)
        {
          if (!in_array($field['name'], $ignore))
          {
            switch ($field['name'])
            {
              // any user defined fields
              default:
                $text = get_loc_field_name('mrbs_kth_closed_periods', $field['name']);
                break;
            }
            // We don't use htmlspecialchars() here because the column names are
            // trusted and some of them may deliberately contain HTML entities (eg &nbsp;)
            echo "<th>$text</th>\n";
          }
        }
        
        if ($is_admin)
        {
          echo "<th>&nbsp;</th>\n";
        }
        
        echo "</tr>\n";
        echo "</thead>\n";
        
        // The body
        echo "<tbody>\n";
        $row_class = "odd";
        foreach ($closed_periods as $r)
        {
          if ($is_admin)
          {
            $row_class = ($row_class == "even") ? "odd" : "even";
            echo "<tr class=\"$row_class\">\n";

            echo "<td><div>" .
                 "<span>" . htmlspecialchars($r['sort_key']) . "</span>" .
                 "<a title=\"Uppdatera\" href=\"edit_closed_period.php?change_closed_period=1&amp;phase=1&amp;closed_period=" . $r['id'] . "\"><img src=\"images/edit.png\" width=\"16\" height=\"16\" 
                 alt=\"" . get_vocab("edit") . "\"
                 title=\"" . get_vocab("edit") . "\"></a>" .
                 "</div></td>\n";

            foreach($fields as $field)
            {
              if (!in_array($field['name'], $ignore))
              {
                switch ($field['name'])
                {
                  // any user defined fields
                  default:
                    if (($field['nature'] == 'boolean') || 
                        (($field['nature'] == 'integer') && isset($field['length']) && ($field['length'] <= 2)) )
                    {
                      // booleans: represent by a checkmark
                      echo "<td class=\"boolean\"><div>";
                      echo (!empty($r[$field['name']])) ? "<img src=\"images/check.png\" alt=\"check mark\" width=\"16\" height=\"16\">" : "&nbsp;";
                      echo "</div></td>\n";
                    }
                    elseif (($field['nature'] == 'integer') && isset($field['length']) && ($field['length'] > 2))
                    {
                      // integer values
                      echo "<td class=\"int\"><div>" . $r[$field['name']] . "</div></td>\n";
                    }
                    else
                    {
                      // strings
                      $value = $r[$field['name']];
                      $html = "<td title=\"" . htmlspecialchars($value) . "\"><div>";
                      // Truncate before conversion, otherwise you could chop off in the middle of an entity
                      $html .= htmlspecialchars(utf8_substr($value, 0, 250));
                      $html .= "</div></td>\n";
                      echo $html;
                    }
                    break;
                }  // switch
              }  // if
            }  // foreach
            
            // Give admins a delete link
            if ($is_admin)
            {
              // Delete link
              echo "<td><div>\n";
              echo "<a href=\"del.php?type=closed_periods&amp;area=$area&amp;closed_period=" . $r['id']. "\">\n";
              echo "<img src=\"images/delete.png\" width=\"16\" height=\"16\" 
                         alt=\"" . get_vocab("delete") . "\"
                         title=\"" . get_vocab("delete") . "\">\n";
              echo "</a>\n";
              echo "</div></td>\n";
            }
            
            echo "</tr>\n";
          }
        }

        echo "</tbody>\n";
        echo "</table>\n";
        echo "</div>\n";
        
      }
    }
  }
  else
  {
    echo get_vocab("noarea");
  }

  // Give admins a form for adding rooms to the area - provided 
  // there's an area selected
  if ($is_admin && $areas_defined && !empty($area))
  {
  ?>
    <form id="add_closed_periods" class="form_admin" action="add.php" method="post">
      <fieldset>
      <legend><?php echo get_vocab("add_closed_periods") ?></legend>
        
        <input type="hidden" name="type" value="closed_period">
        <input type="hidden" name="area" value="<?php echo $area; ?>">
        
        <div>
          <label for="description"><?php echo get_vocab("closed_periods_description") ?>:</label>
          <input type="text" id="description" name="description" maxlength="<?php echo $maxlength['closed_periods.description'] ?>">
        </div>
        
        <div>
          <label for="closed_periods_from_date"><?php echo get_vocab("closed_periods_from_date") ?>:</label>
          <input type="date" id="closed_periods_from_date" name="closed_periods_from_date" maxlength="<?php echo $maxlength['closed_periods.from_date'] ?>">
        </div>

        <div>
          <label for="closed_periods_to_date"><?php echo get_vocab("closed_periods_to_date") ?>:</label>
          <input type="date" id="closed_periods_to_date" name="closed_periods_to_date" maxlength="<?php echo $maxlength['closed_periods.to_date'] ?>">
        </div>
       
        <div>
          <input type="submit" class="submit" value="<?php echo get_vocab("add_closed_periods") ?>">
        </div>
        
      </fieldset>
    </form>
  <?php
  }
  echo "</div>\n";
}

// KTH
// BOTTOM SECTION: INSTRUCTORS IN THE SELECTED AREA
// Only display the bottom section if the user is an admin or
// else if there are some areas that can be displayed
if ($is_admin || ($n_displayable_areas > 0))
{
  echo "<h2>\n";
  echo get_vocab("instructors");
  if(isset($area_name))
  { 
    echo " " . get_vocab("in") . " " . htmlspecialchars($area_name); 
  }
  echo "</h2>\n";

  echo "<div id=\"instructor_form\">\n";
  if (isset($area))
  {
    $res = sql_query("SELECT id, full_name, email
                FROM kth_instructors
                WHERE area_id = $area
                ORDER BY full_name");
    if (! $res)
    {
      trigger_error(sql_error(), E_USER_WARNING);
      fatal_error(FALSE, get_vocab("fatal_db_error"));
    }
    if (sql_count($res) == 0)
    {
      echo "<p>" . get_vocab("noinstructors") . "</p>\n";
    }
    else
    {
       // Get the information about the fields in the instructor table
      $fields = sql_field_info('kth_instructors');
    
      // Build an array with the instructor info and also see if there are going
      // to be any instructors to display (in other words instructors if you are not an
      // admin whether any instructors are enabled)
      $instructors = array();
      $n_displayable_instructors = 0;
      for ($i = 0; ($row = sql_row_keyed($res, $i)); $i++)
      {
        $instructors[] = $row;
        if ($is_admin || !$row['disabled'])
        {
          $n_displayable_instructors++;
        }
      }

      if ($n_displayable_instructors == 0)
      {
        echo "<p>" . get_vocab("noinstructors_enabled") . "</p>\n";
      }
      else
      {
        echo "<div id=\"instructor_info\" class=\"datatable_container\">\n";
        // Build the table.    We deal with the name and disabled columns
        // first because they are not necessarily the first two columns in
        // the table (eg if you are running PostgreSQL and have upgraded your
        // database)
        echo "<table id=\"instructors_table\" class=\"admin_table display\">\n";
        
        // The header
        echo "<thead>\n";
        echo "<tr>\n";

        echo "<th>" . get_vocab("name") . "</th>\n";
        if ($is_admin)
        {
        // Don't show ordinary users the disabled status:  they are only going to see enabled instructors
          echo "<th>" . get_vocab("enabled") . "</th>\n";
        }
        // ignore these columns, either because we don't want to display them,
        // or because we have already displayed them in the header column
		//KTH english
        $ignore = array('id', 'area_id', 'full_name', 'disabled', 'sort_key');
        foreach($fields as $field)
        {
          if (!in_array($field['name'], $ignore))
          {
            switch ($field['name'])
            {
              // any user defined fields
              default:
                $text = get_loc_field_name('kth_instructors', $field['name']);
                break;
            }
            // We don't use htmlspecialchars() here because the column names are
            // trusted and some of them may deliberately contain HTML entities (eg &nbsp;)
            echo "<th>$text</th>\n";
          }
        }
        
        if ($is_admin)
        {
          echo "<th>&nbsp;</th>\n";
        }
        
        echo "</tr>\n";
        echo "</thead>\n";
        
        // The body
        echo "<tbody>\n";
        $row_class = "odd";
        foreach ($instructors as $r)
        {
          // Don't show ordinary users disabled instructors
          if ($is_admin || !$r['disabled'])
          {
            $row_class = ($row_class == "even") ? "odd" : "even";
            echo "<tr class=\"$row_class\">\n";

            $html_name = htmlspecialchars($r['full_name']);
            // We insert an invisible span containing the sort key so that the rooms will
            // be sorted properly
            echo "<td><div>" .
                 "<span>" . htmlspecialchars($r['sort_key']) . "</span>" .
                 "<a title=\"$html_name\" href=\"edit_instructor.php?change_instructor=1&amp;phase=1&amp;instructor=" . $r['id'] . "\">$html_name</a>" .
                 "</div></td>\n";
            if ($is_admin)
            {
              // Don't show ordinary users the disabled status:  they are only going to see enabled rooms
              echo "<td class=\"boolean\"><div>" . ((!$r['disabled']) ? "<img src=\"images/check.png\" alt=\"check mark\" width=\"16\" height=\"16\">" : "&nbsp;") . "</div></td>\n";
            }
            foreach($fields as $field)
            {
              if (!in_array($field['name'], $ignore))
              {
                switch ($field['name'])
                {
                  // any user defined fields
                  default:
                    if (($field['nature'] == 'boolean') || 
                        (($field['nature'] == 'integer') && isset($field['length']) && ($field['length'] <= 2)) )
                    {
                      // booleans: represent by a checkmark
                      echo "<td class=\"boolean\"><div>";
                      echo (!empty($r[$field['name']])) ? "<img src=\"images/check.png\" alt=\"check mark\" width=\"16\" height=\"16\">" : "&nbsp;";
                      echo "</div></td>\n";
                    }
                    elseif (($field['nature'] == 'integer') && isset($field['length']) && ($field['length'] > 2))
                    {
                      // integer values
                      echo "<td class=\"int\"><div>" . $r[$field['name']] . "</div></td>\n";
                    }
                    else
                    {
                      // strings
                      $value = $r[$field['name']];
                      $html = "<td title=\"" . htmlspecialchars($value) . "\"><div>";
                      // Truncate before conversion, otherwise you could chop off in the middle of an entity
                      $html .= htmlspecialchars(utf8_substr($value, 0, $max_content_length));
                      $html .= (utf8_strlen($value) > $max_content_length) ? " ..." : "";
                      $html .= "</div></td>\n";
                      echo $html;
                    }
                    break;
                }  // switch
              }  // if
            }  // foreach
            
            // Give admins a delete link
            if ($is_admin)
            {
              // Delete link
              echo "<td><div>\n";
              echo "<a href=\"del.php?type=instructor&amp;area=$area&amp;instructor=" . $r['id'] . "&amp;email=" . $r['email'] . "\">\n";
              echo "<img src=\"images/delete.png\" width=\"16\" height=\"16\" 
                         alt=\"" . get_vocab("delete") . "\"
                         title=\"" . get_vocab("delete") . "\">\n";
              echo "</a>\n";
              echo "</div></td>\n";
            }
            
            echo "</tr>\n";
          }
        }

        echo "</tbody>\n";
        echo "</table>\n";
        echo "</div>\n";
        
      }
    }
  }
  else
  {
    echo get_vocab("noarea");
  }

  // Give admins a form for adding rooms to the area - provided 
  // there's an area selected
  if ($is_admin && $areas_defined && !empty($area))
  {
  ?>
    <form id="add_instructor" class="form_admin" action="add.php" method="post">
      <fieldset>
      <legend><?php echo get_vocab("addinstructor") ?></legend>
        
        <input type="hidden" name="type" value="instructor">
        <input type="hidden" name="area" value="<?php echo $area; ?>">
        
        <div>
          <label for="full_name"><?php echo get_vocab("name") ?>:</label>
          <input type="text" id="full_name" name="name" maxlength="<?php echo $maxlength['instructor.full_name'] ?>">
        </div>
        
        <div>
          <label for="email"><?php echo get_vocab("instructoremail") ?>:</label>
          <input type="text" id="email" name="email" maxlength="<?php echo $maxlength['instructor.email'] ?>">
        </div>
       
        <div>
          <input type="submit" class="submit" value="<?php echo get_vocab("addinstructor") ?>">
        </div>
        
      </fieldset>
    </form>
  <?php
  }
  echo "</div>\n";
}

// KTH
// BOTTOM SECTION: PLACES IN THE SELECTED AREA
// Only display the bottom section if the user is an admin or
// else if there are some areas that can be displayed
if ($is_admin || ($n_displayable_areas > 0))
{
  echo "<h2>\n";
  echo get_vocab("places");
  if(isset($area_name))
  { 
    echo " " . get_vocab("in") . " " . htmlspecialchars($area_name); 
  }
  echo "</h2>\n";

  echo "<div id=\"place_form\">\n";
  if (isset($area))
  {
    $res = sql_query("SELECT kth_places.id, name, name_en, room_id, kth_places.disabled, kth_places.default_choice
                FROM kth_places
                INNER JOIN mrbs_room
                ON room_id = mrbs_room.id
                WHERE area_id = $area
                ORDER BY name");
    if (! $res)
    {
      trigger_error(sql_error(), E_USER_WARNING);
      fatal_error(FALSE, get_vocab("fatal_db_error"));
    }
    if (sql_count($res) == 0)
    {
      echo "<p>" . get_vocab("noplaces") . "</p>\n";
    }
    else
    {
       // Get the information about the fields in the places table
      $fields = sql_field_info('kth_places');
      // Build an array with the places info and also see if there are going
      // to be any places to display (in other words places if you are not an
      // admin whether any places are enabled)
      $places = array();
      $n_displayable_places = 0;
      for ($i = 0; ($row = sql_row_keyed($res, $i)); $i++)
      {
        $places[] = $row;
        if ($is_admin || !$row['disabled'])
        {
          $n_displayable_places++;
        }
      }

      if ($n_displayable_places == 0)
      {
        echo "<p>" . get_vocab("noplaces_enabled") . "</p>\n";
      }
      else
      {
        echo "<div id=\"places_info\" class=\"datatable_container\">\n";
        // Build the table.    We deal with the name and disabled columns
        // first because they are not necessarily the first two columns in
        // the table (eg if you are running PostgreSQL and have upgraded your
        // database)
        echo "<table id=\"places_table\" class=\"admin_table display\">\n";
        
        // The header
        echo "<thead>\n";
        echo "<tr>\n";

        echo "<th>" . get_vocab("name") . "</th>\n";
        if ($is_admin)
        {
        // Don't show ordinary users the disabled status:  they are only going to see enabled instructors
          echo "<th>" . get_vocab("enabled") . "</th>\n";
        }
        // ignore these columns, either because we don't want to display them,
        // or because we have already displayed them in the header column
		//KTH english
        $ignore = array('id', 'name', 'disabled', 'sort_key');
        foreach($fields as $field)
        {
          if (!in_array($field['name'], $ignore))
          {
            switch ($field['name'])
            {
              // any user defined fields
              default:
                $text = get_loc_field_name('kth_places', $field['name']);
                break;
            }
            // We don't use htmlspecialchars() here because the column names are
            // trusted and some of them may deliberately contain HTML entities (eg &nbsp;)
            echo "<th>$text</th>\n";
          }
        }
        
        if ($is_admin)
        {
          echo "<th>&nbsp;</th>\n";
        }
        
        echo "</tr>\n";
        echo "</thead>\n";
        
        // The body
        echo "<tbody>\n";
        $row_class = "odd";
        foreach ($places as $r)
        {
          // Don't show ordinary users disabled places
          if ($is_admin || !$r['disabled'])
          {
            $row_class = ($row_class == "even") ? "odd" : "even";
            echo "<tr class=\"$row_class\">\n";

            $html_name = htmlspecialchars($r['name']);
            // We insert an invisible span containing the sort key so that the places will
            // be sorted properly
            echo "<td><div>" .
                 "<span>" . htmlspecialchars($r['sort_key']) . "</span>" .
                 "<a title=\"$html_name\" href=\"edit_place.php?change_place=1&amp;phase=1&amp;place=" . $r['id'] . "\">$html_name</a>" .
                 "</div></td>\n";
            if ($is_admin)
            {
              // Don't show ordinary users the disabled status:  they are only going to see enabled places
              echo "<td class=\"boolean\"><div>" . ((!$r['disabled']) ? "<img src=\"images/check.png\" alt=\"check mark\" width=\"16\" height=\"16\">" : "&nbsp;") . "</div></td>\n";
            }
            foreach($fields as $field)
            {
              if (!in_array($field['name'], $ignore))
              {
                switch ($field['name'])
                {
                  // any user defined fields
                  default:
                    if (($field['nature'] == 'boolean') || 
                        (($field['nature'] == 'integer') && isset($field['length']) && ($field['length'] <= 2)) )
                    {
                      // booleans: represent by a checkmark
                      echo "<td class=\"boolean\"><div>";
                      echo (!empty($r[$field['name']])) ? "<img src=\"images/check.png\" alt=\"check mark\" width=\"16\" height=\"16\">" : "&nbsp;";
                      echo "</div></td>\n";
                    }
                    elseif (($field['nature'] == 'integer') && isset($field['length']) && ($field['length'] > 2))
                    {
                      // integer values
                      echo "<td class=\"int\"><div>" . $r[$field['name']] . "</div></td>\n";
                    }
                    else
                    {
                      // strings
                      $value = $r[$field['name']];
                      $html = "<td title=\"" . htmlspecialchars($value) . "\"><div>";
                      // Truncate before conversion, otherwise you could chop off in the middle of an entity
                      $html .= htmlspecialchars(utf8_substr($value, 0, $max_content_length));
                      $html .= (utf8_strlen($value) > $max_content_length) ? " ..." : "";
                      $html .= "</div></td>\n";
                      echo $html;
                    }
                    break;
                }  // switch
              }  // if
            }  // foreach
            
            // Give admins a delete link
            if ($is_admin)
            {
              // Delete link
              echo "<td><div>\n";
              echo "<a href=\"del.php?type=place&amp;area=$area&amp;room_id=" . $r['room_id'] . "&amp;place=" . $r['id'] . "\">\n";
              echo "<img src=\"images/delete.png\" width=\"16\" height=\"16\" 
                         alt=\"" . get_vocab("delete") . "\"
                         title=\"" . get_vocab("delete") . "\">\n";
              echo "</a>\n";
              echo "</div></td>\n";
            }
            
            echo "</tr>\n";
          }
        }

        echo "</tbody>\n";
        echo "</table>\n";
        echo "</div>\n";
        
      }
    }
  }
  else
  {
    echo get_vocab("noarea");
  }

  // Give admins a form for adding rooms to the area - provided 
  // there's an area selected
  if ($is_admin && $areas_defined && !empty($area))
  {
  ?>
    <form id="add_place" class="form_admin" action="add.php" method="post">
      <fieldset>
      <legend><?php echo get_vocab("addplace") ?></legend>
        
        <input type="hidden" name="type" value="place">
        <input type="hidden" name="area" value="<?php echo $area; ?>">
        
        <div>
          <label for="name"><?php echo get_vocab("name") ?>:</label>
          <input type="text" id="name" name="name" maxlength="<?php echo $maxlength['place.name'] ?>">
        </div>

        <div>
          <label for="room_id"><?php echo get_vocab("room_id") ?>:</label>
          <input type="text" id="room_id" name="room_id">
        </div>
       
        <div>
          <input type="submit" class="submit" value="<?php echo get_vocab("addplace") ?>">
        </div>
        
      </fieldset>
    </form>
  <?php
  }
  echo "</div>\n";
}

output_trailer();
