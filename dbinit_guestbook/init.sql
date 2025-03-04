-- phpMyAdmin SQL Dump
-- version 4.4.8
-- http://www.phpmyadmin.net
--
-- Värd: localhost
-- Tid vid skapande: 08 feb 2020 kl 23:15
-- Serverversion: 5.6.24-log
-- PHP-version: 5.6.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databas: `mrbs_APPNAME`
--

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_areatype`
--

DROP TABLE IF EXISTS `kth_areatype`;
CREATE TABLE IF NOT EXISTS `kth_areatype` (
  `id` int(11) NOT NULL,
  `areatype` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumpning av Data i tabell `kth_areatype`
--

INSERT INTO `kth_areatype` (`id`, `areatype`) VALUES
(1, 'Grouproom'),
(2, 'Readingstudio'),
(3, 'Supervision'),
(4, 'Openinghours'),
(5, 'Talkingbooks'),
(6, 'Consultation'),
(7, 'Guest Computers');

--
-- Tabellstruktur `kth_entry_custom_fields`
-- field_type: 1 = time, 2 = Input, 3 = text, 4 = Checkbox, 5 = Radio, 6 = Select

DROP TABLE IF EXISTS `kth_entry_custom_fields`;
CREATE TABLE IF NOT EXISTS `kth_entry_custom_fields` (
  `id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `entry_field_name` varchar(50) NOT NULL,
  `field_type` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `sort_order` int(11) NOT NULL,
  `visible` int(11) NOT NULL,
  `enabled` int(11) NOT NULL,
  `user_hidden` int(11) NOT NULL,
  `mandatory` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumpning av Data i tabell `kth_entry_custom_fields`
--

-- Grupprum/lässtudio
INSERT INTO `kth_entry_custom_fields` (`id`, `area_id`, `entry_field_name`, `field_type`, `type`, `sort_order`, `visible`, `enabled`, `user_hidden`, `mandatory`) VALUES
(1, 1, 'name', 2, 'standard', 110, 1, 1, 0, 1),
(2, 1, 'description', 2, 'standard', 115, 1, 1, 0, 1),
(3, 1, 'start_time', 1, 'standard', 100, 1, 1, 0, 1),
(4, 1, 'end_time', 1, 'standard', 105, 1, 1, 0, 1),
(5, 1, 'confirmation_status', 0, 'standard', 130, 1, 1, 0, 1);

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_exchange_events`
--

DROP TABLE IF EXISTS `kth_exchange_events`;
CREATE TABLE IF NOT EXISTS `kth_exchange_events` (
  `id` int(11) NOT NULL,
  `entry_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `event_id` varchar(200) NOT NULL,
  `change_key` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_kth_closed_periods`
--

CREATE TABLE IF NOT EXISTS `mrbs_kth_closed_periods` (
  `id` int NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `description` varchar(250) NOT NULL,
  `area_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_instructors`
--

DROP TABLE IF EXISTS `kth_instructors`;
CREATE TABLE IF NOT EXISTS `kth_instructors` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(4) NOT NULL DEFAULT '0',
  `area_id` int(11) NOT NULL DEFAULT '0',
  `sort_key` varchar(25) NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_periods`
--

DROP TABLE IF EXISTS `kth_periods`;
CREATE TABLE IF NOT EXISTS `kth_periods` (
  `id` int(11) NOT NULL,
  `start_time` varchar(5) NOT NULL,
  `end_time` varchar(5) NOT NULL,
  `entry_start_time` varchar(5) NOT NULL,
  `weekday` int(11) NOT NULL DEFAULT '0',
  `area_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_places`
--

DROP TABLE IF EXISTS `kth_places`;
CREATE TABLE IF NOT EXISTS `kth_places` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(4) NOT NULL DEFAULT '0',
  `default_choice` INT NULL DEFAULT '0',
  `room_id` int(11) NOT NULL DEFAULT '0',
  `sort_key` varchar(25) NOT NULL,
  `name` varchar(100) NOT NULL,
  `name_en` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_entry_places`
--

CREATE TABLE IF NOT EXISTS `kth_entry_places` (
  `id` int(11) NOT NULL,
  `entry_id` int(11) NOT NULL,
  `places_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_assignments`
-- 

DROP TABLE IF EXISTS `kth_assignments`;
CREATE TABLE IF NOT EXISTS `kth_assignments` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(4) NOT NULL DEFAULT '0',
  `sort_key` varchar(25) NOT NULL,
  `name` varchar(100) NOT NULL,
  `name_en` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumpning av Data i tabell `kth_assignments`
--

INSERT INTO `kth_assignments` (`id`, `disabled`, `sort_key`, `name`, `name_en`) VALUES
(1, 0, '1', 'Mitt kandidatexamensarbete', 'My candidate'),
(2, 0, '2', 'Min presentation av kandidatexamensarbete', 'My presentation candidate'),
(3, 0, '3', 'Mitt magisterexamensarbete', 'My magister'),
(4, 0, '4', 'Min presentation av magisterexamensarbete', 'My presentation magister'),
(5, 0, '0', '1none', '1none');


-- --------------------------------------------------------

--
-- Tabellstruktur `kth_campus`
--

CREATE TABLE IF NOT EXISTS `kth_campus` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(4) NOT NULL DEFAULT '0',
  `sort_key` varchar(25) NOT NULL,
  `name` varchar(100) NOT NULL,
  `name_en` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumpning av Data i tabell `kth_campus`
--

INSERT INTO `kth_campus` (`id`, `disabled`, `sort_key`, `name`, `name_en`) VALUES
(1, 0, '1', 'Campus KTH', 'Campus KTH'),
(2, 0, '2', 'Campus Kista', 'Campus Kista'),
(3, 0, '3', 'Campus Södertälje', 'Campus Södertälje'),
(4, 0, '4', 'Campus Flemingsberg', 'Campus Flemingsberg'),
(5, 0, '5', 'Campus Solna', 'Campus Solna'),
(6, 0, '0', '1none', '1none');

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_area`
--

DROP TABLE IF EXISTS `mrbs_area`;
CREATE TABLE IF NOT EXISTS `mrbs_area` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `area_name` varchar(50) DEFAULT NULL,
  `area_name_en` varchar(50) DEFAULT NULL,
  `area_sort_key` int(11) NOT NULL DEFAULT '0',
  `area_type` tinyint(4) NOT NULL DEFAULT '0',
  `timezone` varchar(50) DEFAULT NULL,
  `area_admin_email` text,
  `resolution` int(11) DEFAULT NULL,
  `default_duration` int(11) DEFAULT NULL,
  `default_duration_all_day` tinyint(1) NOT NULL DEFAULT '0',
  `morningstarts` int(11) DEFAULT NULL,
  `morningstarts_minutes` int(11) DEFAULT NULL,
  `eveningends` int(11) DEFAULT NULL,
  `eveningends_minutes` int(11) DEFAULT NULL,
  `private_enabled` tinyint(1) DEFAULT NULL,
  `private_default` tinyint(1) DEFAULT NULL,
  `private_mandatory` tinyint(1) DEFAULT NULL,
  `private_override` varchar(32) DEFAULT NULL,
  `min_create_ahead_enabled` tinyint(1) DEFAULT NULL,
  `min_create_ahead_secs` int(11) DEFAULT NULL,
  `max_create_ahead_enabled` tinyint(1) DEFAULT NULL,
  `max_create_ahead_secs` int(11) DEFAULT NULL,
  `min_delete_ahead_enabled` tinyint(1) DEFAULT NULL,
  `min_delete_ahead_secs` int(11) DEFAULT NULL,
  `max_delete_ahead_enabled` tinyint(1) DEFAULT NULL,
  `max_delete_ahead_secs` int(11) DEFAULT NULL,
  `max_per_day_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_day` int(11) NOT NULL DEFAULT '0',
  `max_per_week_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_week` int(11) NOT NULL DEFAULT '0',
  `max_hours_per_day_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_hours_per_day` int(11) NOT NULL DEFAULT '0',
  `max_hours_per_week_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_hours_per_week` int(11) NOT NULL DEFAULT '0',
  `max_hours_per_month_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_hours_per_month` int(11) NOT NULL DEFAULT '0',
  `max_hours_per_year_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_hours_per_year` int(11) NOT NULL DEFAULT '0',
  `max_hours_per_future_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_hours_per_future` int(11) NOT NULL DEFAULT '0',
  `max_per_month_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_month` int(11) NOT NULL DEFAULT '0',
  `max_per_year_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_year` int(11) NOT NULL DEFAULT '0',
  `max_per_future_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_future` int(11) NOT NULL DEFAULT '0',
  `max_global_per_day` int(11) NOT NULL DEFAULT '0',
  `max_global_per_day_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_global_per_week` int(11) NOT NULL DEFAULT '0',
  `max_global_per_week_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_global_per_month` int(11) NOT NULL DEFAULT '0',
  `max_global_per_month_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_global_per_year` int(11) NOT NULL DEFAULT '0',
  `max_global_per_year_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_global_per_future` int(11) NOT NULL DEFAULT '0',
  `max_global_per_future_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_duration_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_duration_secs` int(11) NOT NULL DEFAULT '0',
  `max_duration_periods` int(11) NOT NULL DEFAULT '0',
  `custom_html` text,
  `custom_html_en` text,
  `extra_info` text,
  `extra_info_en` text,
  `approval_enabled` tinyint(1) DEFAULT NULL,
  `reminders_enabled` tinyint(1) DEFAULT NULL,
  `enable_periods` tinyint(1) DEFAULT NULL,
  `confirmation_enabled` tinyint(1) DEFAULT NULL,
  `confirmed_default` tinyint(1) DEFAULT NULL,
  `default_view` int(11) NOT NULL DEFAULT '0',
  `times_along_top` int(11) NOT NULL DEFAULT '0',
  `hide_links` int(11) NOT NULL DEFAULT '1',
  `extended_booking_form` int(11) NOT NULL DEFAULT '0',
  `reminder_email_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `area_map` tinyint(1) NOT NULL DEFAULT '0',
  `area_map_image` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- Grupprum

INSERT INTO `mrbs_area` (`id`, `disabled`, `area_name`, `area_name_en`, `area_sort_key`, `area_type`, `timezone`, `area_admin_email`, `resolution`, `default_duration`, `default_duration_all_day`, `morningstarts`, `morningstarts_minutes`, `eveningends`, `eveningends_minutes`, `private_enabled`, `private_default`, `private_mandatory`, `private_override`, `min_create_ahead_enabled`, `min_create_ahead_secs`, `max_create_ahead_enabled`, `max_create_ahead_secs`, `min_delete_ahead_enabled`, `min_delete_ahead_secs`, `max_delete_ahead_enabled`, `max_delete_ahead_secs`, `max_per_day_enabled`, `max_per_day`, `max_per_week_enabled`, `max_per_week`, `max_hours_per_day_enabled`, `max_hours_per_day`, `max_hours_per_week_enabled`, `max_hours_per_week`, `max_hours_per_month_enabled`, `max_hours_per_month`, `max_hours_per_year_enabled`, `max_hours_per_year`, `max_hours_per_future_enabled`, `max_hours_per_future`, `max_per_month_enabled`, `max_per_month`, `max_per_year_enabled`, `max_per_year`, `max_per_future_enabled`, `max_per_future`, `max_global_per_day`, `max_global_per_day_enabled`, `max_global_per_week`, `max_global_per_week_enabled`, `max_global_per_month`, `max_global_per_month_enabled`, `max_global_per_year`, `max_global_per_year_enabled`, `max_global_per_future`, `max_global_per_future_enabled`, `max_duration_enabled`, `max_duration_secs`, `max_duration_periods`, `custom_html`, `custom_html_en`, `extra_info`, `extra_info_en`, `approval_enabled`, `reminders_enabled`, `enable_periods`, `confirmation_enabled`, `confirmed_default`, `default_view`, `times_along_top`, `hide_links`, `extended_booking_form`, `reminder_email_enabled`, `area_map`, `area_map_image`) VALUES
(1, 0, 'Gästdatorer', 'Guest computers', 1, 1, 'Europe/Stockholm', '', 3600, 7200, 0, 8, 0, 20, 0, 0, 0, 0, 'none', 0, 0, 1, 604800, 0, 0, 0, 604800, 1, 1, 1, 2, 1, 2, 1, 4, 0, 0, 0, 0, 0, 0, 0, 10, 0, 50, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 7200, 1, '<h2>Bokningsregler/Information</h2>\r\n<ul>\r\n<li>Boka med ditt KTH-Konto <p></p></li>\r\n<li>Boka själv via schemat tidigast en vecka i förväg.<p></p></li>\r\n<li>Bokningen <b>måste</b> kvitteras i tid annars förfaller den.<p></p></li>\r\n<li>Kvittering av bokat pass görs tidigast 15 minuter före och senast 15 minuter efter bokningstidens start.<p></p></li>\r\n<li>Avboka alltid en tid du inte kommer att använda. Ej avbokad tid räknas som en bokning. <p></p></li>\r\n<li>Ett pass som bokas sedan det börjat kvitteras automatiskt.<p></p></li>\r\n<li>Du kan boka ett rum per dag och max två rum per vecka.<p></p></li>\r\n<li>Du kan boka max två timmar per bokning.</li><p></p>\r\n<li>Grupprummen är avsedda för grupper på upp till 8 personer och minst 2 personer.<p></p></li>\r\n<li>Alla grupprum har en whiteboard och rum 4. Leopold har en skärm<p></p></li>\r\n<li>Du får inte ta med mat och dryck i grupprummen.<p></p></li>\r\n</ul>', '<h2>Booking rules/Information</h2>\r\n<ul>\r\n<li>Book an available time with your KTH account.<p></p></li>\r\n<li>A booking can be made a week ahead, you can do it yourself.<p></p></li>\r\n<li>You <b>must </b>confirm your time slot. This is done from 15 minutes before to 15 minutes after the start time.<p></p></li>\r\n<li>Always cancel your booking if you do not need the room. If you don''t cancel it will count as a booking.<p></p></li>\r\n<li>If you book a room after the start time it will be confirmed automatically.<p></p></li>\r\n<li>You may book up to one room/day and two/week.<p></p></li>\r\n<li>You may book maximum two hours per booking</li><p></p>\r\n<li>Group study rooms are intended for a group of people, i.e. for at least two persons.<p></p></li>\r\n<li>All group study rooms have a whiteboard and room 4. Leopold has a screen<p></p></li>\r\n<li>Food and drink may not be brought into the group study rooms.<p></p></li>\r\n</ul>', 'Här ska det stå lite inledande informationstext, som kan vara hur lång som helst. Men bra om det är ganska kortfattat så det inte fyller upp hela sidan.', '(english) Här ska det stå lite inledande informationstext, som kan vara hur lång som helst. Men bra om det är ganska kortfattat så det inte fyller upp hela sidan.', 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 'grupprum.jpg');

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_entry`
--

DROP TABLE IF EXISTS `mrbs_entry`;
CREATE TABLE IF NOT EXISTS `mrbs_entry` (
  `id` int(11) NOT NULL,
  `start_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `entry_type` int(11) NOT NULL DEFAULT '0',
  `repeat_id` int(11) DEFAULT NULL,
  `room_id` int(11) NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `instructor` varchar(50) DEFAULT NULL,
  `create_by` varchar(80) NOT NULL DEFAULT '',
  `modified_by` varchar(80) NOT NULL DEFAULT '',
  `name` varchar(80) NOT NULL DEFAULT '',
  `type` char(1) NOT NULL DEFAULT 'E',
  `description` text,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `reminded` int(11) DEFAULT NULL,
  `lang` varchar(2) NOT NULL DEFAULT 'en',
  `confirmation_code` varchar(255) DEFAULT NULL,
  `info_time` int(11) DEFAULT NULL,
  `info_user` varchar(80) DEFAULT NULL,
  `info_text` text,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `user_group` varchar(50) DEFAULT NULL,
  `program` varchar(100) DEFAULT NULL,
  `kth_program` varchar(50) DEFAULT NULL,
  `study_info` text,
  `previously` text,
  `subject_keywords` text,
  `campus` int(11) DEFAULT NULL,
  `my_campus` int(11) DEFAULT NULL,
  `kth_assignment` int(11) DEFAULT NULL,
  `kth_other_written_assignments` text DEFAULT NULL,
  `kth_other_oral_assignments` text DEFAULT NULL,
  `preferred_language` varchar(10) DEFAULT NULL,
  `consultation_info` text,
  `other_info` text,
  `understand_purpose_audience` smallint(6) DEFAULT NULL,
  `get_started_assignment` smallint(6) DEFAULT NULL,
  `understand_assignment_instruction` smallint(6) DEFAULT NULL,
  `main_message_argument_logic` smallint(6) DEFAULT NULL,
  `overall_structure_text` smallint(6) DEFAULT NULL,
  `paragraph_sentence_structure` smallint(6) DEFAULT NULL,
  `using_sources_support_argument` smallint(6) DEFAULT NULL,
  `presenting_data_discuss_result` smallint(6) DEFAULT NULL,
  `grammar_punctuation` smallint(6) DEFAULT NULL,
  `words_phrases` smallint(6) DEFAULT NULL,
  `academic_style` smallint(6) DEFAULT NULL,
  `pronuncation` smallint(6) DEFAULT NULL,
  `body_language_eye_contact` smallint(6) DEFAULT NULL,
  `communicate_visual_info` smallint(6) DEFAULT NULL,
  `present_digitally` smallint(6) DEFAULT NULL,
  `writing_help_get_started` smallint(6) DEFAULT NULL,
  `writing_help_overall_structure` smallint(6) DEFAULT NULL,
  `writing_help_paragraph_structure` smallint(6) DEFAULT NULL,
  `writing_help_sentence_construction` smallint(6) DEFAULT NULL,
  `writing_help_coherence_cohesion` smallint(6) DEFAULT NULL,
  `writing_help_style_formality` smallint(6) DEFAULT NULL,
  `writing_help_conventions` smallint(6) DEFAULT NULL,
  `writing_help_citation` smallint(6) DEFAULT NULL,
  `writing_help_references` smallint(6) DEFAULT NULL,
  `writing_help_otherformal` smallint(6) DEFAULT NULL,
  `oral_help_nervousness` smallint(6) DEFAULT NULL,
  `oral_help_overall_structure` smallint(6) DEFAULT NULL,
  `oral_help_act_interact` smallint(6) DEFAULT NULL,
  `oral_help_interact_computer` smallint(6) DEFAULT NULL,
  `oral_help_bodylanguage` smallint(6) DEFAULT NULL,
  `oral_help_images` smallint(6) DEFAULT NULL,
  `oral_help_keeptime` smallint(6) DEFAULT NULL,
  `help_other` text,
  `ical_uid` varchar(255) NOT NULL DEFAULT '',
  `ical_sequence` smallint(6) NOT NULL DEFAULT '0',
  `ical_recur_id` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Trigger `mrbs_entry`
--
DROP TRIGGER IF EXISTS `ondeleteentry`;
DELIMITER $$
CREATE TRIGGER `ondeleteentry` BEFORE DELETE ON `mrbs_entry`
 FOR EACH ROW INSERT INTO mrbs_entry_delete
  select * from mrbs_entry where id = OLD.id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_entry_delete`
--

DROP TABLE IF EXISTS `mrbs_entry_delete`;
CREATE TABLE IF NOT EXISTS `mrbs_entry_delete` (
  `id` int(11) NOT NULL,
  `start_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `entry_type` int(11) NOT NULL DEFAULT '0',
  `repeat_id` int(11) DEFAULT NULL,
  `room_id` int(11) NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `instructor` varchar(50) DEFAULT NULL,
  `create_by` varchar(80) NOT NULL DEFAULT '',
  `modified_by` varchar(80) NOT NULL DEFAULT '',
  `name` varchar(80) NOT NULL DEFAULT '',
  `type` char(1) NOT NULL DEFAULT 'E',
  `description` text,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `reminded` int(11) DEFAULT NULL,
  `lang` varchar(2) NOT NULL DEFAULT 'en',
  `confirmation_code` varchar(255) DEFAULT NULL,
  `info_time` int(11) DEFAULT NULL,
  `info_user` varchar(80) DEFAULT NULL,
  `info_text` text,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `user_group` varchar(50) DEFAULT NULL,
  `program` varchar(100) DEFAULT NULL,
  `kth_program` varchar(50) DEFAULT NULL,
  `study_info` text,
  `previously` text,
  `subject_keywords` text,
  `campus` int(11) DEFAULT NULL,
  `my_campus` int(11) DEFAULT NULL,
  `kth_assignment` int(11) DEFAULT NULL,
  `kth_other_written_assignments` text DEFAULT NULL,
  `kth_other_oral_assignments` text DEFAULT NULL,
  `preferred_language` varchar(10) DEFAULT NULL,
  `consultation_info` text,
  `other_info` text,
  `understand_purpose_audience` smallint(6) DEFAULT NULL,
  `get_started_assignment` smallint(6) DEFAULT NULL,
  `understand_assignment_instruction` smallint(6) DEFAULT NULL,
  `main_message_argument_logic` smallint(6) DEFAULT NULL,
  `overall_structure_text` smallint(6) DEFAULT NULL,
  `paragraph_sentence_structure` smallint(6) DEFAULT NULL,
  `using_sources_support_argument` smallint(6) DEFAULT NULL,
  `presenting_data_discuss_result` smallint(6) DEFAULT NULL,
  `grammar_punctuation` smallint(6) DEFAULT NULL,
  `words_phrases` smallint(6) DEFAULT NULL,
  `academic_style` smallint(6) DEFAULT NULL,
  `pronuncation` smallint(6) DEFAULT NULL,
  `body_language_eye_contact` smallint(6) DEFAULT NULL,
  `communicate_visual_info` smallint(6) DEFAULT NULL,
  `present_digitally` smallint(6) DEFAULT NULL,
  `writing_help_get_started` smallint(6) DEFAULT NULL,
  `writing_help_overall_structure` smallint(6) DEFAULT NULL,
  `writing_help_paragraph_structure` smallint(6) DEFAULT NULL,
  `writing_help_sentence_construction` smallint(6) DEFAULT NULL,
  `writing_help_coherence_cohesion` smallint(6) DEFAULT NULL,
  `writing_help_style_formality` smallint(6) DEFAULT NULL,
  `writing_help_conventions` smallint(6) DEFAULT NULL,
  `writing_help_citation` smallint(6) DEFAULT NULL,
  `writing_help_references` smallint(6) DEFAULT NULL,
  `writing_help_otherformal` smallint(6) DEFAULT NULL,
  `oral_help_nervousness` smallint(6) DEFAULT NULL,
  `oral_help_overall_structure` smallint(6) DEFAULT NULL,
  `oral_help_act_interact` smallint(6) DEFAULT NULL,
  `oral_help_interact_computer` smallint(6) DEFAULT NULL,
  `oral_help_bodylanguage` smallint(6) DEFAULT NULL,
  `oral_help_images` smallint(6) DEFAULT NULL,
  `oral_help_keeptime` smallint(6) DEFAULT NULL,
  `help_other` text,
  `ical_uid` varchar(255) NOT NULL DEFAULT '',
  `ical_sequence` smallint(6) NOT NULL DEFAULT '0',
  `ical_recur_id` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Tabellstruktur `mrbs_entry_no_show`
--

DROP TABLE IF EXISTS `mrbs_entry_no_show`;
CREATE TABLE IF NOT EXISTS `mrbs_entry_no_show` (
  `id` int(11) NOT NULL,
  `start_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `entry_type` int(11) NOT NULL DEFAULT '0',
  `repeat_id` int(11) DEFAULT NULL,
  `room_id` int(11) NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `instructor` varchar(50) NOT NULL,
  `create_by` varchar(80) NOT NULL DEFAULT '',
  `modified_by` varchar(80) NOT NULL DEFAULT '',
  `name` varchar(80) NOT NULL DEFAULT '',
  `type` char(1) NOT NULL DEFAULT 'E',
  `description` text,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `reminded` int(11) DEFAULT NULL,
  `info_time` int(11) DEFAULT NULL,
  `info_user` varchar(80) DEFAULT NULL,
  `info_text` text,
  `ical_uid` varchar(255) NOT NULL DEFAULT '',
  `ical_sequence` smallint(6) NOT NULL DEFAULT '0',
  `ical_recur_id` varchar(16) DEFAULT NULL,
  `help_other` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_repeat`
--

DROP TABLE IF EXISTS `mrbs_repeat`;
CREATE TABLE IF NOT EXISTS `mrbs_repeat` (
  `id` int(11) NOT NULL,
  `start_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `rep_type` int(11) NOT NULL DEFAULT '0',
  `end_date` int(11) NOT NULL DEFAULT '0',
  `rep_opt` varchar(32) NOT NULL DEFAULT '',
  `room_id` int(11) NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `instructor` varchar(50) DEFAULT NULL,
  `create_by` varchar(80) NOT NULL DEFAULT '',
  `modified_by` varchar(80) NOT NULL DEFAULT '',
  `name` varchar(80) NOT NULL DEFAULT '',
  `type` char(1) NOT NULL DEFAULT 'E',
  `description` text,
  `rep_num_weeks` smallint(6) DEFAULT NULL,
  `month_absolute` smallint(6) DEFAULT NULL,
  `month_relative` varchar(4) DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `reminded` int(11) DEFAULT NULL,
  `lang` varchar(2) NOT NULL DEFAULT 'en',
  `confirmation_code` varchar(255) DEFAULT NULL,
  `info_time` int(11) DEFAULT NULL,
  `info_user` varchar(80) DEFAULT NULL,
  `info_text` text,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `user_group` varchar(50) DEFAULT NULL,
  `program` varchar(100) DEFAULT NULL,
  `kth_program` varchar(50) DEFAULT NULL,
  `study_info` text,
  `previously` text,
  `subject_keywords` text,
  `campus` int(11) DEFAULT NULL,
  `my_campus` int(11) DEFAULT NULL,
  `kth_assignment` int(11) DEFAULT NULL,
  `kth_other_written_assignments` text DEFAULT NULL,
  `kth_other_oral_assignments` text DEFAULT NULL,
  `preferred_language` varchar(10) DEFAULT NULL,
  `consultation_info` text,
  `other_info` text,
  `understand_purpose_audience` smallint(6) DEFAULT NULL,
  `get_started_assignment` smallint(6) DEFAULT NULL,
  `understand_assignment_instruction` smallint(6) DEFAULT NULL,
  `main_message_argument_logic` smallint(6) DEFAULT NULL,
  `overall_structure_text` smallint(6) DEFAULT NULL,
  `paragraph_sentence_structure` smallint(6) DEFAULT NULL,
  `using_sources_support_argument` smallint(6) DEFAULT NULL,
  `presenting_data_discuss_result` smallint(6) DEFAULT NULL,
  `grammar_punctuation` smallint(6) DEFAULT NULL,
  `words_phrases` smallint(6) DEFAULT NULL,
  `academic_style` smallint(6) DEFAULT NULL,
  `pronuncation` smallint(6) DEFAULT NULL,
  `body_language_eye_contact` smallint(6) DEFAULT NULL,
  `communicate_visual_info` smallint(6) DEFAULT NULL,
  `present_digitally` smallint(6) DEFAULT NULL,
  `writing_help_get_started` smallint(6) DEFAULT NULL,
  `writing_help_overall_structure` smallint(6) DEFAULT NULL,
  `writing_help_paragraph_structure` smallint(6) DEFAULT NULL,
  `writing_help_sentence_construction` smallint(6) DEFAULT NULL,
  `writing_help_coherence_cohesion` smallint(6) DEFAULT NULL,
  `writing_help_style_formality` smallint(6) DEFAULT NULL,
  `writing_help_conventions` smallint(6) DEFAULT NULL,
  `writing_help_citation` smallint(6) DEFAULT NULL,
  `writing_help_references` smallint(6) DEFAULT NULL,
  `writing_help_otherformal` smallint(6) DEFAULT NULL,
  `oral_help_nervousness` smallint(6) DEFAULT NULL,
  `oral_help_overall_structure` smallint(6) DEFAULT NULL,
  `oral_help_act_interact` smallint(6) DEFAULT NULL,
  `oral_help_interact_computer` smallint(6) DEFAULT NULL,
  `oral_help_bodylanguage` smallint(6) DEFAULT NULL,
  `oral_help_images` smallint(6) DEFAULT NULL,
  `oral_help_keeptime` smallint(6) DEFAULT NULL,
  `help_other` text,
  `ical_uid` varchar(255) NOT NULL DEFAULT '',
  `ical_sequence` smallint(6) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_room`
--

DROP TABLE IF EXISTS `mrbs_room`;
CREATE TABLE IF NOT EXISTS `mrbs_room` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '1',
  `area_id` int(11) NOT NULL DEFAULT '0',
  `room_name` varchar(100) NOT NULL DEFAULT '',
  `room_name_english` varchar(100) NOT NULL DEFAULT '',
  `sort_key` varchar(25) NOT NULL DEFAULT '',
  `exchange_email` varchar(100) DEFAULT NULL,
  `description` varchar(60) DEFAULT NULL,
  `capacity` int(11) NOT NULL DEFAULT '0',
  `room_admin_email` text,
  `custom_html` text,
  `custom_html_en` text,
  `room_number` varchar(4) NOT NULL DEFAULT '',
  `screen` tinyint(4) NOT NULL DEFAULT '0',
  `mailtext` text,
  `mailtext_en` text,
  `morningstarts_monday` int(11) DEFAULT '8',
  `morningstarts_minutes_monday` int(11) DEFAULT '0',
  `eveningends_monday` int(11) DEFAULT '20',
  `eveningends_minutes_monday` int(11) DEFAULT '0',
  `morningstarts_tuesday` int(11) DEFAULT '8',
  `morningstarts_minutes_tuesday` int(11) DEFAULT '0',
  `eveningends_tuesday` int(11) DEFAULT '20',
  `eveningends_minutes_tuesday` int(11) DEFAULT '0',
  `morningstarts_wednesday` int(11) DEFAULT '8',
  `morningstarts_minutes_wednesday` int(11) DEFAULT '0',
  `eveningends_wednesday` int(11) DEFAULT '20',
  `eveningends_minutes_wednesday` int(11) DEFAULT '0',
  `morningstarts_thursday` int(11) DEFAULT '8',
  `morningstarts_minutes_thursday` int(11) DEFAULT '0',
  `eveningends_thursday` int(11) DEFAULT '20',
  `eveningends_minutes_thursday` int(11) DEFAULT '0',
  `morningstarts_friday` int(11) DEFAULT '8',
  `morningstarts_minutes_friday` int(11) DEFAULT '0',
  `eveningends_friday` int(11) DEFAULT '18',
  `eveningends_minutes_friday` int(11) DEFAULT '0',
  `morningstarts_saturday` int(11) DEFAULT '10',
  `morningstarts_minutes_saturday` int(11) DEFAULT '0',
  `eveningends_saturday` int(11) DEFAULT '15',
  `eveningends_minutes_saturday` int(11) DEFAULT '0',
  `morningstarts_sunday` int(11) DEFAULT NULL,
  `morningstarts_minutes_sunday` int(11) DEFAULT NULL,
  `eveningends_sunday` int(11) DEFAULT NULL,
  `eveningends_minutes_sunday` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumpning av Data i tabell `mrbs_room`
--

-- Grupprum
INSERT INTO `mrbs_room` (`id`, `disabled`, `area_id`, `room_name`, `room_name_english`, `sort_key`, `exchange_email`, `description`, `capacity`, `room_admin_email`, `custom_html`, `room_number`, `screen`, `mailtext`, `mailtext_en`) VALUES
(1, 0, 1, 'Gästdator 1', 'Guest computer 1', '00', NULL, 'Gästdator', 8, '', 'Logga in bla bla', '0', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_users`
--

DROP TABLE IF EXISTS `mrbs_users`;
CREATE TABLE IF NOT EXISTS `mrbs_users` (
  `id` int(11) NOT NULL,
  `level` smallint(6) NOT NULL DEFAULT '0',
  `name` varchar(30) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `email` varchar(75) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_variables`
--

DROP TABLE IF EXISTS `mrbs_variables`;
CREATE TABLE IF NOT EXISTS `mrbs_variables` (
  `id` int(11) NOT NULL,
  `variable_name` varchar(80) DEFAULT NULL,
  `variable_content` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumpning av Data i tabell `mrbs_variables`
--

INSERT INTO `mrbs_variables` (`id`, `variable_name`, `variable_content`) VALUES
(1, 'db_version', '47'),
(2, 'local_db_version', '1');

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_zoneinfo`
--

DROP TABLE IF EXISTS `mrbs_zoneinfo`;
CREATE TABLE IF NOT EXISTS `mrbs_zoneinfo` (
  `id` int(11) NOT NULL,
  `timezone` varchar(255) NOT NULL DEFAULT '',
  `outlook_compatible` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `vtimezone` text,
  `last_updated` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumpning av Data i tabell `mrbs_zoneinfo`
--

INSERT INTO `mrbs_zoneinfo` (`id`, `timezone`, `outlook_compatible`, `vtimezone`, `last_updated`) VALUES
(1, 'Europe/Stockholm', 1, 'BEGIN:VTIMEZONE\r\nTZID:Europe/Stockholm\r\nTZURL:http://tzurl.org/zoneinfo-outlook/Europe/Stockholm\r\nX-LIC-LOCATION:Europe/Stockholm\r\nBEGIN:DAYLIGHT\r\nTZOFFSETFROM:+0100\r\nTZOFFSETTO:+0200\r\nTZNAME:CEST\r\nDTSTART:19700329T020000\r\nRRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=-1SU\r\nEND:DAYLIGHT\r\nBEGIN:STANDARD\r\nTZOFFSETFROM:+0200\r\nTZOFFSETTO:+0100\r\nTZNAME:CET\r\nDTSTART:19701025T030000\r\nRRULE:FREQ=YEARLY;BYMONTH=10;BYDAY=-1SU\r\nEND:STANDARD\r\nEND:VTIMEZONE', 1580482785);

--
-- Index för dumpade tabeller
--

--
-- Index för tabell `kth_areatype`
--
ALTER TABLE `kth_areatype`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `kth_entry_custom_fields`
--
ALTER TABLE `kth_entry_custom_fields`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `kth_exchange_events`
--
ALTER TABLE `kth_exchange_events`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `mrbs_kth_closed_periods`
--
ALTER TABLE `mrbs_kth_closed_periods`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `kth_instructors`
--
ALTER TABLE `kth_instructors`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `kth_periods`
--
ALTER TABLE `kth_periods`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `kth_places`
--
ALTER TABLE `kth_places`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `kth_entry_places`
--
ALTER TABLE `kth_entry_places`
ADD PRIMARY KEY (`id`);

--
-- Index för tabell `kth_assignments`
--
ALTER TABLE `kth_assignments`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `kth_campus`
--
ALTER TABLE `kth_campus`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `mrbs_area`
--
ALTER TABLE `mrbs_area`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_area_name` (`area_name`);

--
-- Index för tabell `mrbs_entry`
--
ALTER TABLE `mrbs_entry`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `repeat_id` (`repeat_id`),
  ADD KEY `idxStartTime` (`start_time`),
  ADD KEY `idxEndTime` (`end_time`);

--
-- Index för tabell `mrbs_entry_no_show`
--
ALTER TABLE `mrbs_entry_no_show`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unikt_index` (`start_time`,`room_id`,`create_by`) USING BTREE,
  ADD KEY `room_id` (`room_id`),
  ADD KEY `repeat_id` (`repeat_id`),
  ADD KEY `idxStartTime` (`start_time`),
  ADD KEY `idxEndTime` (`end_time`);

--
-- Index för tabell `mrbs_repeat`
--
ALTER TABLE `mrbs_repeat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`);

--
-- Index för tabell `mrbs_room`
--
ALTER TABLE `mrbs_room`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_room_name` (`area_id`,`room_name`),
  ADD KEY `idxSortKey` (`sort_key`);

--
-- Index för tabell `mrbs_users`
--
ALTER TABLE `mrbs_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_name` (`name`);

--
-- Index för tabell `mrbs_variables`
--
ALTER TABLE `mrbs_variables`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_variable_name` (`variable_name`);

--
-- Index för tabell `mrbs_zoneinfo`
--
ALTER TABLE `mrbs_zoneinfo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_timezone` (`timezone`,`outlook_compatible`);

--
-- AUTO_INCREMENT för dumpade tabeller
--

--
-- AUTO_INCREMENT för tabell `kth_areatype`
--
ALTER TABLE `kth_areatype`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `kth_entry_custom_fields`
--
ALTER TABLE `kth_entry_custom_fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `kth_exchange_events`
--
ALTER TABLE `kth_exchange_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `mrbs_kth_closed_periods`
--
ALTER TABLE `mrbs_kth_closed_periods`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `kth_instructors`
--
ALTER TABLE `kth_instructors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `kth_periods`
--
ALTER TABLE `kth_periods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `kth_places`
--
ALTER TABLE `kth_places`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT för tabell `kth_entry_places`
--

ALTER TABLE `kth_entry_places`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT för tabell `kth_assignments`
--
ALTER TABLE `kth_assignments` 
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT för tabell `kth_campus`
--
ALTER TABLE `kth_campus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT för tabell `mrbs_area`
--
ALTER TABLE `mrbs_area`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `mrbs_entry`
--
ALTER TABLE `mrbs_entry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `mrbs_entry_no_show`
--
ALTER TABLE `mrbs_entry_no_show`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `mrbs_repeat`
--
ALTER TABLE `mrbs_repeat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `mrbs_room`
--
ALTER TABLE `mrbs_room`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `mrbs_users`
--
ALTER TABLE `mrbs_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `mrbs_variables`
--
ALTER TABLE `mrbs_variables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `mrbs_zoneinfo`
--
ALTER TABLE `mrbs_zoneinfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restriktioner för dumpade tabeller
--

--
-- Restriktioner för tabell `mrbs_entry`
--
ALTER TABLE `mrbs_entry`
  ADD CONSTRAINT `mrbs_entry_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `mrbs_room` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `mrbs_entry_ibfk_2` FOREIGN KEY (`repeat_id`) REFERENCES `mrbs_repeat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restriktioner för tabell `mrbs_entry_no_show`
--
ALTER TABLE `mrbs_entry_no_show`
  ADD CONSTRAINT `mrbs_entry_no_show_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `mrbs_room` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `mrbs_entry_no_show_ibfk_2` FOREIGN KEY (`repeat_id`) REFERENCES `mrbs_repeat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restriktioner för tabell `mrbs_repeat`
--
ALTER TABLE `mrbs_repeat`
  ADD CONSTRAINT `mrbs_repeat_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `mrbs_room` (`id`) ON UPDATE CASCADE;

--
-- Restriktioner för tabell `mrbs_room`
--
ALTER TABLE `mrbs_room`
  ADD CONSTRAINT `mrbs_room_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `mrbs_area` (`id`) ON UPDATE CASCADE;


--
-- Tabellstruktur `kth_radio_values`
--
DROP TABLE IF EXISTS `kth_radio_values`;
CREATE TABLE IF NOT EXISTS `kth_radio_values` (
  `id` int(11) NOT NULL,
  `entry_field_name` varchar(50) NOT NULL,
  `radio_id` int(11) NOT NULL,
  `value_en` varchar(100) NOT NULL,
  `value_sv` varchar(100) NOT NULL,
  `default_choice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Index för tabell `kth_radio_values`
--
ALTER TABLE `kth_radio_values`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT för tabell `kth_radio_values`
--
ALTER TABLE `kth_radio_values`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

  INSERT INTO `kth_radio_values` (`entry_field_name`, `radio_id`, `value_en`, `value_sv`, `default_choice`) VALUES 
  ('understand_purpose_audience', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('understand_purpose_audience', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('get_started_assignment', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('get_started_assignment', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('understand_assignment_instruction', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('understand_assignment_instruction', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('main_message_argument_logic', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('main_message_argument_logic', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('overall_structure_text', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('overall_structure_text', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('paragraph_sentence_structure', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('paragraph_sentence_structure', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('using_sources_support_argument', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('using_sources_support_argument', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('presenting_data_discuss_result', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('presenting_data_discuss_result', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('grammar_punctuation', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('grammar_punctuation', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('words_phrases', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('words_phrases', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('academic_style', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('academic_style', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('pronuncation', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('pronuncation', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('body_language_eye_contact', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('body_language_eye_contact', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('communicate_visual_info', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('communicate_visual_info', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('present_digitally', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('present_digitally', '2', 'I''d like to discuss', 'Jag vill diskutera', '0');
