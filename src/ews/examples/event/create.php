<?php

error_reporting(E_ALL);
ini_set('display_errors', 'on');

//inkluderar hjälpklass för mailfunktioner
require_once($_SERVER['DOCUMENT_ROOT'] . '/PHPMailer/PHPMailerAutoload.php');
require_once($_SERVER['DOCUMENT_ROOT'] . '/ews/vendor/autoload.php');

//require_once '../../vendor/autoload.php';

use \jamesiarmes\PhpEws\Client;
use \jamesiarmes\PhpEws\Request\CreateItemType;

use \jamesiarmes\PhpEws\ArrayType\NonEmptyArrayOfAllItemsType;
use \jamesiarmes\PhpEws\ArrayType\NonEmptyArrayOfAttendeesType;

use \jamesiarmes\PhpEws\Enumeration\BodyTypeType;
use \jamesiarmes\PhpEws\Enumeration\CalendarItemCreateOrDeleteOperationType;
use \jamesiarmes\PhpEws\Enumeration\ResponseClassType;
use \jamesiarmes\PhpEws\Enumeration\RoutingType;

use \jamesiarmes\PhpEws\Type\AttendeeType;
use \jamesiarmes\PhpEws\Type\BodyType;
use \jamesiarmes\PhpEws\Type\CalendarItemType;
use \jamesiarmes\PhpEws\Type\EmailAddressType;

use \jamesiarmes\PhpEws\Request\FindItemType;
use \jamesiarmes\PhpEws\Enumeration\ItemQueryTraversalType;
use \jamesiarmes\PhpEws\Type\ItemResponseShapeType;
use \jamesiarmes\PhpEws\Type\CalendarViewType;
use \jamesiarmes\PhpEws\Enumeration\DefaultShapeNamesType;
use \jamesiarmes\PhpEws\Type\DistinguishedFolderIdType;
use \jamesiarmes\PhpEws\Enumeration\DistinguishedFolderIdNameType;

use \jamesiarmes\PhpEws\ArrayType\NonEmptyArrayOfBaseFolderIdsType;
use \jamesiarmes\PhpEws\Type\TargetFolderIdType;


function checkroomavailability($email_room, $start_date, $end_date, $client) {
    $timezone = 'W. Europe Standard Time';
    //Europe/Stockholm
    $start_date->add(new DateInterval('PT1S'));
    $client->setTimezone($timezone);
    $request = new FindItemType();
    $request->Traversal = ItemQueryTraversalType::SHALLOW;
    $request->ItemShape = new ItemResponseShapeType();
    $request->ItemShape->BaseShape = DefaultShapeNamesType::ALL_PROPERTIES;

    $request->CalendarView = new CalendarViewType();
    echo $start_date->format('c'). "<br>";
    $request->CalendarView->StartDate = $start_date->format('c');
    $request->CalendarView->EndDate = $end_date->format('c');
    $folder_id = new DistinguishedFolderIdType();
    $folder_id->Id = DistinguishedFolderIdNameType::CALENDAR;
    $folder_id->Mailbox = new EmailAddressType();
    $folder_id->Mailbox->EmailAddress = $email_room;
    $request->ParentFolderIds->DistinguishedFolderId[] = $folder_id;
    $response = $client->FindItem($request);
    $response_messages = $response->ResponseMessages->FindItemResponseMessage;
    foreach ($response_messages as $response_message) {
        // Make sure the request succeeded.
        if ($response_message->ResponseClass != ResponseClassType::SUCCESS) {
            $code = $response_message->ResponseCode;
            $message = $response_message->MessageText;
            return "Failed to search for events with \"$code: $message\"";
        }
        $items = $response_message->RootFolder->Items->CalendarItem;
        if (count($items)>0) {
            foreach ($items as $item) {
                $id = $item->ItemId->Id;
                $change_key = $item->ItemId->ChangeKey;
                $title = $item->Subject;
                echo $item->Start . " " . $title . "<br>";
                echo $item->End . " " . $title . "<br>";
            }
            return false;
        } else {
            return true;
        }
        /*
        $events_result = [];
        foreach ($items as $item) {
            $id = $item->ItemId->Id;
            $change_key = $item->ItemId->ChangeKey;
            $title = $item->Subject;
            echo $item->Start . " " . $title . "<br>";
        }
        */
    }
}


// Replace this with your desired start/end times and guests.
//$email_room = 'ece_arc_lise_meitner@ug.kth.se';
$email_room = 'ece-kthb-undervisningsschema@ug.kth.se';
$start = new DateTime('2019-10-11 03:00');
$end = new DateTime('2019-10-11 04:00');
$guests = array(
    array(
        'name' => 'Thomas Lind',
        'email' => 'tholind@ug.kth.se',
    )
   
);

// Set connection information.
$host = 'webmail.kth.se';
$username = 'tholind@ug.kth.se';
$password = '';
$version = Client::VERSION_2013;

$client = new Client($host, $username, $password, $version);

$roomavailability = checkroomavailability($email_room, $start, $end, $client);
if($roomavailability) {
    echo "available";
} else {
    echo "busy";
}

//exit;

/*
$mail = new PHPMailer;
$mail->isSMTP();
$mail->Host ='smtp.kth.se';
$mail->SMTPAuth   = FALSE;
$mail->SMTPSecure = "tls";
$mail->CharSet = 'UTF-8';

// event params
$event_id = 1234;
$sequence = 0;
$status = 'TENTATIVE';

$summary = 'Summary';
$venue = 'KTHB ';
$start = '20191008';
$start_time = '170000';
$end = '20191008';
$end_time = '180000';

//PHPMailer
$mail->IsHTML(false);
$mail->setFrom('tholind@kth.se', 'Thomas Lind');
$mail->addReplyTo('tholind@kth.se', 'Thomas Lind');
$mail->addAddress('tholind@kth.se','T L');
$mail->ContentType = 'text/calendar';

$mail->Subject = "Outlooked Event";
$mail->addCustomHeader('MIME-version',"1.0");
$mail->addCustomHeader('Content-type',"text/calendar; method=REQUEST; charset=UTF-8");
$mail->addCustomHeader('Content-Transfer-Encoding',"7bit");
$mail->addCustomHeader('X-Mailer',"Microsoft Office Outlook 12.0");
$mail->addCustomHeader("Content-class: urn:content-classes:calendarmessage");

$ical = "BEGIN:VCALENDAR\r\n";
$ical .= "VERSION:2.0\r\n";
$ical .= "PRODID:-KTHB\r\n";
$ical .= "METHOD:REQUEST\r\n";
$ical .= "BEGIN:VEVENT\r\n";
$ical .= "ORGANIZER;SENT-BY=\"MAILTO:tholind@kth.se\":MAILTO:tholind@kth.se\r\n";
$ical .= "ATTENDEE;CN=tholind@kth.se;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE:mailto:tholind@kth.se\r\n";
$ical .= "ATTENDEE;CN=uf_kthb_geisendorf@ug.kth.se;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE:uf_kthb_geisendorf@ug.kth.se\r\n";
$ical .= "UID:".strtoupper(md5($event_id))."-lib.kth.se\r\n";
$ical .= "SEQUENCE:".$sequence."\r\n";
$ical .= "STATUS:".$status."\r\n";
$ical .= "DTSTAMPTZID=Europe/Stockholm:".date('Ymd').'T'.date('His')."\r\n";
$ical .= "DTSTART:".$start."T".$start_time."\r\n";
$ical .= "DTEND:".$end."T".$end_time."\r\n";
$ical .= "LOCATION:".$venue."\r\n";
$ical .= "SUMMARY:".$summary."\r\n";
$ical .= "DESCRIPTION:"."TEST!"."\r\n";
$ical .= "BEGIN:VALARM\r\n";
$ical .= "TRIGGER:-PT15M\r\n";
$ical .= "ACTION:DISPLAY\r\n";
$ical .= "DESCRIPTION:Reminder\r\n";
$ical .= "END:VALARM\r\n";
$ical .= "END:VEVENT\r\n";
$ical .= "END:VCALENDAR\r\n";

$mail->Body = $ical;

if($mail->Send()){
    echo 'Success';
}else{
    echo $mail->ErrorInfo;
}
*/

//exit;

// Build the request,
$request = new CreateItemType();
//$request->SendMeetingInvitations = CalendarItemCreateOrDeleteOperationType::SEND_ONLY_TO_ALL;
$request->SendMeetingInvitations = CalendarItemCreateOrDeleteOperationType::SEND_TO_NONE;

$request->Items = new NonEmptyArrayOfAllItemsType();

// Build the event to be added.
$event = new CalendarItemType();
//$event->RequiredAttendees = new NonEmptyArrayOfAttendeesType();
$event->Start = $start->format('c');
$event->End = $end->format('c');
$event->Subject = 'Test';

// Set the event body.
$event->Body = new BodyType();
$event->Body->_ = 'Bla bla bla';
$event->Body->BodyType = BodyTypeType::TEXT;

// Iterate over the guests, adding each as an attendee to the request.
foreach ($guests as $guest) {
    $attendee = new AttendeeType();
    $attendee->Mailbox = new EmailAddressType();
    $attendee->Mailbox->EmailAddress = $guest['email'];
    $attendee->Mailbox->Name = $guest['name'];
    $attendee->Mailbox->RoutingType = RoutingType::SMTP;
    //$event->RequiredAttendees->Attendee[] = $attendee;
}

// Add the event to the request. You could add multiple events to create more
// than one in a single request.

$request->Items->CalendarItem[] = $event;

//Skapa i annan kalender(som inloggad har tillgång till)
$request->SavedItemFolderId = new TargetFolderIdType();
$request->SavedItemFolderId->DistinguishedFolderId = new DistinguishedFolderIdType();
$request->SavedItemFolderId->DistinguishedFolderId->Id=DistinguishedFolderIdNameType::CALENDAR;
$request->SavedItemFolderId->DistinguishedFolderId->Mailbox = new stdClass();
$request->SavedItemFolderId->DistinguishedFolderId->Mailbox->EmailAddress = "ece-kthb-undervisningsschema@ug.kth.se";

$response = $client->CreateItem($request);
// Iterate over the results, printing any error messages or event ids.
$response_messages = $response->ResponseMessages->CreateItemResponseMessage;
print_r("<pre>" . json_encode($response) . "</pre>");
foreach ($response_messages as $response_message) {
    //echo "<br>" . $response_message->ConflictingMeetingCount . "<br>";
    // Make sure the request succeeded.
    if ($response_message->ResponseClass != ResponseClassType::SUCCESS) {
        $code = $response_message->ResponseCode;
        $message = $response_message->MessageText;
        echo("Event failed to create with \"$code: $message\"\n");
        continue;
    }

    // Iterate over the created events, printing the id for each.
    foreach ($response_message->Items->CalendarItem as $item) {
        $id = $item->ItemId->Id;
        echo ("Created event $id <br>");
        echo("ChangeKey: " . $item->ItemId->ChangeKey);
    }
}
