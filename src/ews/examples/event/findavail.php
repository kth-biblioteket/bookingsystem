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

use \jamesiarmes\PhpEws\Request\GetUserAvailabilityRequestType;
use \jamesiarmes\PhpEws\Type\FreeBusyViewOptionsType;
use \jamesiarmes\PhpEws\ArrayType\ArrayOfMailboxData;
use \jamesiarmes\PhpEws\Type\Duration;
use \jamesiarmes\PhpEws\Enumeration\FreeBusyViewType;
use \jamesiarmes\PhpEws\Type\MailboxData;

// Set connection information.
$host = 'webmail.kth.se';
$username = 'tholind@ug.kth.se';
$password = '';
$version = Client::VERSION_2013;

$email = 'ece-kthb-undervisningsschema@ug.kth.se';
$start_date = new DateTime('2019-10-28 10:00:01');
$end_date = new DateTime('2019-10-28 11:00:00');
$timezone = 'W. Europe Standard Time';
$client = new Client($host, $username, $password, $version);
$start_date->add(new DateInterval('PT1S'));
$client->setTimezone($timezone);
$request = new FindItemType();
$request->Traversal = ItemQueryTraversalType::SHALLOW;
$request->ItemShape = new ItemResponseShapeType();
$request->ItemShape->BaseShape = DefaultShapeNamesType::ALL_PROPERTIES;

$request->CalendarView = new CalendarViewType();
$request->CalendarView->StartDate = $start_date->format('c');
$request->CalendarView->EndDate = $end_date->format('c');
$folder_id = new DistinguishedFolderIdType();
$folder_id->Id = DistinguishedFolderIdNameType::CALENDAR;
$folder_id->Mailbox = new EmailAddressType();
$folder_id->Mailbox->EmailAddress = $email;
$request->ParentFolderIds->DistinguishedFolderId[] = $folder_id;
$response = $client->FindItem($request);
print'<pre>';
print_r($response);
print'</pre>';
$response_messages = $response->ResponseMessages->FindItemResponseMessage;
foreach ($response_messages as $response_message) {
    if ($response_message->ResponseClass != ResponseClassType::SUCCESS) {
        $code = $response_message->ResponseCode;
        $message = $response_message->MessageText;
        //return "Failed to search for events with \"$code: $message\"";
    }

    $items = $response_message->RootFolder->Items->CalendarItem;
    if (count($items)>0) {
        $available = false;
        foreach ($items as $item) { 
            if (strpos($item->Start,"00:00:00")){
                $available = true;
            } else {
                //return false;
                $available = false;
                break;
            }
        }
        //return $available;
        echo "count>0 " . $available;
    } else {
        echo "count<0 " . true;
        //return true;
    }
}

/*
$email = 'ece_arc_lise_meitner@ug.kth.se';
$start = new DateTime('2019-10-24 16:00:01');
$end = new DateTime('2019-10-24 17:00:00');
$timezone = 'W. Europe Standard Time';
$client = new Client($host, $username, $password, $version);
//$client->setCurlOptions(array(CURLOPT_SSL_VERIFYPEER => false));
$client->setTimezone($timezone);
// Build the request.
$request = new GetUserAvailabilityRequestType();
$request->FreeBusyViewOptions = new FreeBusyViewOptionsType();
$request->MailboxDataArray = new ArrayOfMailboxData();

// Define the time window and details to return.
$request->FreeBusyViewOptions->TimeWindow = new Duration();
$request->FreeBusyViewOptions->TimeWindow->StartTime = $start->format('c');
$request->FreeBusyViewOptions->TimeWindow->EndTime = $end->format('c');
$request->FreeBusyViewOptions->MergedFreeBusyIntervalInMinutes = '30';
$request->FreeBusyViewOptions->RequestedView = FreeBusyViewType::DETAILED;

// Add the user to get availability for.
$mailbox = new MailboxData();
$mailbox->Email = new EmailAddressType();
$mailbox->Email->Address = $email;
$mailbox->Email->RoutingType = 'SMTP';
$mailbox->AttendeeType = 'Required';
$mailbox->ExcludeConflicts = false;
$request->MailboxDataArray->MailboxData[] = $mailbox;

$response = $client->GetUserAvailability($request);
print'<pre>';
print_r($response);
print'</pre>';
*/