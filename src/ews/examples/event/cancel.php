<?php
/**
 * This example cancels a calendar event, sends a message to all attendees and
 * saves a copy of the message to the user's sent folder. Make sure to update
 * the event id and change key below to match those of the event you wish to
 * cancel. For this request, the change key is required.
 */
error_reporting(E_ALL);
ini_set('display_errors', 'on');

require_once '../../vendor/autoload.php';

use \jamesiarmes\PhpEws\Client;
use \jamesiarmes\PhpEws\Request\CreateItemType;

use \jamesiarmes\PhpEws\ArrayType\NonEmptyArrayOfAllItemsType;

use \jamesiarmes\PhpEws\Enumeration\MessageDispositionType;
use \jamesiarmes\PhpEws\Enumeration\ResponseClassType;

use \jamesiarmes\PhpEws\Type\CancelCalendarItemType;
use \jamesiarmes\PhpEws\Type\ItemIdType;

use \jamesiarmes\PhpEws\Request\FindItemType;
use \jamesiarmes\PhpEws\Enumeration\ItemQueryTraversalType;
use \jamesiarmes\PhpEws\Type\ItemResponseShapeType;
use \jamesiarmes\PhpEws\Type\CalendarViewType;
use \jamesiarmes\PhpEws\Enumeration\DefaultShapeNamesType;
use \jamesiarmes\PhpEws\Type\DistinguishedFolderIdType;
use \jamesiarmes\PhpEws\Enumeration\DistinguishedFolderIdNameType;
use \jamesiarmes\PhpEws\Type\EmailAddressType;


function getChangeKey($email, $start_date, $end_date, $event_id, $client) {
    $timezone = 'W. Europe Standard Time';
    $start_date->add(new DateInterval('PT1S'));
    $client->setTimezone($timezone);
    $request = new FindItemType();
    $request->Traversal = ItemQueryTraversalType::SHALLOW;
    $request->ItemShape = new ItemResponseShapeType();
    $request->ItemShape->BaseShape = DefaultShapeNamesType::ALL_PROPERTIES;

    echo $start_date->format('c');
    echo $end_date->format('c');

    $request->CalendarView = new CalendarViewType();
    $request->CalendarView->StartDate = $start_date->format('c');
    $request->CalendarView->EndDate = $end_date->format('c');
    $folder_id = new DistinguishedFolderIdType();
    $folder_id->Id = DistinguishedFolderIdNameType::CALENDAR;
    $folder_id->Mailbox = new EmailAddressType();
    $folder_id->Mailbox->EmailAddress = $email;
    $request->ParentFolderIds->DistinguishedFolderId[] = $folder_id;
    $response = $client->FindItem($request);

    $events_result = array();
    $response_messages = $response->ResponseMessages->FindItemResponseMessage;
    //print_r($response_messages);
    foreach ($response_messages as $response_message) {
        if ($response_message->ResponseClass != ResponseClassType::SUCCESS) {
            $code = $response_message->ResponseCode;
            $message = $response_message->MessageText;
            return "";
        }
        $items = $response_message->RootFolder->Items->CalendarItem;
        
        foreach ($items as $item) {
            $id = $item->ItemId->Id;
            //echo $id . "</br>";
            if($id==$event_id) {
                $events_result = $item->ItemId->ChangeKey;
                break;
            } else {
                $events_result = "";
            }
        }
    }
    return $events_result;
}

// Replace these values with those of the event you wish to cancel.
// Set connection information.
$ews_host = "webmail.kth.se";
$ews_user = 'system.lib-book@ug.kth.se';
$ews_password = 'Trh7feP5K1tfZ15uOEib';
$version = Client::VERSION_2013;

$client = new Client($ews_host, $ews_user, $ews_password, $version);

$start_date = new DateTime('October 29 00:00:00');
$end_date = new DateTime('October 29 16:00:00');
$event_id = 'AAMkADRiYTE5YjQ2LTlmZDctNDRlZC1hOGFmLTJhZjM5OGVmZjRlZABGAAAAAAD2RWe/q2yETaZPfM8IHJYBBwDt1MtZuw4DT48wxP1rjD7VAAAAAAENAADt1MtZuw4DT48wxP1rjD7VAAUl3ZAmAAA=';
$change_key = getChangeKey('ece-kthb-undervisningsschema@ug.kth.se', $start_date, $end_date, $event_id, $client);
echo $change_key;
exit();


$result = array();
/*
    if ($change_key != "") {
        $request = new CreateItemType();
        $request->MessageDisposition = MessageDispositionType::SEND_AND_SAVE_COPY;
        $request->Items = new NonEmptyArrayOfAllItemsType();

        $cancellation = new CancelCalendarItemType();
        $cancellation->ReferenceItemId = new ItemIdType();
        $cancellation->ReferenceItemId->Id = $event_id;
        $cancellation->ReferenceItemId->ChangeKey = $change_key;
        $request->Items->CancelCalendarItem[] = $cancellation;

        $response = $client->CreateItem($request);

        // Iterate over the results, printing any error messages or ids of events that
        // were updated.
        print_r($response);
        $response_messages = $response->ResponseMessages->CreateItemResponseMessage;
        foreach ($response_messages as $response_message) {
            if ($response_message->ResponseClass != ResponseClassType::SUCCESS) {
                $code = $response_message->ResponseCode;
                $message = $response_message->MessageText;
                $result['status'] = 'Error';
                $result['message'] = $message;
            }

            // Iterate over the created events, printing the id for each.
            foreach ($response_message->Items->CalendarItem as $item) {
                $result['status'] = 'OK';
                $result['message'] = 'Event Cancelled';
            }
        }
    }
    else {
        $result['status'] = 'Error';
        $result['message'] = 'Kunde inte avboka!';
    }
    print_r($result);

    */
