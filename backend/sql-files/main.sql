-- 
-- Table structure for table `content`
-- 

CREATE TABLE IF NOT EXISTS `content` (
	`doc_id` bigint(20) unsigned NOT NULL,
	`word_id` bigint(20) unsigned NOT NULL,
	`font_size` tinyint(4) unsigned NOT NULL
) ENGINE=MyISAM;
-- 
-- Table structure for table documents
-- 

CREATE TABLE IF NOT EXISTS `documents` (
	`id` bigint(20) unsigned NOT NULL auto_increment,
	`url` varchar(200) NOT NULL,
	`title` varchar(80) NOT NULL default '',
	PRIMARY KEY (`id`)
) ENGINE=MyISAM;

ALTER TABLE `documents` ADD UNIQUE INDEX (`url`);

-- 
-- Table structure for table lexicon
-- 

CREATE TABLE IF NOT EXISTS `lexicon` (
	`id` bigint(20) unsigned NOT NULL auto_increment,
	`word` varchar(100) NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=MyISAM;

ALTER TABLE `lexicon` ADD UNIQUE INDEX (`word`);

-- 
-- Table structure for table links
-- 

CREATE TABLE IF NOT EXISTS `links` (
	`from` bigint(20) NOT NULL,
	`to` bigint(20) NOT NULL,
	`n` smallint(4) unsigned NOT NULL default '0'
) ENGINE=MyISAM;

-- 
-- Table structure for table rank
-- 

CREATE TABLE IF NOT EXISTS `rank` (
	`page` bigint(20) NOT NULL,
	`rank` double NOT NULL default '0',
	PRIMARY KEY(`page`)
) ENGINE=MyISAM;

