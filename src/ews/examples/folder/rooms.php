<?php
error_reporting(E_ALL);
ini_set('display_errors', 'on');

require_once '../../vendor/autoload.php';

use \jamesiarmes\PhpEws\Client;

use \jamesiarmes\PhpEws\ArrayType\NonEmptyArrayOfBaseFolderIdsType;

use \jamesiarmes\PhpEws\Enumeration\ContainmentComparisonType;
use \jamesiarmes\PhpEws\Enumeration\ContainmentModeType;
use \jamesiarmes\PhpEws\Enumeration\DefaultShapeNamesType;
use \jamesiarmes\PhpEws\Enumeration\DistinguishedFolderIdNameType;
use \jamesiarmes\PhpEws\Enumeration\FolderQueryTraversalType;
use \jamesiarmes\PhpEws\Enumeration\ResponseClassType;
use \jamesiarmes\PhpEws\Enumeration\UnindexedFieldURIType;

use \jamesiarmes\PhpEws\Type\ConstantValueType;
use \jamesiarmes\PhpEws\Type\DistinguishedFolderIdType;
use \jamesiarmes\PhpEws\Type\FolderResponseShapeType;
use \jamesiarmes\PhpEws\Type\PathToUnindexedFieldType;
use \jamesiarmes\PhpEws\Type\RestrictionType;

use \jamesiarmes\PhpEws\Type\IndexedPageViewType;
use \jamesiarmes\PhpEws\Type\EmailAddressType;
use \jamesiarmes\PhpEws\Type\FolderIdType;
use \jamesiarmes\PhpEws\Request\FindItemType;

use \jamesiarmes\PhpEws\Enumeration\ItemQueryTraversalType;
use \jamesiarmes\PhpEws\Type\ItemResponseShapeType;
use \jamesiarmes\PhpEws\Type\CalendarViewType;

// Set connection information.
$host = 'webmail.kth.se';
//$username = 'testtl@ug.kth.se';
//$password = 'TLTestar2016';
$version = Client::VERSION_2013;

$client = new Client($host, $username, $password, $version);


$email_room = "ece_arc_lise_meitner@ug.kth.se";
$email_room = "uf-kthb_infopunkt@ug.kth.se";
$email_room = "uf-kthb_digital_kundtjanst@ug.kth.se";
$email_room = "ece-biblioteket@ug.kth.se";
$start_date = new DateTime('l j 00:00:00');
$end_date = new DateTime('December 31 23:59:59');

//$start_date = new DateTime('tomorrow 5:00pm');
//$end_date = new DateTime('tomorrow 6:00pm');
echo $start_date->format('c');
echo "<br>";
echo $end_date->format('c');
echo "<br>";
//echo date('Y-m-d H:i:s') . "<br>";
$timezone = 'Central European Standard Time';
//Europe/Stockholm
$client->setTimezone($timezone);
//echo date('Y-m-d H:i:s') . "<br>";
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
$folder_id->Mailbox->EmailAddress = $email_room;
$request->ParentFolderIds->DistinguishedFolderId[] = $folder_id;
$response = $client->FindItem($request);
$response_messages = $response->ResponseMessages->FindItemResponseMessage;
//var_dump($response_messages);
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
    $events_result = [];
    foreach ($items as $item) {
        $id = $item->ItemId->Id;
        $change_key = $item->ItemId->ChangeKey;
        $title = $item->Subject;
        echo $item->Start . " " . $title . "<br>";
        echo "Item id:  " . $id . "<br>";
    }
}
?>