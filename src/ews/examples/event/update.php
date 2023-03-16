<?php

error_reporting(E_ALL);
ini_set('display_errors', 'on');
/**
 * This example shows how to update the start and end times for one or more
 * calendar items. This example could be updated to to include updates for any
 * field on the event.
 */
require_once($_SERVER['DOCUMENT_ROOT'] . '/ews/vendor/autoload.php');

use \jamesiarmes\PhpEws\Client;
use \jamesiarmes\PhpEws\Request\UpdateItemType;

use \jamesiarmes\PhpEws\ArrayType\NonEmptyArrayOfItemChangeDescriptionsType;

use \jamesiarmes\PhpEws\Enumeration\CalendarItemUpdateOperationType;
use \jamesiarmes\PhpEws\Enumeration\ConflictResolutionType;
use \jamesiarmes\PhpEws\Enumeration\ResponseClassType;
use \jamesiarmes\PhpEws\Enumeration\UnindexedFieldURIType;

use \jamesiarmes\PhpEws\Type\CalendarItemType;
use \jamesiarmes\PhpEws\Type\ItemChangeType;
use \jamesiarmes\PhpEws\Type\ItemIdType;
use \jamesiarmes\PhpEws\Type\PathToUnindexedFieldType;
use \jamesiarmes\PhpEws\Type\SetItemFieldType;

// Replace with the events to be updated along with their new start and end
// times.

$result = array();
$event_updates = array(
    array(
        'id' => 'AAMkADRiYTE5YjQ2LTlmZDctNDRlZC1hOGFmLTJhZjM5OGVmZjRlZABGAAAAAAD2RWe/q2yETaZPfM8IHJYBBwDt1MtZuw4DT48wxP1rjD7VAAAAAAENAADt1MtZuw4DT48wxP1rjD7VAAQmmUE1AAA=',
        'start' => new DateTime('today 4:00pm'),
        'end' => new DateTime('today 5:00pm'),
        'subject' => 'Uppdaterad!!',
    )
);

// Set connection information.
// Set connection information.
$host = 'webmail.kth.se';
$username = 'tholind@ug.kth.se';
$password = '';
$version = Client::VERSION_2013;

$client = new Client($host, $username, $password, $version);

// Build the request.
$request = new UpdateItemType();
$request->ConflictResolution = ConflictResolutionType::ALWAYS_OVERWRITE;
$request->SendMeetingInvitationsOrCancellations = CalendarItemUpdateOperationType::SEND_TO_ALL_AND_SAVE_COPY;

// Iterate over the updated to be applied, adding each to the request.
foreach ($event_updates as $update) {
    // Build out item change request.
    $change = new ItemChangeType();
    $change->ItemId = new ItemIdType();
    $change->ItemId->Id = $update['id'];
    $change->Updates = new NonEmptyArrayOfItemChangeDescriptionsType();

    // Set the updated start time.
    
    $field = new SetItemFieldType();
    $field->FieldURI = new PathToUnindexedFieldType();
    $field->FieldURI->FieldURI = UnindexedFieldURIType::CALENDAR_START;
    $field->CalendarItem = new CalendarItemType();
    $field->CalendarItem->Start = $update['start']->format('c');
    $change->Updates->SetItemField[] = $field;

    // Set the updated end time.
    $field = new SetItemFieldType();
    $field->FieldURI = new PathToUnindexedFieldType();
    $field->FieldURI->FieldURI = UnindexedFieldURIType::CALENDAR_END;
    $field->CalendarItem = new CalendarItemType();
    $field->CalendarItem->End = $update['end']->format('c');
    $change->Updates->SetItemField[] = $field;

    // Set the updated end time.
    $field = new SetItemFieldType();
    $field->FieldURI = new PathToUnindexedFieldType();
    $field->FieldURI->FieldURI = UnindexedFieldURIType::ITEM_SUBJECT;
    $field->CalendarItem = new CalendarItemType();
    $field->CalendarItem->Subject = $update['subject'];
    $change->Updates->SetItemField[] = $field;

    $request->ItemChanges[] = $change;
}

$response = $client->UpdateItem($request);

$response_messages = $response->ResponseMessages->UpdateItemResponseMessage;
print_r($response); 
    foreach ($response_messages as $response_message) {
        if ($response_message->ResponseClass != ResponseClassType::SUCCESS) {
            $code = $response_message->ResponseCode;
            $message = $response_message->MessageText;
            $result['status'] = 'Error';
            $result['message'] = $message;
            echo "Error";
        } else {
            foreach ($response_message->Items->CalendarItem as $item) {
                $id = $item->ItemId->Id;
                $result['status'] = 'OK';
                $result['message'] = 'Event Updated';
                $result['event_id'] = $id;
                echo "OK";
            }
        }
    }
    print_r($result); 