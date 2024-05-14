<?php
//copy of file "edit_area_room.php"

require "defaultincludes.inc";
require_once "mrbs_sql.inc";

// Get non-standard form variables
$phase = get_form_var('phase', 'int');
$new_area = get_form_var('new_area', 'int');
$old_area = get_form_var('old_area', 'int');
$closed_period = get_form_var('closed_period', 'string');
$description = get_form_var('description', 'string');
$from_date = get_form_var('from_date', 'string');
$to_date = get_form_var('to_date', 'string');
$area_name = get_form_var('area_name', 'string');

$change_done = get_form_var('change_done', 'string');
$change_closed_period = get_form_var('change_closed_period', 'string');
$change_area = get_form_var('change_area', 'string');

// Get the information about the fields in the instructor table
$fields = sql_field_info('mrbs_kth_closed_periods');

// Get any user defined form variables
foreach($fields as $field)
{
  switch($field['nature'])
  {
    case 'character':
      $type = 'string';
      break;
    case 'integer':
      $type = 'int';
      break;
    // We can only really deal with the types above at the moment
    default:
      $type = 'string';
      break;
  }
  $var = VAR_PREFIX . $field['name'];
  $$var = get_form_var($var, $type);
  if (($type == 'int') && ($$var === ''))
  {
    unset($$var);
  }
}

// Check the user is authorised for this page
checkAuthorised();

// Also need to know whether they have admin rights
$user = getUserName();
$required_level = (isset($max_level) ? $max_level : 2);
$is_admin = (authGetUserLevel($user) >= $required_level);

// Done changing instructor information?
if (isset($change_done))
{
  if (!empty($closed_period)) // Get the area the instructor is in
  {
    $area = mrbsGetRoomArea($closed_period);
  }
  Header("Location: admin.php?day=$day&month=$month&year=$year&area=$area");
  exit();
}

$valid_area = TRUE;

// PHASE 2
// -------
if ($phase == 2)
{
  // Unauthorised users shouldn't normally be able to reach Phase 2, but just in case
  // they have, check again that they are allowed to be here
  if (isset($change_closed_period) || isset($change_area))
  {
    if (!$is_admin)
    {
      showAccessDenied($day, $month, $year, $area, "");
      exit();
    }
  }
  
  require_once "functions_mail.inc";

  // PHASE 2 (INSTRUCTOR) - UPDATE THE DATABASE
  // ------------------------------------
  if($environment == 'development') {
    error_log("change_closed_period: " . $change_closed_period);
    error_log("Closed period: " . $closed_period);
  }
  if (isset($change_closed_period) && !empty($closed_period))
  {
      // Acquire a mutex to lock out others who might be deleting the new area
      if (!sql_mutex_lock("$tbl_area"))
      {
        fatal_error(TRUE, get_vocab("failed_to_acquire"));
      }
      // Check the new area still exists
      if (sql_query1("SELECT COUNT(*) FROM $tbl_area WHERE id=$new_area LIMIT 1") < 1)
      {
        $valid_area = FALSE;
      }
      // If so
      // check that the instructor name is not already used in the area
      // (only do this if you're changing the instructor name or the area - if you're
      // just editing the other details for an existing instructor we don't want to reject
      // the edit because the instructor already exists!)
      // [SQL escaping done by sql_syntax_casesensitive_equals()]
      // If everything is still OK, update the databasae
      else
      {
        // Convert booleans into 0/1 (necessary for PostgreSQL)
        $sql = "UPDATE mrbs_kth_closed_periods SET ";
        $n_fields = count($fields);
        $assign_array = array();
        foreach ($fields as $field)
        {
          if ($field['name'] != 'id')  // don't do anything with the id field
          {
            switch ($field['name'])
            {
              // first of all deal with the standard MRBS fields
              case 'area_id':
                $assign_array[] = "area_id=$new_area";
                break;
              case 'description':
                $assign_array[] = "description='" . sql_escape($description) . "'";
                break;
              case 'from_date':
                $assign_array[] = "from_date='" . sql_escape($from_date) . "'";
                break;
              case 'to_date':
                $assign_array[] = "to_date='" . sql_escape($to_date) . "'";
                break;
              // then look at any user defined fields
              default:
                $var = VAR_PREFIX . $field['name'];
                switch ($field['nature'])
                {
                  case 'integer':
                    if (!isset($$var) || ($$var === ''))
                    {
                      // Try and set it to NULL when we can because there will be cases when we
                      // want to distinguish between NULL and 0 - especially when the field
                      // is a genuine integer.
                      $$var = ($field['is_nullable']) ? 'NULL' : 0;
                    }
                    break;
                  default:
                    $$var = "'" . sql_escape($$var) . "'";
                    break;
                }
                $assign_array[] = sql_quote($field['name']) . "=" . $$var;
                break;
            }
          }
        }
        
        $sql .= implode(",", $assign_array) . " WHERE id=$closed_period";
        if($environment == 'development') {
          error_log($sql);
        }
        if (sql_command($sql) < 0)
        {
          echo get_vocab("update_closed_period_failed") . "<br>\n";
          trigger_error(sql_error(), E_USER_WARNING);
          fatal_error(FALSE, get_vocab("fatal_db_error"));
        }
        // if everything is OK, release the mutex and go back to
        // the admin page (for the new area)
        sql_mutex_unlock("$tbl_area");
        Header("Location: admin.php?day=$day&month=$month&year=$year&area=$new_area");
        exit();
      }
    
      // Release the mutex
      sql_mutex_unlock("$tbl_area");
  }
}

// PHASE 1 - GET THE USER INPUT
// ----------------------------

print_header($day, $month, $year, isset($area) ? $area : "", isset($room) ? $room : "");

if ($is_admin)
{
  // Heading is confusing for non-admins
  echo "<h2>" . get_vocab("edit_closed_period") . "</h2>\n";
}

// Non-admins will only be allowed to view  details, not change them
$disabled = !$is_admin;

// THE CLOSED PERIODS FORM
if (isset($change_closed_period) && !empty($closed_period))
{
  $res = sql_query("SELECT * FROM mrbs_kth_closed_periods WHERE id=$closed_period LIMIT 1");
  if (! $res)
  {
    fatal_error(0, get_vocab("error_closed_period") . $room . get_vocab("not_found"));
  }
  $row = sql_row_keyed($res, 0);

  ?>
  <form class="form_general" id="edit_closed_period" action="edit_closed_period.php" method="post">
    <fieldset class="admin">
    <legend></legend>
  
      <fieldset>
      <legend></legend>
        <span class="error">
           <?php 
           // It's impossible to have more than one of these error messages, so no need to worry
           // about paragraphs or line breaks.
           echo ((FALSE == $valid_area) ? get_vocab('invalid_area') : "");
           ?>
        </span>
      </fieldset>
    
      <fieldset>
      <legend></legend>
      <input type="hidden" name="closed_period" value="<?php echo $row["id"]?>">
    
      <?php
      $areas = get_areas($all=TRUE);
      if (empty($areas))
      {
        fatal_error(FALSE, get_vocab('noareas'));  // should not happen
      }
      
      // The area select box
      echo "<div>\n";
      $params = array('label'         => get_vocab("area") . ":",
                      'name'          => 'new_area',
                      'options'       => $areas,
                      'force_assoc'   => TRUE,
                      'value'         => $row['area_id'],
                      'disabled'      => $disabled,
                      'create_hidden' => FALSE);
      generate_select($params);
      echo "<input type=\"hidden\" name=\"old_area\" value=\"" . $row['area_id'] . "\">\n";
      echo "</div>\n";
      
      // First of all deal with the standard MRBS fields

      // From date
      echo "<div>\n";
      $params = array('label'         => get_vocab("closed_period_from_date") . ":",
                      'name'          => 'from_date',
                      'value'         => $row['from_date'],
                      'disabled'      => $disabled,
                      'create_hidden' => FALSE);
      generate_input($params);
      echo "</div>\n";

      // To date
      echo "<div>\n";
      $params = array('label'         => get_vocab("closed_period_to_date") . ":",
                      'name'          => 'to_date',
                      'value'         => $row['to_date'],
                      'disabled'      => $disabled,
                      'create_hidden' => FALSE);
      generate_input($params);
      echo "</div>\n";

      // Description
      echo "<div>\n";
      $params = array('label'         => get_vocab("closed_period_description") . ":",
                      'name'          => 'description',
                      'value'         => $row['description'],
                      'disabled'      => $disabled,
                      'create_hidden' => FALSE);
      generate_input($params);
      echo "<input type=\"hidden\" name=\"old_description\" value=\"" . htmlspecialchars($row["description"]) . "\">\n";
      echo "</div>\n";
    
      // Submit and Back buttons (Submit only if they're an admin)  
      echo "<fieldset class=\"submit_buttons\">\n";
      echo "<legend></legend>\n";
      echo "<div id=\"edit_area_room_submit_back\">\n";
      echo "<input class=\"submit\" type=\"submit\" name=\"change_done\" value=\"" . get_vocab("backadmin") . "\">\n";
      echo "</div>\n";
      if ($is_admin)
      { 
        echo "<div id=\"edit_area_room_submit_save\">\n";
        echo "<input type=\"hidden\" name=\"phase\" value=\"2\">";
        echo "<input class=\"submit default_action\" type=\"submit\" name=\"change_closed_period\" value=\"" . get_vocab("change") . "\">\n";
        echo "</div>\n";
      }
      echo "</fieldset>\n";
        
      ?>
    </fieldset>
  </form>

  <?php
}

output_trailer();

