<?php // -*-mode: PHP; coding:utf8;-*-
// $Id$

// This file contains PHP code that specifies language specific strings
// The default strings come from lang.en, and anything in a locale
// specific file will overwrite the default. This is a Swedish file.
//
// Provided 2013-02-21 by: Anders Henhammar <anders_henhammar@yahoo.se>
//
//
// This file is PHP code. Treat it as such.

// Used in style.inc
//KTH
$vocab["mrbs"]               = "Boka - Grupprum/Lässtudio";
$vocab["mrbsextended"]       = "Boka - Handledning CAS";
$vocab["mrbstalkingbooks"]   = "Boka - Talboksintroduktion";
$vocab["mrbsconsultation"]   = "Boka - Handledning";

//KTH Header.inc
$vocab["mybookings"]         = "Mina bokningar";
$vocab["changelanguage"]     = "In English";
$vocab["homelink"]     		 = "Hem";

// Used in functions.inc
$vocab["report"]             = "Rapport";
$vocab["admin"]              = "Admin";
$vocab["help"]               = "Hjälp";
$vocab["search"]             = "Sök";
$vocab["outstanding"]        = "väntande bokningar";

// Used in day.php
$vocab["bookingsfor"]        = "Bokningar för";
$vocab["bookingsforpost"]    = ""; // Goes after the date
//KTH
$vocab["areas"]              = "Välj område";
//KTH
$vocab["daybefore"]          = "Föregående";
$vocab["dayafter"]           = "Nästa";
$vocab["gototoday"]          = "Visa idag";
$vocab["nextavailable"]      = "Nästa lediga tid";
$vocab["noavailable"]        = "Inga senare lediga tider finns";
$vocab["goto"]               = "Gå till";
$vocab["highlight_line"]     = "Markera denna rad";
$vocab["click_to_reserve"]   = "Klicka på cellen för att göra en bokning.";
$vocab["timezone"]           = "Tidszon";
$vocab["seats"]				 = "Platser";
$vocab["bookingrules"]		 = "Bokningsregler/Information";
$vocab["map"]		 		 = "Hitta ditt rum";

//KTH Colour key texts
$vocab["colour_key_tentative"]			= "Preliminär bokning";
//191003
$vocab["colour_key_bookable"]			= "Ledig";
$vocab["colour_key_to_be_confirmed"]	= "Bokad - Kvitteras";
$vocab["colour_key_confirmed"]			= "Kvitterad bokning";
$vocab["colour_key_invalid"]			= "Ej tillgänglig";
$vocab["colour_key_special"]			= "Event";

// Used in trailer.inc
$vocab["viewday"]            = "Visa dag";
$vocab["viewweek"]           = "Visa vecka";
$vocab["viewmonth"]          = "Visa månad";
$vocab["ppreview"]           = "Förhandsgranska";

// Used in edit_entry.php

//KTH
$vocab["select_an_option"]			= "Välj ett alternativ";
$vocab["remembertoconfirm"]  = "Kom ihåg att du måste kvittera den här preliminära bokningen innan du börjar använda rummet! Det kan du endast göra från 15 minuter före till 15 minuter efter starttiden. ";
//191003
$vocab["bookable_entry_text"]			= "Ledig";
$vocab["bookable_entry_text_not_available"]	= "Ledig - inte tillgänglig för dig";
$vocab["booked_entry_text_tentative"] = "Bokad";
$vocab["booked_entry_text"]			= "Upptaget";

$vocab_override['sv']["entry.instructor"]  = "Handledare";
$vocab_override['sv']["entry.campus"]  = "Plats";
$vocab_override['sv']["entry.my_campus"]  = "Mitt Campus";
$vocab_override['sv']["entry.preferred_language"]  = "Språk";
$vocab_override['sv']["entry.user_group"]  = "Användarkategori";
$vocab_override['sv']["entry.email"]  = "Mejl";
$vocab_override['sv']["entry.phone"]  = "Telefon";
$vocab_override['sv']["entry.program"]  = "Program / institution";
$vocab_override['sv']['entry.study_info'] = "Vad söker du information om? Beskriv syfte och frågeställning";
$vocab_override['sv']['entry.previously'] = "Var har du tidigare sökt efter information?";
$vocab_override['sv']['entry.subject_keywords'] = "Ge exempel på sökord och termer som är relevanta för ämnet";
$vocab_override['sv']['entry.consultation_info'] = "Vad söker du information om? Beskriv kort ditt ämne/frågeställning och syftet med sökningen. Ange gärna om du redan har sökt och i så fall var och vilka sökord du använt.";
$vocab_override['sv']['entry.other_info'] = "Övriga kommentarer";

//Writing
$vocab_override['sv']['entry.writing_help_get_started'] = "Hjälp att komma igång med skrivandet/få skrivkrampen att släppa";
$vocab_override['sv']['repeat.writing_help_get_started'] = "Hjälp att komma igång med skrivandet/få skrivkrampen att släppa";
$vocab_override['sv']['entry.writing_help_overall_structure'] = "Hjälp med den övergripande strukturen i en text";
$vocab_override['sv']['repeat.writing_help_overall_structure'] = "Hjälp med den övergripande strukturen i en text";
$vocab_override['sv']['entry.writing_help_paragraph_structure'] = "Hjälp med styckestrukturen";
$vocab_override['sv']['repeat.writing_help_paragraph_structure'] = "Hjälp med styckestrukturen";
$vocab_override['sv']['entry.writing_help_sentence_construction'] = "Hjälp med meningsbyggnad";
$vocab_override['sv']['repeat.writing_help_sentence_construction'] = "Hjälp med meningsbyggnad";
$vocab_override['sv']['entry.writing_help_coherence_cohesion'] = "Hjälp med sammanhang och textflyt";
$vocab_override['sv']['repeat.writing_help_coherence_cohesion'] = "Hjälp med sammanhang och textflyt";
$vocab_override['sv']['entry.writing_help_style_formality'] = "Hjälp med den språkliga stilen";
$vocab_override['sv']['repeat.writing_help_style_formality'] = "Hjälp med den språkliga stilen";
$vocab_override['sv']['entry.writing_help_conventions'] = "Hjälp med språkliga detaljer som grammatik, stavning och särskrivningar";
$vocab_override['sv']['repeat.writing_help_conventions'] = "Hjälp med språkliga detaljer som grammatik, stavning och särskrivningar";
$vocab_override['sv']['entry.writing_help_citation'] = "Hjälp med referatteknik";
$vocab_override['sv']['repeat.writing_help_citation'] = "Hjälp med referatteknik";
$vocab_override['sv']['entry.writing_help_references'] = "Hjälp med referenser och hänvisningar";
$vocab_override['sv']['repeat.writing_help_references'] = "Hjälp med referenser och hänvisningar";
$vocab_override['sv']['entry.writing_help_otherformal'] = "Hjälp med annan formalia, t.ex. layout, sidnumrering, figurer, tabeller";
$vocab_override['sv']['repeat.writing_help_otherformal'] = "Hjälp med annan formalia, t.ex. layout, sidnumrering, figurer, tabeller";
$vocab_override['sv']['entry.writing_help_other'] = "Annat";
$vocab_override['sv']['repeat.writing_help_other'] = "Annat";
//Oral presentation
$vocab_override['sv']['entry.oral_help_nervousness'] = "Hjälp med talängslan/rampfeber/nervositet";
$vocab_override['sv']['repeat.oral_help_nervousness'] = "Hjälp med talängslan/rampfeber/nervositet";
$vocab_override['sv']['entry.oral_help_overall_structure'] = "Hjälp med den övergripande strukturen och dispositionen av en muntlig presentation";
$vocab_override['sv']['repeat.oral_help_overall_structure'] = "Hjälp med den övergripande strukturen och dispositionen av en muntlig presentation";
$vocab_override['sv']['entry.oral_help_act_interact'] = "Hjälp med att agera framför publiken, publikkontakt";
$vocab_override['sv']['repeat.oral_help_act_interact'] = "Hjälp med att agera framför publiken, publikkontakt";
$vocab_override['sv']['entry.oral_help_interact_computer'] = "Hjälp med att förhålla mig till dator, illustrationer och manus";
$vocab_override['sv']['repeat.oral_help_interact_computer'] = "Hjälp med att förhålla mig till dator, illustrationer och manus";
$vocab_override['sv']['entry.oral_help_bodylanguage'] = "Hjälp med kroppsspråk";
$vocab_override['sv']['repeat.oral_help_bodylanguage'] = "Hjälp med kroppsspråk";
$vocab_override['sv']['entry.oral_help_images'] = "Hjälp med illustrationer/PowerPoint";
$vocab_override['sv']['repeat.oral_help_images'] = "Hjälp med illustrationer/PowerPoint";
$vocab_override['sv']['entry.oral_help_keeptime'] = "Hjälp med att hålla tiden";
$vocab_override['sv']['repeat.oral_help_keeptime'] = "Hjälp med att hålla tiden";
$vocab_override['sv']['entry.oral_help_other'] = "Annat";
$vocab_override['sv']['repeat.oral_help_other'] = "Annat";

$vocab_override['sv']['entry.help_other'] = "Annat";
$vocab_override['sv']['repeat.help_other'] = "Annat";

$vocab["addentry"]           = "Ny bokning";
$vocab["editentry"]          = "Ändra bokning";
$vocab["copyentry"]          = "Kopiera bokning";
$vocab["editseries"]         = "Ändra serie";
$vocab["copyseries"]         = "Kopiera serie";
$vocab["namebooker"]         = "Namn";
$vocab["fulldescription"]    = "Beskrivning:";
$vocab["date"]               = "Datum";
$vocab["start"]              = "Start";
$vocab["end"]                = "Slut";
$vocab["start_date"]         = "Starttid";
$vocab["end_date"]           = "Sluttid";
$vocab["time"]               = "Tid";
$vocab["period"]             = "Period";
$vocab["duration"]           = "Längd";
$vocab["second_lc"]          = "sekund";
$vocab["seconds"]            = "sekunder";
$vocab["minute_lc"]          = "minut";
$vocab["minutes"]            = "minuter";
$vocab["hour_lc"]            = "timme";
$vocab["hours"]              = "timmar";
$vocab["day_lc"]             = "dag";
$vocab["days"]               = "dagar";
$vocab["week_lc"]            = "vecka";
$vocab["weeks"]              = "veckor";
$vocab["year_lc"]            = "år";
$vocab["years"]              = "år";
$vocab["period_lc"]          = "period";
$vocab["periods"]            = "perioder";
$vocab["all_day"]            = "hela dagen";
$vocab["area"]               = "Område";
$vocab["type"]               = "Bokningstyp";
$vocab["save"]               = "Spara";
$vocab["confirm_save"]       = "Kvittera";
$vocab["rep_type"]           = "Repetitionstyp";
$vocab["rep_type_0"]         = "ingen";
$vocab["rep_type_1"]         = "dagligen";
$vocab["rep_type_2"]         = "veckovis";
$vocab["rep_type_3"]         = "månatligen";
$vocab["rep_type_4"]         = "årligen";










$vocab["rep_end_date"]       = "Repetitionsslutdatum";
$vocab["rep_rep_day"]        = "Repetitionsdag";
$vocab["rep_for_weekly"]     = "(vecka och n-veckor)";
$vocab["rep_freq"]           = "Intervall";
$vocab["rep_num_weeks"]      = "Veckointervall";
$vocab["rep_for_nweekly"]    = "(n-veckor)";
$vocab["skip_conflicts"]     = "Hoppa över tidigare konflikter";
$vocab["ctrl_click"]         = "Håll ner tangenten <I>Ctrl</I> och klicka för att välja mer än ett rum";
$vocab["entryid"]            = "Boknings-ID ";
$vocab["repeat_id"]          = "Repetions-ID "; 
$vocab["you_have_not_entered"] = "Du har inte angivit";
$vocab["brief_description"]  = "Kort beskrivning";
$vocab["useful_n-weekly_value"] = "ett användbart n-veckovist värde";
$vocab["status"]             = "Status";
$vocab["public"]             = "Offentlig";
$vocab["private"]            = "Privat";
$vocab["unavailable"]        = "ej tillgänglig";
$vocab["is_mandatory_field"] = "är ett obligatoriskt fält, vänligen ange ett värde";
$vocab["missing_mandatory_field"] = "Du har inte angett ett värde för det obligatoriska fältet";
$vocab["confirmed"]          = "Kvitterad";

//KTH
$vocab["to_be_confirmed"]    = "<strong>Kvittera din bokning genom att spara!</strong>";

$vocab["start_after_end"]    = "Börja dagen efter sista dag";
$vocab["start_after_end_long"] = "Fel: Startdag är efter utgångsdagen";

// Used in view_entry.php
$vocab["description"]         = "Beskrivning";
//KTH

$vocab["more_rooms_indicator"] = "Fler rum";
$vocab["room"]                = "Rum";
$vocab["daystableheader"]     = "Dag";
$vocab["createdby"]           = "Skapad av";

$vocab["lastupdate"]          = "Senast uppdaterad";
$vocab["deleteentry"]         = "Avboka";
$vocab["deleteseries"]        = "Radera serie";
$vocab["exportentry"]         = "Exportera bokningen";
$vocab["exportseries"]        = "Exportera rader";
$vocab["confirmdel"]          = "Är du säker att du vill radera den här bokningen?\\n";
$vocab["returnprev"]          = "Åter till föregående sida";
$vocab["invalid_entry_id"]    = "Ogiltigt boknings-ID!";
$vocab["invalid_series_id"]   = "Ogiltigt serie-ID!";
$vocab["confirmation_status"] = "Bokningsstatus";
$vocab["tentative"]           = "Preliminär";
$vocab["approval_status"]     = "Godkännandestatus";
$vocab["approved"]            = "Godkänd";
$vocab["awaiting_approval"]   = "Väntar på godkännande";
$vocab["approve"]             = "Godkänn";
$vocab["reject"]              = "Neka";
$vocab["more_info"]           = "Mer information";
$vocab["remind_admin"]        = "Påminn administratör";
$vocab["series"]              = "Serier";
$vocab["request_more_info"]   = "Tala om vilken övrig information du behöver.";
$vocab["reject_reason"]       = "Ge en anledning till varför du nekar den här bokningsförfrågan.";
$vocab["send"]                = "Skicka";
$vocab["approve_failed"]      = "Bokningen kunde inte godkännas.";
$vocab["no_request_yet"]      = "Ingen begäran har skickats ännu"; // Used for the title tooltip on More Info button
$vocab["last_request"]        = "Senaste begäran skickas";         // Used for the title tooltip on More Info button
$vocab["by"]                  = "av";                              // Used for the title tooltip on More Info button
$vocab["sent_at"]             = "Skickas vid ";
$vocab["yes"]                 = "Ja";
$vocab["no"]                  = "Nej";

// Used in edit_entry_handler.php
$vocab["error"]              = "Fel";
$vocab["sched_conflict"]     = "Bokningskonflikt";
$vocab["conflict"]           = "Den nya bokningen kolliderar med följande bokning(ar)";
$vocab["no_conflicts"]       = "Inga schemakonflikter";
$vocab["rules_broken"]       = "Den nya bokningen är i konflikt med följande regel";
$vocab["no_rules_broken"]    = "Inga regelkonflikter";
$vocab["schedule"]           = "Schema";
$vocab["policy"]             = "Regel";
$vocab["too_may_entrys"]     = "De valda inställningarna skapar för många bokningar.<br>V.g. använd andra inställningar!";
$vocab["returncal"]          = "Återgå till kalendervy";
$vocab["failed_to_acquire"]  = "Kunde ej få exklusiv databasåtkomst"; 
$vocab["invalid_booking"]    = "Ogiltig bokning";
$vocab["must_set_description"] = "Du måste ange en beskrivning för bokningen. Vänligen gå tillbaka och korrigera detta.";
$vocab["mail_subject_approved"]  = "Bokningen godkänd i $mrbs_company MRBS";
$vocab["mail_subject_rejected"]  = "Bokningen avvisad i $mrbs_company MRBS";
$vocab["mail_subject_more_info"] = "$mrbs_company bokningskalender: Mer information önskas";
$vocab["mail_subject_reminder"]  = "Påminnelse från $mrbs_company bokningskalender";
$vocab["mail_body_approved"]     = "En bokning har blivit godkänd av administratören; här är detaljerna:";
$vocab["mail_body_rej_entry"]    = "En bokning har blivit avvisad av administratören; här är detaljerna:";
$vocab["mail_body_more_info"]    = "Administratören behöver mer information om bokningen; här är detaljerna:";
$vocab["mail_body_reminder"]     = "Påminnelse - en bokning väntar på godkännande; här är detaljerna:";
$vocab["mail_body_repeats_booked"]   = "Följande datum bokades:";
$vocab["mail_body_repeats_deleted"]  = "Följande bokningar togs bort:";
$vocab["mail_body_exceptions"]       = "På grund av bokningskonflikt kunde följande datum inte bokas:";
$vocab["mail_subject_new_entry"]     = "Bokning av grupprum";
//KTH mailutskick 2018
$vocab["mail_subject_new_entry_supervision"]     = "Bokning av handledning";
$vocab["mail_subject_new_entry_readingstudio"]     = "Bokning av lässtudio";
$vocab["mail_subject_new_entry_talkingbooks"]     = "Bokning av talboksintroduktion";
$vocab["mail_subject_changed_entry_supervision"]     = "Bokning av handledning";
$vocab["mail_subject_changed_entry_readingstudio"]     = "Bokning av lässtudio";
$vocab["mail_subject_changed_entry_talkingbooks"]     = "Bokning av talboksintroduktion";
$vocab["mail_from_address_kthb"]     = "KTH Biblioteket <noreply@kth.se>";
$vocab["mail_from_address_cas"]     = "KTH CAS <noreply@kth.se>";
$vocab["mail_from_address_talbok"]  = "KTH Biblioteket <noreply@kth.se>";
$vocab["mail_subject_changed_entry"] = "Bokning av grupprum";
$vocab["mail_subject_delete"]        = "Bokning av grupprum togs bort";

$vocab["mail_body_new_entry"] = "Ny bokning";
$vocab["mail_body_changed_entry"] = "En bokning har ändrats; här är detaljerna";
$vocab["mail_body_del_entry"] = "En bokning har raderats; här är detaljerna";
$vocab["new_value"]           = "Ny";
$vocab["old_value"]           = "Gammal";
$vocab["deleted_by"]          = "Raderad av";
$vocab["reason"]              = "Anledning";
$vocab["info_requested"]      = "Information behövs";
$vocab["min_time_before"]     = "Minsta intervall mellan nu och starten för en bokning är";
$vocab["max_time_before"]     = "Största intervall mellan nu och starten för en bokning är";
$vocab["latest_booking_date"]     = "Senaste bokningsdatum är";
$vocab["max_booking_duration"]    = "Maximal löptid på en bokning är";
//KTH Timmar
$vocab["max_hours_per_day_global"]      = "Maximala antalet timmar per dag per användare över hela systemet är";
$vocab["max_hours_per_day_area"]        = "Maximala antalet timmar per dag per användare inom detta område är";
$vocab["max_hours_per_week_global"]      = "Maximala antalet timmar per vecka per användare över hela systemet är";
$vocab["max_hours_per_week_area"]        = "Maximala antalet timmar per vecka per användare inom detta område är";
$vocab["max_hours_per_future_global"]   = "Maximala antalet utgivna timmar per användare över hela systemet är";

$vocab["max_per_day_global"]      = "Maximala antalet bokningar per dag per användare över hela systemet är";
$vocab["max_per_week_global"]     = "Maximala antalet bokningar per vecka per användare över hela systemet är";
$vocab["max_per_month_global"]    = "Maximala antalet bokningar per månad per användare över hela systemet är";
$vocab["max_per_year_global"]     = "Maximala antalet bokningar per år per användare över hela systemet är";
$vocab["max_per_future_global"]   = "Maximala antalet utgivna bokningar per användare över hela systemet är";
$vocab["max_per_day_area"]        = "Maximala antalet bokningar per dag per användare inom detta område är";
$vocab["max_per_week_area"]       = "Maximala antalet bokningar per vecka per användare inom detta område är";
$vocab["max_per_month_area"]      = "Maximala antalet bokningar per månad per användare inom detta område är";
$vocab["max_per_year_area"]       = "Maximala antalet bokningar per år per användare inom detta område är";
$vocab["max_per_future_area"]     = "Maximala antalet utgivna bokningar per användare inom detta område är";
$vocab["skip_and_book"]           = "Hoppa över och boka";
$vocab["skip_and_book_note"]      = "Fortsätta med bokningen och hoppa över bokningskonflikter";
$vocab["changes_saved"]           = "Ändringarna är sparade";

// Used in pending.php
$vocab["pending"]            = "Preliminär bokning väntar på godkännande";
$vocab["none_outstanding"]   = "Du har inga preliminära bokningar som väntar på att godkännas.";

// Authentication stuff
$vocab["accessdenied"]       = "Åtkomst nekad";
$vocab["not_authorized"]     = "Åtkomst nekad";
$vocab["not_authorized_UG"]  = "UG: Bibliotekets grupprum är enbart för studenter och kan inte bokas av anställda.";
$vocab["norights"]           = "";
$vocab["please_login"]       = "Vänligen ange dina uppgifter";
//KTH
$vocab["login_info"]		 = "Ändrat loginförfarande. Ange bara ditt KTH-Konto(utan \"@kth.se\")";
$vocab["users.name"]          = "KTH-Konto";
$vocab["users.password"]      = "Födelsedatum(ååmmdd)";
$vocab["users.level"]         = "Rättigheter";
$vocab["unknown_user"]       = "Inloggad som: Gäst";
//KTH
$vocab["you_are"]            = "Inloggad som: ";
$vocab["login"]              = "Logga in";
$vocab["logoff"]             = "Logga ut";
$vocab["error_password"]	 = "Fel födelsedatum. Skriv in ditt födelsedatum i formatet ååmmdd.";
$vocab["error_identifier"]	 = "Använd ditt KTH-Konto för att logga in";

// Database upgrade code
$vocab["database_login"]           = "Databasinloggning";
$vocab["upgrade_required"]         = "Databasen behöver uppdateras.  Gör en backup av den gamla databasen innan du fortsätter.";
$vocab["supply_userpass"]          = "Ange databasens användarnamn och lösenord som har admin rättigheter.";
$vocab["contact_admin"]            = "Om du inte är MRBS administratör vänligen kontakta $mrbs_admin.";
$vocab["upgrade_to_version"]       = "Uppgradera till databas version";
$vocab["upgrade_to_local_version"] = "Uppgradera till databas lokal version";
$vocab["upgrade_completed"]        = "Databasen har uppdateras klart.";

// User access levels
$vocab["level_0"]            = "Ingen rättighet";
$vocab["level_1"]            = "Användare";
$vocab["level_2"]            = "Administratör";
$vocab["level_3"]            = "Superadministratör";

// Authentication database
$vocab["user_list"]          = "Användarlista";
$vocab["edit_user"]          = "Ändra användare";
$vocab["delete_user"]        = "Radera denna användare";
//$vocab["users.name"]         = Use the same as above, for consistency.
//$vocab["users.password"]     = Use the same as above, for consistency.
$vocab["users.email"]         = "E-postadress";
$vocab["password_twice"]     = "Om du vill ändra ditt lösenord, vänligen skriv in det två gånger";
$vocab["passwords_not_eq"]   = "Fel: Lösenorden stämmer inte överens.";
$vocab["password_invalid"]   = "Lösenordet är inte giltigt. Det måste innehålla följande:";
$vocab["policy_length"]      = "tecken";
$vocab["policy_alpha"]       = "bokstav/bokstäver";
$vocab["policy_lower"]       = "liten bokstav (gemener)";
$vocab["policy_upper"]       = "stor bokstav (VERSALER)";
$vocab["policy_numeric"]     = "siffra/siffror";
$vocab["policy_special"]     = "specialtecken";
$vocab["add_new_user"]       = "Lägg till användare";
$vocab["action"]             = "Handling";
$vocab["user"]               = "Användare";
$vocab["administrator"]      = "Administratör";
$vocab["unknown"]            = "Okänd";
$vocab["ok"]                 = "OK";
$vocab["show_my_entries"]    = "Klicka för att visa alla dina aktuella bokningar";
$vocab["no_users_initial"]   = "Inga användare finns i databasen. Tillåter initialt skapande av användare.";
$vocab["no_users_create_first_admin"] = "Skapa en administrativ användare först. Därefter kan du logga in och skapa fler användare.";
$vocab["warning_last_admin"] = "Varning!  Detta är den sista administratören och du kan inte ändra rättigheterna eller ta bort denna, gör du det i alla fall har du ingen möjlighet att komma in i systemet igen.";

// Used in search.php
$vocab["invalid_search"]     = "Tom eller ogiltig söksträng.";
$vocab["search_results"]     = "Sökresultat för";
$vocab["nothing_found"]      = "Inga sökträffar hittades.";
$vocab["records"]            = "Bokning ";
$vocab["through"]            = " t.o.m. ";
$vocab["of"]                 = " av ";
$vocab["previous"]           = "Föregående dag";
$vocab["next"]               = "Nästa dag";
$vocab["entry"]              = "Bokning";
$vocab["advanced_search"]    = "Avancerad sökning";
$vocab["search_button"]      = "Sök";
$vocab["search_for"]         = "Sök för";
$vocab["from"]               = "Från";

// Used in report.php
$vocab["report_on"]             = "Skapa en rapport";
$vocab["report_start"]          = "Startdatum för rapport";
$vocab["report_end"]            = "Slutdatum för rapport";
$vocab["match_area"]            = "Sök på plats";
$vocab["match_room"]            = "Sök på rum";
$vocab["match_type"]            = "Sök på bokningstyp";
$vocab["ctrl_click_type"]       = "Håll ner tangenten <I>Ctrl</I> och klicka för att markera fler poster";
$vocab["match_entry"]           = "Sök i kort beskrivning";
$vocab["match_descr"]           = "Sök i fullständig beskrivning";
$vocab["output"]                = "Utdata";
$vocab["summary"]               = "Sammanställning";
$vocab["format"]                = "Format";
$vocab["html"]                  = "HTML";
$vocab["csv"]                   = "CSV";
$vocab["ical"]                  = "iCalender (.ics fil) - exklusive perioder";
$vocab["combination_not_supported"] = "utdata stöds inte i detta format";
$vocab["summarize_by"]          = "Sammanställ på";
$vocab["sum_by_descrip"]        = "Kort beskrivning";
$vocab["sum_by_creator"]        = "Handläggare";
$vocab["sum_by_type"]           = "Bokningstyp";
$vocab["entry_found"]           = "bokning hittades";
$vocab["entries_found"]         = "bokningar hittades";
$vocab["summary_header"]        = "Sammanställning över (bokningar) i perioder";
$vocab["summary_header_per"]    = "Sammanställning av (bokningar) i timmar";
$vocab["summary_header_both"]   = "Sammanställning av (bokningar) i timmar/perioder";
$vocab["entries"]               = "bokningar";
$vocab["total"]                 = "Totalt";
$vocab["submitquery"]           = "Skapa rapport";
$vocab["sort_rep"]              = "Sortera rapport efter";
$vocab["sort_rep_time"]         = "Startdatum/starttid";
$vocab["sort_room"]             = "Rum";
$vocab["fulldescription_short"] = "Beskrivning";
$vocab["both"]                  = "Samtliga";
$vocab["privacy_status"]        = "Sekretessinställning";
$vocab["search_criteria"]       = "Sökkriterier";
$vocab["presentation_options"]  = "Rapportalternativ";
$vocab["delete_entries"]        = "Ta bort poster";
$vocab["delete_entries_warning"] = "VARNING! Detta tar bort alla poster som matchar " .
                                   "söksträngen.  Operationen kan inte ångras." .
                                   "Vill du verkligen fortsätta?\n\n" .
                                   "Totalt antal poster som ska tas bort: ";
$vocab["delete_entries_failed"] = "Posterna kunde inte tas bort";

// Used in week.php
$vocab["weekbefore"]         = "Föregående";
$vocab["weekafter"]          = "Nästa";
$vocab["gotothisweek"]       = "Visa nuvarande vecka";
$vocab["week"]       		 = "Vecka";

// Used in month.php
$vocab["monthbefore"]        = "Föregående månad";
$vocab["monthafter"]         = "Nästa månad";
$vocab["gotothismonth"]      = "Denna månad";

// Used in {day week month}.php
$vocab["no_rooms_for_area"]  = "Rum saknas för denna plats";

// Used in admin.php
$vocab["edit"]               = "Ändra";
$vocab["delete"]             = "Radera";
//KTH
$vocab["instructors"]        = "Välj handledare";
$vocab["rooms"]              = "Välj resurs";
$vocab["in"]                 = "i";
$vocab["noareas"]            = "Inget område";
$vocab["noareas_enabled"]    = "Inga områden har aktiverats.";
$vocab["addarea"]            = "Lägg till område";
$vocab["name"]               = "Namn";
$vocab["places"]            = "Platser";
$vocab["addplace"]            = "Lägg till plats";
$vocab["noplaces"]            = "Inga platser";
$vocab["no_closed_periods"] = "Inga stängda perioder";
$vocab["closed_periods"] = "Stängda perioder";
$vocab["add_closed_periods"] = "Lägg till period";
$vocab["closed_periods_description"]     = "Beskrivning";
$vocab["closed_periods_from_date"]     = "Från datum";
$vocab["closed_periods_to_date"]     = "Till datum";
$vocab["kth_closed_periods.from_date"]          = "Från datum";
$vocab["kth_closed_periods.to_date"]            = "Till datum";
$vocab["kth_closed_periods.description"]        = "Beskrivning";

//KTH Engelska
$vocab["name_en"]            = "Namn, Engelska";
$vocab["noarea"]             = "Inget område valt";
$vocab["browserlang"]        = "Din webbläsare är inställd att använda språk(en)";
$vocab["addinstructor"]      = "Lägg till handledare";
$vocab["instructoremail"]    = "Email";
$vocab["addroom"]            = "Lägg till rum";
$vocab["capacity"]           = "Max antal personer";
$vocab["noinstructors"]      = "Inga handledare.";
$vocab["norooms"]            = "Inga rum.";
$vocab["norooms_enabled"]    = "Inga rum har aktiverats.";
$vocab["administration"]     = "Administration";
$vocab["invalid_area_name"]  = "Detta områdes namn finns redan.";
$vocab["empty_name"]         = "Du har inte angett ett namn!";

// Used in edit_area_room.php

//KTH
$vocab_override['sv']['room.room_name_english'] = "Namn, engelska";
$vocab_override['sv']['room.Test'] = "Coffee machine";

$vocab["editarea"]                = "Ändra område";
$vocab["change"]                  = "Ändra";
$vocab["backadmin"]               = "Tillbaka till administration";
$vocab["editroomarea"]            = "Ändra område eller rum";
$vocab["editroom"]                = "Ändra rum";
$vocab["viewroom"]                = "Visa rum";
$vocab["update_room_failed"]      = "Uppdatering av rum misslyckades: ";
$vocab["error_room"]              = "Fel: rum ";
$vocab["not_found"]               = "hittades ej";
$vocab["update_area_failed"]      = "Uppdatering av område misslyckades: ";
$vocab["error_area"]              = "Fel: område";
$vocab["room_admin_email"]        = "E-postadress till rumsansvarig";
$vocab["area_admin_email"]        = "E-postadress till områdesansvarig";
$vocab["area_first_slot_start"]   = "Start för första tid";
$vocab["area_last_slot_start"]    = "Start för sista tid";
$vocab["area_res_mins"]           = "Tidsintervall (i minuter)";
$vocab["area_def_duration_mins"]  = "Gällande intervall (i minuter)";
$vocab["invalid_area"]            = "Ogiltigt område!";
$vocab["invalid_room_name"]       = "Det här rums namnet används redan i det här området!";
$vocab["invalid_email"]           = "Ogiltig e-postadress!";
$vocab["invalid_resolution"]      = "Ogiltig kombination av första tid, sista tid och tidsintervall!";
$vocab["too_many_slots"]          = 'Du behöver öka värdet för $max_slots i config filen!'; // single quotes!

//KTH
$vocab["default_view"]            = "Default vy"; 
$vocab["times_along_top"]         = "Tider längs"; 
$vocab["hide_links"]              = "Dölj länkar"; 
$vocab["reminder_email_enabled"]  = "Skicka påminnelsemail";
//KTH 2018 
$vocab["extended_booking_form"]   = "Utökat bokningsformulär(CAS)";
$vocab["area_type"]               = "Typ"; 
$vocab["area_map"]                = "Karta";
$vocab["area_map_image"]          = "Kartbild";

//KTH
$vocab["settings"]        		  = "Inställningar";

$vocab["general_settings"]        = "Allmänna inställningar";
$vocab["time_settings"]           = "Tidsintervaller";
$vocab["confirmation_settings"]   = "Moderationsinställningar";
$vocab["allow_confirmation"]      = "Tillåt preliminära bokningar";
$vocab["default_settings_conf"]   = "Standardinställning";
$vocab["default_confirmed"]       = "Slutgiltig";
$vocab["default_tentative"]       = "Preliminär";
$vocab["approval_settings"]       = "Godkännandeinställningar";
$vocab["enable_approval"]         = "Begär godkännande av bokningar";
$vocab["enable_reminders"]        = "Tillåt användare att påminna administratören.";
$vocab["private_settings"]        = "Privata bokningar";
$vocab["allow_private"]           = "Tillåt privata bokningar";
$vocab["force_private"]           = "Bestäm privata bokningar";
$vocab["default_settings"]        = "Gällande/bestämda inställningar";
$vocab["default_private"]         = "Privat";
$vocab["default_public"]          = "Öppen";
$vocab["private_display"]         = "Privat bokning (visa)";
$vocab["private_display_label"]   = "Hur ska privata bokningar visas?";
$vocab["private_display_caution"] = "Varning: tänk efter vilka konsekvenser detta kan få innan du ändrar dessa inställningar!";
$vocab["treat_respect"]           = "Respektera att detta är en privat bokning";
$vocab["treat_private"]           = "Behandla alla bokningar som privata, ignorera den individuella inställningen.";
$vocab["treat_public"]            = "Behandla alla bokningar som öppna, ignorera den individuella inställningen.";
$vocab["sort_key"]                = "Sorterings nyckel";
$vocab["sort_key_note"]           = "Det här är nyckeln för att sortera rum i bokstavsordning.";
$vocab["booking_policies"]        = "Bokningsregler";
$vocab["booking_creation"]        = "Skapa bokningar";
$vocab["booking_deletion"]        = "Ta bort bokningar";

//KTH Timmar
$vocab["hour_limits"]          = "Begränsning på antalet timmar som får bokas";

$vocab["booking_limits"]          = "Begränsning på antalet bokningar som får göras";
$vocab["booking_durations"]       = "Begränsning på längden för bokningar";
$vocab["max_duration"]            = "Maxlängd";

$vocab["min_book_ahead"]          = "Bokning i förväg - minimum";
$vocab["max_book_ahead"]          = "Bokning i förväg - maximum";
$vocab["this_area"]               = "Detta område";
$vocab["whole_system"]            = "Hela systemet";
$vocab["whole_system_note"]       = "Värden för hela systemet ställs in i konfigurationsfilen";

//KTH Timmar
$vocab["max_hours_per_day"]             = "Högsta antal timmar per dag";
$vocab["max_hours_per_week"]            = "Högsta antal timmar per vecka";
$vocab["max_hours_per_month"]           = "Högsta antal timmar per månad";
$vocab["max_hours_per_year"]            = "Högsta antal timmar per år";
$vocab["max_hours_per_future"]          = "Högsta antal timmar framöver";

$vocab["max_per_day"]             = "Högsta antal per dag";
$vocab["max_per_week"]            = "Högsta antal per vecka";
$vocab["max_per_month"]           = "Högsta antal per månad";
$vocab["max_per_year"]            = "Högsta antal per år";
$vocab["max_per_future"]          = "Högsta antal framöver";
$vocab["custom_html"]             = "Informationstext";

//KTH
$vocab["custom_html_en"]             = "Informations text Engelska";
$vocab["extra_info"]                = "Ingress text";

//KTH
$vocab["extra_info_en"]             = "Ingress text Engelska";


$vocab["custom_html_note"]        = "Det här fältet kan användas för att visa egen HTML-kod, t.ex. en inbäddad Google-karta";
$vocab["email_list_note"]         = "Ange en lista med e-postadresser separerade med kommatecken eller nya rader";
$vocab["mode"]                    = "Tidsinställning";
$vocab["mode_periods"]            = "Perioder";
$vocab["mode_times"]              = "Tider";
$vocab["times_only"]              = "Endast tidsinställning";
$vocab["enabled"]                 = "Aktiverad";
$vocab["disabled"]                = "Inaktiverad";
$vocab["disabled_area_note"]      = "Om detta område är inaktiverat, kommer det inte att visas i kalendervyerna. " .
                                      "och det kommer inte att gå att boka rum där. Befintliga bokningar däremot".
                                      "kommer att visas i sök och rapportresultaten. " ;
$vocab["disabled_room_note"]      = "Om detta rum är inaktiverat, kommer det inte att visas i kalendervyerna. " .
                                      "och det kommer inte att gå att boka det.   Befintliga bokningar däremot".
                                      "kommer att visas i sök och rapportresultaten. ";
$vocab["book_ahead_note_periods"] = "När man använder perioder är förbokningstiderna avrundade nedåt till närmaste hel dag.";

// Used in edit_users.php
$vocab["name_empty"]         = "Du måste ange ett namn.";
$vocab["name_not_unique"]    = "finns redan.   Ange ett annat namn.";

// Used in edit_closed_period.php
$vocab["edit_closed_period"]                = "Uppdatera stängd period";
$vocab["closed_period_from_date"]           = "Från datum";
$vocab["closed_period_to_date"]             = "Till datum";
$vocab["closed_period_description"]         = "Beskrivning";

// Used in del.php
$vocab["deletefollowing"]    = "Detta raderar följande bokningar";
$vocab["sure"]               = "Är du säker?";
$vocab["YES"]                = "JA";
$vocab["NO"]                 = "NEJ";
$vocab["delarea"]            = "Du måste ta bort alla rum i detta område innan du kan ta bort området!<p>";

// Used in help.php
$vocab["about_mrbs"]         = "Om MRBS";
$vocab["database"]           = "Databas";
$vocab["system"]             = "System";
$vocab["servertime"]         = "Servertid";
$vocab["please_contact"]     = "Var vänlig kontakta ";
$vocab["for_any_questions"]  = "för eventuella frågor som ej besvaras här.";

// Used in import.php
$vocab["import_icalendar"]            = "Importera iCalender-fil";
$vocab["area_room_settings"]          = "Områden och rum";
$vocab["other_settings"]              = "Övriga inställningar";
$vocab["import_intro"]                = "Med detta formulär kan du importera en RFC 5545 kompatibel " .
                                          "iCalender-fil till MRBS.   Endast upprepade händelser " .
                                          "med rätt repetitionstyp " .
                                          "motsvarande MBRS kommer att läggas till.";
$vocab["file_name"]                   = "Fil";
$vocab["import"]                      = "Importera";
$vocab["upload_failed"]               = "Uppladdningen misslyckades";
$vocab["max_allowed_file_size"]       = "Den maximalt tillåtna filstorleken är";
$vocab["no_file"]                     = "Ingen fil laddades upp";
$vocab["badly_formed_ics"]            = "Fel format på iCalender-filen";
$vocab["area_room_order"]             = "Sortering";
$vocab["area_room_order_note"]        = "Sortering av områden och rumsnamn under områdesinställningarna";
$vocab["area_room"]                   = "Område-Rum";
$vocab["room_area"]                   = "Rum-Område";
$vocab["area_room_delimiter"]         = "Avgränsare";
$vocab["area_room_delimiter_note"]    = "Sträng som avgränsar rums- och områdesnamnen i områdesinställningarna.  " .
                                         "Om ingen avgränsare hittas kommer MRBS att leta efter en unik plats med samma " .
                                         "namn som LOCATION.";
$vocab["area_room_create"]            = "Skapa ett rum om det behövs";
$vocab["default_type"]                = "Förvald bokningstyp";
$vocab["room_does_not_exist_no_area"] = "rum existerar inte och kan inte läggas till - inget område valt";
$vocab["room_not_unique_no_area"]     = "rumsnamnet är inte unikt.  Kan inte välja utan områdeshänvisning.";
$vocab["area_does_not_exist"]         = "Området finns inte:";
$vocab["room_does_not_exist"]         = "Rummet finns inte:";
$vocab["creating_new_area"]           = "Skapar nytt område:";
$vocab["creating_new_room"]           = "Skapar nytt rum:";
$vocab["could_not_create_area"]       = "Området kunde inte skapas";
$vocab["could_not_create_room"]       = "Rummet kunde inte skapas";
$vocab["could_not_find_room"]         = "Rummet hittades inte";
$vocab["could_not_import"]            = "Importen misslyckades";
$vocab["no_LOCATION"]                 = "VEVENT omfattas inte av LOCATION inställningen";
$vocab["invalid_RRULE"]               = "Felaktig RRULE: saknar FREQ del";
$vocab["more_than_one_BYDAY"]         = "MRBS stöder inte mer än ett BYDAY värde när FREQ=";
$vocab["BYDAY_equals_5"]              = "MRBS stöder inte BYDAY värden på 5";
$vocab["unsupported_FREQ"]            = "MRBS stöder inte FREQ=";
$vocab["unsupported_INTERVAL"]        = "MRBS stöder inte INTERVAL> 1 med FREQ=";
$vocab["unsupported_COUNT"]           = "COUNT stöds ännu inte av MRBS";
$vocab["no_indefinite_repeats"]       = "Obestämda upprepningar stöds ännu inte av MRBS";
$vocab["events_imported"]             = "importerade händelser";
$vocab["events_not_imported"]         = "ej importerade händelser";

// Used in mysql.inc AND pgsql.inc
$vocab["failed_connect_db"]  = "Fatalt fel: Kunde inte ansluta till databasen!";

// Used in DataTables
$vocab["show_hide_columns"]  = "Visa / dölj kolumner";
$vocab["restore_original"]   = "Återställ allt";

// Entry types
$vocab["type.I"]            = "Bokad";
$vocab["type.E"]            = "Externt";
//KTH
$vocab["type.C"]            = "Stängd";
$vocab["type.B"]            = "Bokningsbar";

// General
$vocab["fatal_db_error"]     = "Fatalt fel: Databasen är inte tillgänglig för tillfället!";
$vocab["back"]               = "Tillbaka";
$vocab["close"]              = "Stäng";