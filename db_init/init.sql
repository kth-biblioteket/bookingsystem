-- phpMyAdmin SQL Dump
-- version 4.4.8
-- http://www.phpmyadmin.net
--
-- Värd: localhost
-- Tid vid skapande: 02 jul 2023 kl 20:15
-- Serverversion: 5.6.24-log
-- PHP-version: 7.2.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_areatype`
--

CREATE TABLE IF NOT EXISTS `kth_areatype` (
  `id` int(11) NOT NULL,
  `areatype` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_assignments`
--

CREATE TABLE IF NOT EXISTS `kth_assignments` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(4) NOT NULL DEFAULT '0',
  `sort_key` varchar(25) NOT NULL,
  `name` varchar(100) NOT NULL,
  `name_en` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_entry_custom_fields`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_entry_places`
--

CREATE TABLE IF NOT EXISTS `kth_entry_places` (
  `id` int(11) NOT NULL,
  `entry_id` int(11) NOT NULL,
  `places_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_exchange_events`
--

CREATE TABLE IF NOT EXISTS `kth_exchange_events` (
  `id` int(11) NOT NULL,
  `entry_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `event_id` varchar(200) NOT NULL,
  `change_key` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

CREATE TABLE IF NOT EXISTS `kth_instructors` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(4) NOT NULL DEFAULT '0',
  `area_id` int(11) NOT NULL DEFAULT '0',
  `sort_key` varchar(25) NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_periods`
--

CREATE TABLE IF NOT EXISTS `kth_periods` (
  `id` int(11) NOT NULL,
  `start_time` varchar(5) NOT NULL,
  `end_time` varchar(5) NOT NULL,
  `entry_start_time` varchar(5) NOT NULL,
  `weekday` int(11) NOT NULL DEFAULT '0',
  `area_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_places`
--

CREATE TABLE IF NOT EXISTS `kth_places` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(4) NOT NULL DEFAULT '0',
  `default_choice` int(11) DEFAULT '0',
  `room_id` int(11) NOT NULL DEFAULT '0',
  `sort_key` varchar(25) NOT NULL,
  `name` varchar(100) NOT NULL,
  `name_en` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_radio_values`
--

CREATE TABLE IF NOT EXISTS `kth_radio_values` (
  `id` int(11) NOT NULL,
  `entry_field_name` varchar(50) NOT NULL,
  `radio_id` int(11) NOT NULL,
  `value_en` varchar(100) NOT NULL,
  `value_sv` varchar(100) NOT NULL,
  `default_choice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_area`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_entry`
--

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
  `kth_other_written_assignments` text,
  `kth_other_oral_assignments` text,
  `preferred_language` varchar(10) DEFAULT NULL,
  `consultation_info` text,
  `other_info` text,
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
  `ical_recur_id` varchar(16) DEFAULT NULL,
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
  `present_digitally` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Trigger `mrbs_entry`
--
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
  `kth_other_written_assignments` text,
  `kth_other_oral_assignments` text,
  `preferred_language` varchar(10) DEFAULT NULL,
  `consultation_info` text,
  `other_info` text,
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
  `ical_recur_id` varchar(16) DEFAULT NULL,
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
  `present_digitally` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_entry_no_show`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_repeat`
--

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
  `kth_other_written_assignments` text,
  `kth_other_oral_assignments` text,
  `preferred_language` varchar(10) DEFAULT NULL,
  `consultation_info` text,
  `other_info` text,
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
  `present_digitally` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_room`
--

CREATE TABLE IF NOT EXISTS `mrbs_room` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `area_id` int(11) NOT NULL DEFAULT '0',
  `room_name` varchar(100) NOT NULL DEFAULT '',
  `room_name_english` varchar(100) NOT NULL DEFAULT '',
  `sort_key` varchar(25) NOT NULL DEFAULT '',
  `exchange_email` varchar(100) DEFAULT NULL,
  `description` varchar(60) DEFAULT NULL,
  `capacity` int(11) NOT NULL DEFAULT '0',
  `room_admin_email` text,
  `custom_html` text,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_users`
--

CREATE TABLE IF NOT EXISTS `mrbs_users` (
  `id` int(11) NOT NULL,
  `level` smallint(6) NOT NULL DEFAULT '0',
  `name` varchar(30) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `email` varchar(75) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_variables`
--

CREATE TABLE IF NOT EXISTS `mrbs_variables` (
  `id` int(11) NOT NULL,
  `variable_name` varchar(80) DEFAULT NULL,
  `variable_content` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_zoneinfo`
--

CREATE TABLE IF NOT EXISTS `mrbs_zoneinfo` (
  `id` int(11) NOT NULL,
  `timezone` varchar(255) NOT NULL DEFAULT '',
  `outlook_compatible` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `vtimezone` text,
  `last_updated` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index för dumpade tabeller
--

--
-- Index för tabell `kth_areatype`
--
ALTER TABLE `kth_areatype`
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
-- Index för tabell `kth_entry_custom_fields`
--
ALTER TABLE `kth_entry_custom_fields`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `kth_entry_places`
--
ALTER TABLE `kth_entry_places`
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
-- Index för tabell `kth_radio_values`
--
ALTER TABLE `kth_radio_values`
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
-- AUTO_INCREMENT för tabell `kth_entry_custom_fields`
--
ALTER TABLE `kth_entry_custom_fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `kth_entry_places`
--
ALTER TABLE `kth_entry_places`
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
-- AUTO_INCREMENT för tabell `kth_radio_values`
--
ALTER TABLE `kth_radio_values`
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
