<?php

error_reporting(E_ALL);
ini_set('display_errors', 'on');

require_once '../../vendor/autoload.php';

use \jamesiarmes\PhpEws\Client;
use \jamesiarmes\PhpEws\Request\FindItemType;

use \jamesiarmes\PhpEws\ArrayType\NonEmptyArrayOfBaseFolderIdsType;

use \jamesiarmes\PhpEws\Enumeration\DefaultShapeNamesType;
use \jamesiarmes\PhpEws\Enumeration\DistinguishedFolderIdNameType;
use \jamesiarmes\PhpEws\Enumeration\ResponseClassType;

use \jamesiarmes\PhpEws\Type\CalendarViewType;
use \jamesiarmes\PhpEws\Type\DistinguishedFolderIdType;
use \jamesiarmes\PhpEws\Type\ItemResponseShapeType;

use \jamesiarmes\PhpEws\Enumeration\ItemQueryTraversalType;

use \jamesiarmes\PhpEws\Type\EmailAddressType;

// Replace with the date range you want to search in. As is, this will find all
// events within the current calendar year.
$start_date = new DateTime('October 15 12:00:01');
$end_date = new DateTime('October 15 17:00:00');
$timezone = 'W. Europe Standard Time';

// Set connection information.
$host = 'webmail.kth.se';
$username = 'tholind@ug.kth.se';
$password = '';
$version = Client::VERSION_2013;

$client = new Client($host, $username, $password, $version);
$client->setTimezone($timezone);

$request = new FindItemType();
$request->Traversal = ItemQueryTraversalType::SHALLOW;
$request->ParentFolderIds = new NonEmptyArrayOfBaseFolderIdsType();

// Return all event properties.
$request->ItemShape = new ItemResponseShapeType();
$request->ItemShape->BaseShape = DefaultShapeNamesType::ALL_PROPERTIES;

$folder_id = new DistinguishedFolderIdType();
$folder_id->Id = DistinguishedFolderIdNameType::CALENDAR;

/* rum */
$email_room = "tholind@ug.kth.se";
//$email_room = "ece_arc_lise_meitner@ug.kth.se";
$email_room = "ece-biblioteket@ug.kth.se";
$email_room = "ece-kthb-undervisningsschema@ug.kth.se";
$folder_id->Mailbox = new EmailAddressType();
$folder_id->Mailbox->EmailAddress = $email_room;

$request->ParentFolderIds->DistinguishedFolderId[] = $folder_id;

$request->CalendarView = new CalendarViewType();
$request->CalendarView->StartDate = $start_date->format('c');
$request->CalendarView->EndDate = $end_date->format('c');

$response = $client->FindItem($request);

// Iterate over the results, printing any error messages or event ids.
$response_messages = $response->ResponseMessages->FindItemResponseMessage;
foreach ($response_messages as $response_message) {
    // Make sure the request succeeded.
    if ($response_message->ResponseClass != ResponseClassType::SUCCESS) {
        $code = $response_message->ResponseCode;
        $message = $response_message->MessageText;
        echo(
            
            "Failed to search for events with \"$code: $message\"\n"
        );
        continue;
    }

    // Iterate over the events that were found, printing some data for each.
    $items = $response_message->RootFolder->Items->CalendarItem;
    foreach ($items as $item) {
        $id = $item->ItemId->Id;
        $start = new DateTime($item->Start);
        $end = new DateTime($item->End);
        $output = 'Found event ' . $item->ItemId->Id . "<br>"
            . '  Change Key: ' . $item->ItemId->ChangeKey . "<br>"
            . '  Title: ' . $item->Subject . "<br>"
            . '  Start: ' . $start->format('l, F jS, Y g:ia') . "<br>"
            . '  End:   ' . $end->format('l, F jS, Y g:ia') . "<br><br>";

        echo($output);
        if($id=='AAMkADRiYTE5YjQ2LTlmZDctNDRlZC1hOGFmLTJhZjM5OGVmZjRlZABGAAAAAAD2RWe/q2yETaZPfM8IHJYBBwDt1MtZuw4DT48wxP1rjD7VAAAAAAENAADt1MtZuw4DT48wxP1rjD7VAAQmmUEtAAA=') {
            echo $item->ItemId->ChangeKey;
        } else {
            echo "noooooooo";
        }
    }
}
