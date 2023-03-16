<?php
/**
 * This example recursively searches the user's mailbox for all folders that
 * contain "Cal" (case sensitive).
 */
error_reporting(E_ALL);
ini_set('display_errors', 'on');

require_once '../../vendor/autoload.php';

use \jamesiarmes\PhpEws\Client;
use \jamesiarmes\PhpEws\Request\FindFolderType;

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

// Set connection information.
$host = 'webmail.kth.se';
$username = 'tholind@ug.kth.se';
$password = '';
$version = Client::VERSION_2013;

$client = new Client($host, $username, $password, $version);

// Build the request.

/*
$check_req = new FindItemType();
$check_req->ParentFolderIds = new NonEmptyArrayOfBaseFolderIdsType();

    $room_df = new DistinguishedFolderIdType();
    $room_df->Id = DistinguishedFolderIdNameType::CALENDAR;
    $room_df->Mailbox = new EmailAddressType();
    $room_df->Mailbox->EmailAddress = 'tholind@ug.kth.se';
    $check_req->ParentFolderIds->DistinguishedFolderId[] = $room_df;
print_r($check_req);
*/


$request = new FindFolderType();
$request->FolderShape = new FolderResponseShapeType();
$request->FolderShape->BaseShape = DefaultShapeNamesType::ALL_PROPERTIES;
$request->ParentFolderIds = new NonEmptyArrayOfBaseFolderIdsType();
$request->Restriction = new RestrictionType();

// Search recursively.
$request->Traversal = FolderQueryTraversalType::DEEP;

// Search within the root folder. Combined with the traversal set above, this
// should search through all folders in the user's mailbox.
$parent = new DistinguishedFolderIdType();
$parent->Id = DistinguishedFolderIdNameType::ROOT;

$parent->Mailbox = new EmailAddressType();
$parent->Mailbox->EmailAddress = 'uf_kthb_geisendorf@ug.kth.se';
$request->ParentFolderIds->DistinguishedFolderId[] = $parent;

// Build the restriction that will search for folders containing "Cal".
$contains = new \jamesiarmes\PhpEws\Type\ContainsExpressionType();
$contains->FieldURI = new PathToUnindexedFieldType();
$contains->FieldURI->FieldURI = UnindexedFieldURIType::FOLDER_DISPLAY_NAME;

$contains->Constant = new ConstantValueType();
$contains->Constant->Value = 'a';
$contains->ContainmentComparison = ContainmentComparisonType::IGNORE_CASE;
$contains->ContainmentMode = ContainmentModeType::SUBSTRING;
$request->Restriction->Contains = $contains;

$response = $client->FindFolder($request);

// Iterate over the results, printing any error messages or folder names and
// ids.
$response_messages = $response->ResponseMessages->FindFolderResponseMessage;
foreach ($response_messages as $response_message) {
    // Make sure the request succeeded.
    if ($response_message->ResponseClass != ResponseClassType::SUCCESS) {
        $code = $response_message->ResponseCode;
        $message = $response_message->MessageText;
        echo("Failed to find folders with \"$code: $message\"\n");
        continue;
    }

    // The folders could be of any type, so combine all of them into a single
    // array to iterate over them.
    $folders = array_merge(
        $response_message->RootFolder->Folders->CalendarFolder,
        $response_message->RootFolder->Folders->ContactsFolder,
        $response_message->RootFolder->Folders->Folder,
        $response_message->RootFolder->Folders->SearchFolder,
        $response_message->RootFolder->Folders->TasksFolder
    );

    // Iterate over the found folders.
    foreach ($folders as $folder) {
        $name = $folder->DisplayName;
        $id = $folder->FolderId->Id;;
        echo("Found folder \"$name\": $id\n");
    }
}
