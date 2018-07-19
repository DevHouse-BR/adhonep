-- phpMyAdmin SQL Dump
-- version 2.11.7
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tempo de Geração: Set 23, 2009 as 10:20 PM
-- Versão do Servidor: 5.0.51
-- Versão do PHP: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Banco de Dados: `adhonep`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `atributospessoais`
--

CREATE TABLE IF NOT EXISTS `atributospessoais` (
  `idatributospessoais` int(10) unsigned NOT NULL auto_increment,
  `atributo` varchar(255) character set latin1 NOT NULL,
  `aplicacao` tinyint(4) NOT NULL,
  PRIMARY KEY  (`idatributospessoais`),
  KEY `atributo` (`atributo`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Extraindo dados da tabela `atributospessoais`
--

INSERT INTO `atributospessoais` (`idatributospessoais`, `atributo`, `aplicacao`) VALUES
(1, 'Líder', 3),
(2, 'Preletor', 1),
(3, 'Comunicação', 3),
(4, 'Mestre Cerimônia', 1),
(5, 'Músico', 1),
(6, '5 Minutos', 1),
(7, 'Tesoureiro', 2),
(8, 'Vice', 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `cidades`
--

CREATE TABLE IF NOT EXISTS `cidades` (
  `idcidades` int(10) unsigned NOT NULL auto_increment,
  `cidade` varchar(100) character set latin1 NOT NULL,
  `capitulo` varchar(50) default NULL,
  `imagem` varchar(255) character set latin1 default NULL,
  `desc` text character set latin1,
  PRIMARY KEY  (`idcidades`),
  UNIQUE KEY `cidade` (`cidade`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Cidades do sistema' AUTO_INCREMENT=16 ;

--
-- Extraindo dados da tabela `cidades`
--

INSERT INTO `cidades` (`idcidades`, `cidade`, `capitulo`, `imagem`, `desc`) VALUES
(1, 'Joinville', NULL, NULL, 'Cidade de Joinville'),
(2, 'Blumenau', NULL, 'adho.gif', 'fdsa fdsa fdsa fdsa<br>'),
(3, 'Itajaí', NULL, '00_evento27-09.gif', '?hjyfdjkfgkjfkgf'),
(4, 'Brusque', '', '07_evento27-09.jpg', 'fdsa fdas fdsa fdsa f<br>'),
(5, 'Florianópolis', NULL, '10.jpg', '?fd safdjh djdf<br>'),
(6, 'São Paulo', NULL, '07--Apoio-Jovem-26.04_.2008_.jpg', 'saf das fdas fdas fdas<br>'),
(7, 'Lages', NULL, 'camila_rodrigues.jpg', '?Cidade de Lages'),
(9, 'Curitiba', NULL, NULL, ''),
(10, 'Jaraguá', NULL, 'community_users.png', 'fdsaf dsa fdsa fdsa fdsa <br>'),
(11, 'Caraticuiba', NULL, 'close.png', 'fdsafdsafdsa'),
(12, 'Nova Iorque', NULL, 'application_view_list.png', '&nbsp;yrjgfs hfd agfagh fdag fagfa<br>'),
(14, 'Smallville', '1321', NULL, 'f dsa fdasg sag dsaf dsa fdsaf dsa fdsa<br>'),
(15, 'São Tomé das Letras', '1321', NULL, 'f dsa fdasg sag dsaf dsa fdsaf dsa fdsa<br>');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cidades_atributospessoais_pessoas`
--

CREATE TABLE IF NOT EXISTS `cidades_atributospessoais_pessoas` (
  `idcidades` int(10) unsigned NOT NULL,
  `idatributospessoais` int(10) unsigned NOT NULL,
  `idpessoas` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`idcidades`,`idatributospessoais`,`idpessoas`),
  KEY `fk_cidades_has_atributospessoais_cidades1` (`idcidades`),
  KEY `fk_cidades_has_atributospessoais_atributospessoais1` (`idatributospessoais`),
  KEY `fk_cidades_has_atributospessoais_pessoas1` (`idpessoas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `cidades_atributospessoais_pessoas`
--

INSERT INTO `cidades_atributospessoais_pessoas` (`idcidades`, `idatributospessoais`, `idpessoas`) VALUES
(4, 3, 55),
(14, 1, 15),
(14, 3, 22),
(14, 7, 54),
(14, 8, 43),
(15, 1, 15),
(15, 3, 22),
(15, 7, 54),
(15, 8, 43);

-- --------------------------------------------------------

--
-- Estrutura da tabela `downloads`
--

CREATE TABLE IF NOT EXISTS `downloads` (
  `iddownloads` int(10) unsigned NOT NULL auto_increment,
  `arquivo` varchar(255) NOT NULL,
  `caminho` varchar(255) NOT NULL,
  `uploader` int(10) unsigned NOT NULL,
  `autor` varchar(255) default NULL,
  PRIMARY KEY  (`iddownloads`),
  KEY `fk_downloads_pessoas1` (`uploader`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Extraindo dados da tabela `downloads`
--

INSERT INTO `downloads` (`iddownloads`, `arquivo`, `caminho`, `uploader`, `autor`) VALUES
(5, 'fdsafdsa', 'Joomla_novos_grupos.pdf', 1, 'fdsafdsa'),
(6, 'uyhtwtrew', 'motherboard_manual_ga-946gm-ds2_(s2)_e.pdf', 1, 'fdsafdsadfsa'),
(7, 'aaaa', 'adhonep.sql_.zip', 1, 'fdafdsa'),
(8, 'aaaaaaaaaaaaa', 'UHARC_GUI.2007-01-19_.zip', 1, 'aaa'),
(12, 'gdsfdasfgdsa', 'CurriculumVitae_Leonardo.pdf', 1, 'ffdafdsa');

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_banner`
--

CREATE TABLE IF NOT EXISTS `jos_banner` (
  `bid` int(11) NOT NULL auto_increment,
  `cid` int(11) NOT NULL default '0',
  `type` varchar(30) NOT NULL default 'banner',
  `name` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `imptotal` int(11) NOT NULL default '0',
  `impmade` int(11) NOT NULL default '0',
  `clicks` int(11) NOT NULL default '0',
  `imageurl` varchar(100) NOT NULL default '',
  `clickurl` varchar(200) NOT NULL default '',
  `date` datetime default NULL,
  `showBanner` tinyint(1) NOT NULL default '0',
  `checked_out` tinyint(1) NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `editor` varchar(50) default NULL,
  `custombannercode` text,
  `catid` int(10) unsigned NOT NULL default '0',
  `description` text NOT NULL,
  `sticky` tinyint(1) unsigned NOT NULL default '0',
  `ordering` int(11) NOT NULL default '0',
  `publish_up` datetime NOT NULL default '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL default '0000-00-00 00:00:00',
  `tags` text NOT NULL,
  `params` text NOT NULL,
  PRIMARY KEY  (`bid`),
  KEY `viewbanner` (`showBanner`),
  KEY `idx_banner_catid` (`catid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `jos_banner`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_bannerclient`
--

CREATE TABLE IF NOT EXISTS `jos_bannerclient` (
  `cid` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `contact` varchar(255) NOT NULL default '',
  `email` varchar(255) NOT NULL default '',
  `extrainfo` text NOT NULL,
  `checked_out` tinyint(1) NOT NULL default '0',
  `checked_out_time` time default NULL,
  `editor` varchar(50) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `jos_bannerclient`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_bannertrack`
--

CREATE TABLE IF NOT EXISTS `jos_bannertrack` (
  `track_date` date NOT NULL,
  `track_type` int(10) unsigned NOT NULL,
  `banner_id` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `jos_bannertrack`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_categories`
--

CREATE TABLE IF NOT EXISTS `jos_categories` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) NOT NULL default '0',
  `title` varchar(255) NOT NULL default '',
  `name` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `image` varchar(255) NOT NULL default '',
  `section` varchar(50) NOT NULL default '',
  `image_position` varchar(30) NOT NULL default '',
  `description` text NOT NULL,
  `published` tinyint(1) NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `editor` varchar(50) default NULL,
  `ordering` int(11) NOT NULL default '0',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `count` int(11) NOT NULL default '0',
  `params` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `cat_idx` (`section`,`published`,`access`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `jos_categories`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_components`
--

CREATE TABLE IF NOT EXISTS `jos_components` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL default '',
  `link` varchar(255) NOT NULL default '',
  `menuid` int(11) unsigned NOT NULL default '0',
  `parent` int(11) unsigned NOT NULL default '0',
  `admin_menu_link` varchar(255) NOT NULL default '',
  `admin_menu_alt` varchar(255) NOT NULL default '',
  `option` varchar(50) NOT NULL default '',
  `ordering` int(11) NOT NULL default '0',
  `admin_menu_img` varchar(255) NOT NULL default '',
  `iscore` tinyint(4) NOT NULL default '0',
  `params` text NOT NULL,
  `enabled` tinyint(4) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `parent_option` (`parent`,`option`(32))
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;

--
-- Extraindo dados da tabela `jos_components`
--

INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES
(1, 'Banners', '', 0, 0, '', 'Banner Management', 'com_banners', 0, 'js/ThemeOffice/component.png', 0, 'track_impressions=0\ntrack_clicks=0\ntag_prefix=\n\n', 1),
(2, 'Banners', '', 0, 1, 'option=com_banners', 'Active Banners', 'com_banners', 1, 'js/ThemeOffice/edit.png', 0, '', 1),
(3, 'Clients', '', 0, 1, 'option=com_banners&c=client', 'Manage Clients', 'com_banners', 2, 'js/ThemeOffice/categories.png', 0, '', 1),
(4, 'Web Links', 'option=com_weblinks', 0, 0, '', 'Manage Weblinks', 'com_weblinks', 0, 'js/ThemeOffice/component.png', 0, 'show_comp_description=1\ncomp_description=\nshow_link_hits=1\nshow_link_description=1\nshow_other_cats=1\nshow_headings=1\nshow_page_title=1\nlink_target=0\nlink_icons=\n\n', 1),
(5, 'Links', '', 0, 4, 'option=com_weblinks', 'View existing weblinks', 'com_weblinks', 1, 'js/ThemeOffice/edit.png', 0, '', 1),
(6, 'Categories', '', 0, 4, 'option=com_categories&section=com_weblinks', 'Manage weblink categories', '', 2, 'js/ThemeOffice/categories.png', 0, '', 1),
(7, 'Contacts', 'option=com_contact', 0, 0, '', 'Edit contact details', 'com_contact', 0, 'js/ThemeOffice/component.png', 1, 'contact_icons=0\nicon_address=\nicon_email=\nicon_telephone=\nicon_fax=\nicon_misc=\nshow_headings=1\nshow_position=1\nshow_email=0\nshow_telephone=1\nshow_mobile=1\nshow_fax=1\nbannedEmail=\nbannedSubject=\nbannedText=\nsession=1\ncustomReply=0\n\n', 1),
(8, 'Contacts', '', 0, 7, 'option=com_contact', 'Edit contact details', 'com_contact', 0, 'js/ThemeOffice/edit.png', 1, '', 1),
(9, 'Categories', '', 0, 7, 'option=com_categories&section=com_contact_details', 'Manage contact categories', '', 2, 'js/ThemeOffice/categories.png', 1, 'contact_icons=0\nicon_address=\nicon_email=\nicon_telephone=\nicon_fax=\nicon_misc=\nshow_headings=1\nshow_position=1\nshow_email=0\nshow_telephone=1\nshow_mobile=1\nshow_fax=1\nbannedEmail=\nbannedSubject=\nbannedText=\nsession=1\ncustomReply=0\n\n', 1),
(10, 'Polls', 'option=com_poll', 0, 0, 'option=com_poll', 'Manage Polls', 'com_poll', 0, 'js/ThemeOffice/component.png', 0, '', 1),
(11, 'News Feeds', 'option=com_newsfeeds', 0, 0, '', 'News Feeds Management', 'com_newsfeeds', 0, 'js/ThemeOffice/component.png', 0, '', 1),
(12, 'Feeds', '', 0, 11, 'option=com_newsfeeds', 'Manage News Feeds', 'com_newsfeeds', 1, 'js/ThemeOffice/edit.png', 0, 'show_headings=1\nshow_name=1\nshow_articles=1\nshow_link=1\nshow_cat_description=1\nshow_cat_items=1\nshow_feed_image=1\nshow_feed_description=1\nshow_item_description=1\nfeed_word_count=0\n\n', 1),
(13, 'Categories', '', 0, 11, 'option=com_categories&section=com_newsfeeds', 'Manage Categories', '', 2, 'js/ThemeOffice/categories.png', 0, '', 1),
(14, 'User', 'option=com_user', 0, 0, '', '', 'com_user', 0, '', 1, '', 1),
(15, 'Search', 'option=com_search', 0, 0, 'option=com_search', 'Search Statistics', 'com_search', 0, 'js/ThemeOffice/component.png', 1, 'enabled=0\n\n', 1),
(16, 'Categories', '', 0, 1, 'option=com_categories&section=com_banner', 'Categories', '', 3, '', 1, '', 1),
(17, 'Wrapper', 'option=com_wrapper', 0, 0, '', 'Wrapper', 'com_wrapper', 0, '', 1, '', 1),
(18, 'Mail To', '', 0, 0, '', '', 'com_mailto', 0, '', 1, '', 1),
(19, 'Media Manager', '', 0, 0, 'option=com_media', 'Media Manager', 'com_media', 0, '', 1, 'upload_extensions=bmp,csv,doc,epg,gif,ico,jpg,odg,odp,ods,odt,pdf,png,ppt,swf,txt,xcf,xls,BMP,CSV,DOC,EPG,GIF,ICO,JPG,ODG,ODP,ODS,ODT,PDF,PNG,PPT,SWF,TXT,XCF,XLS\nupload_maxsize=10000000\nfile_path=images\nimage_path=images/stories\nrestrict_uploads=1\nallowed_media_usergroup=3\ncheck_mime=1\nimage_extensions=bmp,gif,jpg,png\nignore_extensions=\nupload_mime=image/jpeg,image/gif,image/png,image/bmp,application/x-shockwave-flash,application/msword,application/excel,application/pdf,application/powerpoint,text/plain,application/x-zip\nupload_mime_illegal=text/html\nenable_flash=0\n\n', 1),
(20, 'Articles', 'option=com_content', 0, 0, '', '', 'com_content', 0, '', 1, 'show_noauth=0\nshow_title=1\nlink_titles=0\nshow_intro=1\nshow_section=0\nlink_section=0\nshow_category=0\nlink_category=0\nshow_author=1\nshow_create_date=1\nshow_modify_date=1\nshow_item_navigation=0\nshow_readmore=1\nshow_vote=0\nshow_icons=1\nshow_pdf_icon=1\nshow_print_icon=1\nshow_email_icon=1\nshow_hits=1\nfeed_summary=0\n\n', 1),
(21, 'Configuration Manager', '', 0, 0, '', 'Configuration', 'com_config', 0, '', 1, '', 1),
(22, 'Installation Manager', '', 0, 0, '', 'Installer', 'com_installer', 0, '', 1, '', 1),
(23, 'Language Manager', '', 0, 0, '', 'Languages', 'com_languages', 0, '', 1, 'site=pt-BR\nadministrator=pt-BR\n\n', 1),
(24, 'Mass mail', '', 0, 0, '', 'Mass Mail', 'com_massmail', 0, '', 1, 'mailSubjectPrefix=\nmailBodySuffix=\n\n', 1),
(25, 'Menu Editor', '', 0, 0, '', 'Menu Editor', 'com_menus', 0, '', 1, '', 1),
(27, 'Messaging', '', 0, 0, '', 'Messages', 'com_messages', 0, '', 1, '', 1),
(28, 'Modules Manager', '', 0, 0, '', 'Modules', 'com_modules', 0, '', 1, '', 1),
(29, 'Plugin Manager', '', 0, 0, '', 'Plugins', 'com_plugins', 0, '', 1, '', 1),
(30, 'Template Manager', '', 0, 0, '', 'Templates', 'com_templates', 0, '', 1, '', 1),
(31, 'User Manager', '', 0, 0, '', 'Users', 'com_users', 0, '', 1, 'allowUserRegistration=1\nnew_usertype=Registered\nuseractivation=1\nfrontend_userparams=1\n\n', 1),
(32, 'Cache Manager', '', 0, 0, '', 'Cache', 'com_cache', 0, '', 1, '', 1),
(33, 'Control Panel', '', 0, 0, '', 'Control Panel', 'com_cpanel', 0, '', 1, '', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_contact_details`
--

CREATE TABLE IF NOT EXISTS `jos_contact_details` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `con_position` varchar(255) default NULL,
  `address` text,
  `suburb` varchar(100) default NULL,
  `state` varchar(100) default NULL,
  `country` varchar(100) default NULL,
  `postcode` varchar(100) default NULL,
  `telephone` varchar(255) default NULL,
  `fax` varchar(255) default NULL,
  `misc` mediumtext,
  `image` varchar(255) default NULL,
  `imagepos` varchar(20) default NULL,
  `email_to` varchar(255) default NULL,
  `default_con` tinyint(1) unsigned NOT NULL default '0',
  `published` tinyint(1) unsigned NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL default '0',
  `params` text NOT NULL,
  `user_id` int(11) NOT NULL default '0',
  `catid` int(11) NOT NULL default '0',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `mobile` varchar(255) NOT NULL default '',
  `webpage` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `catid` (`catid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `jos_contact_details`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_content`
--

CREATE TABLE IF NOT EXISTS `jos_content` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `title_alias` varchar(255) NOT NULL default '',
  `introtext` mediumtext NOT NULL,
  `fulltext` mediumtext NOT NULL,
  `state` tinyint(3) NOT NULL default '0',
  `sectionid` int(11) unsigned NOT NULL default '0',
  `mask` int(11) unsigned NOT NULL default '0',
  `catid` int(11) unsigned NOT NULL default '0',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_by` int(11) unsigned NOT NULL default '0',
  `created_by_alias` varchar(255) NOT NULL default '',
  `modified` datetime NOT NULL default '0000-00-00 00:00:00',
  `modified_by` int(11) unsigned NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL default '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL default '0000-00-00 00:00:00',
  `images` text NOT NULL,
  `urls` text NOT NULL,
  `attribs` text NOT NULL,
  `version` int(11) unsigned NOT NULL default '1',
  `parentid` int(11) unsigned NOT NULL default '0',
  `ordering` int(11) NOT NULL default '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `access` int(11) unsigned NOT NULL default '0',
  `hits` int(11) unsigned NOT NULL default '0',
  `metadata` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `idx_section` (`sectionid`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `jos_content`
--

INSERT INTO `jos_content` (`id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`) VALUES
(1, 'dfadsa', 'fdsafdsa', '', '<p><span style="color: #000000; font-family: ''Times New Roman''; font-size: medium; line-height: normal;"> </span></p>\r\n<div style="color: #333333; font-family: Tahoma, Helvetica, Arial, sans-serif; font-size: 76%; background-image: initial; background-repeat: initial; background-attachment: initial; -webkit-background-clip: initial; -webkit-background-origin: initial; background-color: #ffffff; line-height: 1.3em; background-position: initial initial; margin: 0px;">\r\n<p style="margin-top: 10px; margin-bottom: 15px;"><span style="color: #000000; font-family: ''Times New Roman''; font-size: medium; line-height: normal;"> </span></p>\r\n<div style="color: #333333; font-family: Tahoma, Helvetica, Arial, sans-serif; font-size: 76%; background-image: initial; background-repeat: initial; background-attachment: initial; -webkit-background-clip: initial; -webkit-background-origin: initial; background-color: #ffffff; line-height: 1.3em; background-position: initial initial; margin: 0px;">\r\n<p style="margin-top: 10px; margin-bottom: 15px;"> </p>\r\n<div style="color: #333333; font-family: Tahoma, Helvetica, Arial, sans-serif; font-size: 12px; background-image: initial; background-repeat: initial; background-attachment: initial; -webkit-background-clip: initial; -webkit-background-origin: initial; background-color: #ffffff; line-height: 1.3em; margin: 0px;">\r\n<p style="margin-top: 10px; margin-bottom: 15px;">fd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd</p>\r\n</div>\r\n</div>\r\n<p> </p>\r\n</div>\r\n<p> </p>', '', 1, 0, 0, 0, '2009-09-22 02:41:41', 62, '', '2009-09-22 12:59:48', 62, 0, '0000-00-00 00:00:00', '2009-09-22 02:41:41', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 2, 0, 1, '', '', 0, 0, 'robots=\nauthor=');

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_content_frontpage`
--

CREATE TABLE IF NOT EXISTS `jos_content_frontpage` (
  `content_id` int(11) NOT NULL default '0',
  `ordering` int(11) NOT NULL default '0',
  PRIMARY KEY  (`content_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `jos_content_frontpage`
--

INSERT INTO `jos_content_frontpage` (`content_id`, `ordering`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_content_rating`
--

CREATE TABLE IF NOT EXISTS `jos_content_rating` (
  `content_id` int(11) NOT NULL default '0',
  `rating_sum` int(11) unsigned NOT NULL default '0',
  `rating_count` int(11) unsigned NOT NULL default '0',
  `lastip` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`content_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `jos_content_rating`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_core_acl_aro`
--

CREATE TABLE IF NOT EXISTS `jos_core_acl_aro` (
  `id` int(11) NOT NULL auto_increment,
  `section_value` varchar(240) NOT NULL default '0',
  `value` varchar(240) NOT NULL default '',
  `order_value` int(11) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `hidden` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `jos_section_value_value_aro` (`section_value`(100),`value`(100)),
  KEY `jos_gacl_hidden_aro` (`hidden`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Extraindo dados da tabela `jos_core_acl_aro`
--

INSERT INTO `jos_core_acl_aro` (`id`, `section_value`, `value`, `order_value`, `name`, `hidden`) VALUES
(10, 'users', '62', 0, 'Administrator', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_core_acl_aro_groups`
--

CREATE TABLE IF NOT EXISTS `jos_core_acl_aro_groups` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `lft` int(11) NOT NULL default '0',
  `rgt` int(11) NOT NULL default '0',
  `value` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `jos_gacl_parent_id_aro_groups` (`parent_id`),
  KEY `jos_gacl_lft_rgt_aro_groups` (`lft`,`rgt`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

--
-- Extraindo dados da tabela `jos_core_acl_aro_groups`
--

INSERT INTO `jos_core_acl_aro_groups` (`id`, `parent_id`, `name`, `lft`, `rgt`, `value`) VALUES
(17, 0, 'ROOT', 1, 22, 'ROOT'),
(28, 17, 'USERS', 2, 21, 'USERS'),
(29, 28, 'Public Frontend', 3, 12, 'Public Frontend'),
(18, 29, 'Registered', 4, 11, 'Registered'),
(19, 18, 'Author', 5, 10, 'Author'),
(20, 19, 'Editor', 6, 9, 'Editor'),
(21, 20, 'Publisher', 7, 8, 'Publisher'),
(30, 28, 'Public Backend', 13, 20, 'Public Backend'),
(23, 30, 'Manager', 14, 19, 'Manager'),
(24, 23, 'Administrator', 15, 18, 'Administrator'),
(25, 24, 'Super Administrator', 16, 17, 'Super Administrator');

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_core_acl_aro_map`
--

CREATE TABLE IF NOT EXISTS `jos_core_acl_aro_map` (
  `acl_id` int(11) NOT NULL default '0',
  `section_value` varchar(230) NOT NULL default '0',
  `value` varchar(100) NOT NULL,
  PRIMARY KEY  (`acl_id`,`section_value`,`value`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `jos_core_acl_aro_map`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_core_acl_aro_sections`
--

CREATE TABLE IF NOT EXISTS `jos_core_acl_aro_sections` (
  `id` int(11) NOT NULL auto_increment,
  `value` varchar(230) NOT NULL default '',
  `order_value` int(11) NOT NULL default '0',
  `name` varchar(230) NOT NULL default '',
  `hidden` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `jos_gacl_value_aro_sections` (`value`),
  KEY `jos_gacl_hidden_aro_sections` (`hidden`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Extraindo dados da tabela `jos_core_acl_aro_sections`
--

INSERT INTO `jos_core_acl_aro_sections` (`id`, `value`, `order_value`, `name`, `hidden`) VALUES
(10, 'users', 1, 'Users', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_core_acl_groups_aro_map`
--

CREATE TABLE IF NOT EXISTS `jos_core_acl_groups_aro_map` (
  `group_id` int(11) NOT NULL default '0',
  `section_value` varchar(240) NOT NULL default '',
  `aro_id` int(11) NOT NULL default '0',
  UNIQUE KEY `group_id_aro_id_groups_aro_map` (`group_id`,`section_value`,`aro_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `jos_core_acl_groups_aro_map`
--

INSERT INTO `jos_core_acl_groups_aro_map` (`group_id`, `section_value`, `aro_id`) VALUES
(25, '', 10);

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_core_log_items`
--

CREATE TABLE IF NOT EXISTS `jos_core_log_items` (
  `time_stamp` date NOT NULL default '0000-00-00',
  `item_table` varchar(50) NOT NULL default '',
  `item_id` int(11) unsigned NOT NULL default '0',
  `hits` int(11) unsigned NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `jos_core_log_items`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_core_log_searches`
--

CREATE TABLE IF NOT EXISTS `jos_core_log_searches` (
  `search_term` varchar(128) NOT NULL default '',
  `hits` int(11) unsigned NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `jos_core_log_searches`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_groups`
--

CREATE TABLE IF NOT EXISTS `jos_groups` (
  `id` tinyint(3) unsigned NOT NULL default '0',
  `name` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `jos_groups`
--

INSERT INTO `jos_groups` (`id`, `name`) VALUES
(0, 'Public'),
(1, 'Registered'),
(2, 'Special');

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_menu`
--

CREATE TABLE IF NOT EXISTS `jos_menu` (
  `id` int(11) NOT NULL auto_increment,
  `menutype` varchar(75) default NULL,
  `name` varchar(255) default NULL,
  `alias` varchar(255) NOT NULL default '',
  `link` text,
  `type` varchar(50) NOT NULL default '',
  `published` tinyint(1) NOT NULL default '0',
  `parent` int(11) unsigned NOT NULL default '0',
  `componentid` int(11) unsigned NOT NULL default '0',
  `sublevel` int(11) default '0',
  `ordering` int(11) default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `pollid` int(11) NOT NULL default '0',
  `browserNav` tinyint(4) default '0',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `utaccess` tinyint(3) unsigned NOT NULL default '0',
  `params` text NOT NULL,
  `lft` int(11) unsigned NOT NULL default '0',
  `rgt` int(11) unsigned NOT NULL default '0',
  `home` int(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `componentid` (`componentid`,`menutype`,`published`,`access`),
  KEY `menutype` (`menutype`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Extraindo dados da tabela `jos_menu`
--

INSERT INTO `jos_menu` (`id`, `menutype`, `name`, `alias`, `link`, `type`, `published`, `parent`, `componentid`, `sublevel`, `ordering`, `checked_out`, `checked_out_time`, `pollid`, `browserNav`, `access`, `utaccess`, `params`, `lft`, `rgt`, `home`) VALUES
(1, 'mainmenu', 'Capa', 'capa', 'index.php?option=com_content&view=frontpage', 'component', 1, 0, 20, 0, 1, 0, '0000-00-00 00:00:00', 0, 0, 0, 3, 'num_leading_articles=1\nnum_intro_articles=4\nnum_columns=2\nnum_links=4\norderby_pri=\norderby_sec=front\nmulti_column_order=1\nshow_pagination=2\nshow_pagination_results=1\nshow_feed_link=1\nshow_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 1),
(2, 'mainmenu', 'Quem Somos', 'quem-somos', 'http://www.google.com', 'url', 1, 0, 0, 0, 2, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'menu_image=-1\n\n', 0, 0, 0),
(3, 'mainmenu', 'Opção 1', 'opcao-1', 'http://www.google.com', 'url', 1, 2, 0, 1, 1, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'menu_image=-1\n\n', 0, 0, 0),
(4, 'mainmenu', 'Opção 2', 'opcao-2', '', 'url', 1, 2, 0, 1, 2, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'menu_image=-1\n\n', 0, 0, 0),
(5, 'mainmenu', 'Unidades', 'unidades', 'http://www.google.com', 'url', 1, 0, 0, 0, 3, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'menu_image=-1\n\n', 0, 0, 0),
(6, 'mainmenu', 'Fotos Eventos', 'fotos-eventos', 'http://www.google.com', 'url', 1, 0, 0, 0, 4, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'menu_image=-1\n\n', 0, 0, 0),
(7, 'mainmenu', 'Palavra da Liderança', 'palavra-da-lideranca', 'http://www.google.com', 'url', 1, 0, 0, 0, 5, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'menu_image=-1\n\n', 0, 0, 0),
(8, 'mainmenu', 'Contato', 'contato', '', 'url', 1, 0, 0, 0, 6, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'menu_image=-1\n\n', 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_menu_types`
--

CREATE TABLE IF NOT EXISTS `jos_menu_types` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `menutype` varchar(75) NOT NULL default '',
  `title` varchar(255) NOT NULL default '',
  `description` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `menutype` (`menutype`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `jos_menu_types`
--

INSERT INTO `jos_menu_types` (`id`, `menutype`, `title`, `description`) VALUES
(1, 'mainmenu', 'Main Menu', 'The main menu for the site');

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_messages`
--

CREATE TABLE IF NOT EXISTS `jos_messages` (
  `message_id` int(10) unsigned NOT NULL auto_increment,
  `user_id_from` int(10) unsigned NOT NULL default '0',
  `user_id_to` int(10) unsigned NOT NULL default '0',
  `folder_id` int(10) unsigned NOT NULL default '0',
  `date_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `state` int(11) NOT NULL default '0',
  `priority` int(1) unsigned NOT NULL default '0',
  `subject` text NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY  (`message_id`),
  KEY `useridto_state` (`user_id_to`,`state`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `jos_messages`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_messages_cfg`
--

CREATE TABLE IF NOT EXISTS `jos_messages_cfg` (
  `user_id` int(10) unsigned NOT NULL default '0',
  `cfg_name` varchar(100) NOT NULL default '',
  `cfg_value` varchar(255) NOT NULL default '',
  UNIQUE KEY `idx_user_var_name` (`user_id`,`cfg_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `jos_messages_cfg`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_migration_backlinks`
--

CREATE TABLE IF NOT EXISTS `jos_migration_backlinks` (
  `itemid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `url` text NOT NULL,
  `sefurl` text NOT NULL,
  `newurl` text NOT NULL,
  PRIMARY KEY  (`itemid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `jos_migration_backlinks`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_modules`
--

CREATE TABLE IF NOT EXISTS `jos_modules` (
  `id` int(11) NOT NULL auto_increment,
  `title` text NOT NULL,
  `content` text NOT NULL,
  `ordering` int(11) NOT NULL default '0',
  `position` varchar(50) default NULL,
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `published` tinyint(1) NOT NULL default '0',
  `module` varchar(50) default NULL,
  `numnews` int(11) NOT NULL default '0',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `showtitle` tinyint(3) unsigned NOT NULL default '1',
  `params` text NOT NULL,
  `iscore` tinyint(4) NOT NULL default '0',
  `client_id` tinyint(4) NOT NULL default '0',
  `control` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `published` (`published`,`access`),
  KEY `newsfeeds` (`module`,`published`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Extraindo dados da tabela `jos_modules`
--

INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES
(1, 'Main Menu', '', 1, 'left', 0, '0000-00-00 00:00:00', 1, 'mod_mainmenu', 0, 0, 1, 'menutype=mainmenu\nmoduleclass_sfx=_menu\n', 1, 0, ''),
(2, 'Login', '', 1, 'login', 0, '0000-00-00 00:00:00', 1, 'mod_login', 0, 0, 1, '', 1, 1, ''),
(3, 'Popular', '', 3, 'cpanel', 0, '0000-00-00 00:00:00', 1, 'mod_popular', 0, 2, 1, '', 0, 1, ''),
(4, 'Recent added Articles', '', 4, 'cpanel', 0, '0000-00-00 00:00:00', 1, 'mod_latest', 0, 2, 1, 'ordering=c_dsc\nuser_id=0\ncache=0\n\n', 0, 1, ''),
(5, 'Menu Stats', '', 5, 'cpanel', 0, '0000-00-00 00:00:00', 1, 'mod_stats', 0, 2, 1, '', 0, 1, ''),
(6, 'Unread Messages', '', 1, 'header', 0, '0000-00-00 00:00:00', 1, 'mod_unread', 0, 2, 1, '', 1, 1, ''),
(7, 'Online Users', '', 2, 'header', 0, '0000-00-00 00:00:00', 1, 'mod_online', 0, 2, 1, '', 1, 1, ''),
(8, 'Toolbar', '', 1, 'toolbar', 0, '0000-00-00 00:00:00', 1, 'mod_toolbar', 0, 2, 1, '', 1, 1, ''),
(9, 'Quick Icons', '', 1, 'icon', 0, '0000-00-00 00:00:00', 1, 'mod_quickicon', 0, 2, 1, '', 1, 1, ''),
(10, 'Logged in Users', '', 2, 'cpanel', 0, '0000-00-00 00:00:00', 1, 'mod_logged', 0, 2, 1, '', 0, 1, ''),
(11, 'Footer', '', 0, 'footer', 0, '0000-00-00 00:00:00', 1, 'mod_footer', 0, 0, 1, '', 1, 1, ''),
(12, 'Admin Menu', '', 1, 'menu', 0, '0000-00-00 00:00:00', 1, 'mod_menu', 0, 2, 1, '', 0, 1, ''),
(13, 'Admin SubMenu', '', 1, 'submenu', 0, '0000-00-00 00:00:00', 1, 'mod_submenu', 0, 2, 1, '', 0, 1, ''),
(14, 'User Status', '', 1, 'status', 0, '0000-00-00 00:00:00', 1, 'mod_status', 0, 2, 1, '', 0, 1, ''),
(15, 'Title', '', 1, 'title', 0, '0000-00-00 00:00:00', 1, 'mod_title', 0, 2, 1, '', 0, 1, ''),
(16, 'RokNavMenu', '', 2, 'left', 0, '0000-00-00 00:00:00', 0, 'mod_roknavmenu', 0, 0, 1, 'custom_layout=default.php\ncustom_formatter=default.php\n', 0, 0, '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_modules_menu`
--

CREATE TABLE IF NOT EXISTS `jos_modules_menu` (
  `moduleid` int(11) NOT NULL default '0',
  `menuid` int(11) NOT NULL default '0',
  PRIMARY KEY  (`moduleid`,`menuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `jos_modules_menu`
--

INSERT INTO `jos_modules_menu` (`moduleid`, `menuid`) VALUES
(1, 0),
(16, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_newsfeeds`
--

CREATE TABLE IF NOT EXISTS `jos_newsfeeds` (
  `catid` int(11) NOT NULL default '0',
  `id` int(11) NOT NULL auto_increment,
  `name` text NOT NULL,
  `alias` varchar(255) NOT NULL default '',
  `link` text NOT NULL,
  `filename` varchar(200) default NULL,
  `published` tinyint(1) NOT NULL default '0',
  `numarticles` int(11) unsigned NOT NULL default '1',
  `cache_time` int(11) unsigned NOT NULL default '3600',
  `checked_out` tinyint(3) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL default '0',
  `rtl` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `published` (`published`),
  KEY `catid` (`catid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `jos_newsfeeds`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_plugins`
--

CREATE TABLE IF NOT EXISTS `jos_plugins` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL default '',
  `element` varchar(100) NOT NULL default '',
  `folder` varchar(100) NOT NULL default '',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `ordering` int(11) NOT NULL default '0',
  `published` tinyint(3) NOT NULL default '0',
  `iscore` tinyint(3) NOT NULL default '0',
  `client_id` tinyint(3) NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `params` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `idx_folder` (`published`,`client_id`,`access`,`folder`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;

--
-- Extraindo dados da tabela `jos_plugins`
--

INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES
(1, 'Authentication - Joomla', 'joomla', 'authentication', 0, 1, 1, 1, 0, 0, '0000-00-00 00:00:00', ''),
(2, 'Authentication - LDAP', 'ldap', 'authentication', 0, 2, 0, 1, 0, 0, '0000-00-00 00:00:00', 'host=\nport=389\nuse_ldapV3=0\nnegotiate_tls=0\nno_referrals=0\nauth_method=bind\nbase_dn=\nsearch_string=\nusers_dn=\nusername=\npassword=\nldap_fullname=fullName\nldap_email=mail\nldap_uid=uid\n\n'),
(3, 'Authentication - GMail', 'gmail', 'authentication', 0, 4, 0, 0, 0, 0, '0000-00-00 00:00:00', ''),
(4, 'Authentication - OpenID', 'openid', 'authentication', 0, 3, 0, 0, 0, 0, '0000-00-00 00:00:00', ''),
(5, 'User - Joomla!', 'joomla', 'user', 0, 0, 1, 0, 0, 0, '0000-00-00 00:00:00', 'autoregister=1\n\n'),
(6, 'Search - Content', 'content', 'search', 0, 1, 1, 1, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\nsearch_content=1\nsearch_uncategorised=1\nsearch_archived=1\n\n'),
(7, 'Search - Contacts', 'contacts', 'search', 0, 3, 1, 1, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\n\n'),
(8, 'Search - Categories', 'categories', 'search', 0, 4, 1, 0, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\n\n'),
(9, 'Search - Sections', 'sections', 'search', 0, 5, 1, 0, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\n\n'),
(10, 'Search - Newsfeeds', 'newsfeeds', 'search', 0, 6, 1, 0, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\n\n'),
(11, 'Search - Weblinks', 'weblinks', 'search', 0, 2, 1, 1, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\n\n'),
(12, 'Content - Pagebreak', 'pagebreak', 'content', 0, 10000, 1, 1, 0, 0, '0000-00-00 00:00:00', 'enabled=1\ntitle=1\nmultipage_toc=1\nshowall=1\n\n'),
(13, 'Content - Rating', 'vote', 'content', 0, 4, 1, 1, 0, 0, '0000-00-00 00:00:00', ''),
(14, 'Content - Email Cloaking', 'emailcloak', 'content', 0, 5, 1, 0, 0, 0, '0000-00-00 00:00:00', 'mode=1\n\n'),
(15, 'Content - Code Hightlighter (GeSHi)', 'geshi', 'content', 0, 5, 0, 0, 0, 0, '0000-00-00 00:00:00', ''),
(16, 'Content - Load Module', 'loadmodule', 'content', 0, 6, 1, 0, 0, 0, '0000-00-00 00:00:00', 'enabled=1\nstyle=0\n\n'),
(17, 'Content - Page Navigation', 'pagenavigation', 'content', 0, 2, 1, 1, 0, 0, '0000-00-00 00:00:00', 'position=1\n\n'),
(18, 'Editor - No Editor', 'none', 'editors', 0, 0, 1, 1, 0, 0, '0000-00-00 00:00:00', ''),
(19, 'Editor - TinyMCE', 'tinymce', 'editors', 0, 0, 1, 1, 0, 0, '0000-00-00 00:00:00', 'theme=advanced\ncleanup=1\ncleanup_startup=0\nautosave=0\ncompressed=0\nrelative_urls=1\ntext_direction=ltr\nlang_mode=0\nlang_code=en\ninvalid_elements=applet\ncontent_css=1\ncontent_css_custom=\nnewlines=0\ntoolbar=top\nhr=1\nsmilies=1\ntable=1\nstyle=1\nlayer=1\nxhtmlxtras=0\ntemplate=0\ndirectionality=1\nfullscreen=1\nhtml_height=550\nhtml_width=750\npreview=1\ninsertdate=1\nformat_date=%Y-%m-%d\ninserttime=1\nformat_time=%H:%M:%S\n\n'),
(20, 'Editor - XStandard Lite 2.0', 'xstandard', 'editors', 0, 0, 0, 1, 0, 0, '0000-00-00 00:00:00', ''),
(21, 'Editor Button - Image', 'image', 'editors-xtd', 0, 0, 1, 0, 0, 0, '0000-00-00 00:00:00', ''),
(22, 'Editor Button - Pagebreak', 'pagebreak', 'editors-xtd', 0, 0, 1, 0, 0, 0, '0000-00-00 00:00:00', ''),
(23, 'Editor Button - Readmore', 'readmore', 'editors-xtd', 0, 0, 1, 0, 0, 0, '0000-00-00 00:00:00', ''),
(24, 'XML-RPC - Joomla', 'joomla', 'xmlrpc', 0, 7, 0, 1, 0, 0, '0000-00-00 00:00:00', ''),
(25, 'XML-RPC - Blogger API', 'blogger', 'xmlrpc', 0, 7, 0, 1, 0, 0, '0000-00-00 00:00:00', 'catid=1\nsectionid=0\n\n'),
(27, 'System - SEF', 'sef', 'system', 0, 1, 1, 0, 0, 0, '0000-00-00 00:00:00', ''),
(28, 'System - Debug', 'debug', 'system', 0, 2, 1, 0, 0, 0, '0000-00-00 00:00:00', 'queries=1\nmemory=1\nlangauge=1\n\n'),
(29, 'System - Legacy', 'legacy', 'system', 0, 3, 0, 1, 0, 0, '0000-00-00 00:00:00', 'route=0\n\n'),
(30, 'System - Cache', 'cache', 'system', 0, 4, 0, 1, 0, 0, '0000-00-00 00:00:00', 'browsercache=0\ncachetime=15\n\n'),
(31, 'System - Log', 'log', 'system', 0, 5, 0, 1, 0, 0, '0000-00-00 00:00:00', ''),
(32, 'System - Remember Me', 'remember', 'system', 0, 6, 1, 1, 0, 0, '0000-00-00 00:00:00', ''),
(33, 'System - Backlink', 'backlink', 'system', 0, 7, 0, 1, 0, 0, '0000-00-00 00:00:00', '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_polls`
--

CREATE TABLE IF NOT EXISTS `jos_polls` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `voters` int(9) NOT NULL default '0',
  `checked_out` int(11) NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `published` tinyint(1) NOT NULL default '0',
  `access` int(11) NOT NULL default '0',
  `lag` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `jos_polls`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_poll_data`
--

CREATE TABLE IF NOT EXISTS `jos_poll_data` (
  `id` int(11) NOT NULL auto_increment,
  `pollid` int(11) NOT NULL default '0',
  `text` text NOT NULL,
  `hits` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `pollid` (`pollid`,`text`(1))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `jos_poll_data`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_poll_date`
--

CREATE TABLE IF NOT EXISTS `jos_poll_date` (
  `id` bigint(20) NOT NULL auto_increment,
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `vote_id` int(11) NOT NULL default '0',
  `poll_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `poll_id` (`poll_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `jos_poll_date`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_poll_menu`
--

CREATE TABLE IF NOT EXISTS `jos_poll_menu` (
  `pollid` int(11) NOT NULL default '0',
  `menuid` int(11) NOT NULL default '0',
  PRIMARY KEY  (`pollid`,`menuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `jos_poll_menu`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_sections`
--

CREATE TABLE IF NOT EXISTS `jos_sections` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `name` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `image` text NOT NULL,
  `scope` varchar(50) NOT NULL default '',
  `image_position` varchar(30) NOT NULL default '',
  `description` text NOT NULL,
  `published` tinyint(1) NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL default '0',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `count` int(11) NOT NULL default '0',
  `params` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `idx_scope` (`scope`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `jos_sections`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_session`
--

CREATE TABLE IF NOT EXISTS `jos_session` (
  `username` varchar(150) default '',
  `time` varchar(14) default '',
  `session_id` varchar(200) NOT NULL default '0',
  `guest` tinyint(4) default '1',
  `userid` int(11) default '0',
  `usertype` varchar(50) default '',
  `gid` tinyint(3) unsigned NOT NULL default '0',
  `client_id` tinyint(3) unsigned NOT NULL default '0',
  `data` longtext,
  PRIMARY KEY  (`session_id`(64)),
  KEY `whosonline` (`guest`,`usertype`),
  KEY `userid` (`userid`),
  KEY `time` (`time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `jos_session`
--

INSERT INTO `jos_session` (`username`, `time`, `session_id`, `guest`, `userid`, `usertype`, `gid`, `client_id`, `data`) VALUES
('', '1253627029', '3439f9cc17ae18e8f5438ca632a98175', 1, 0, '', 0, 0, '__default|a:7:{s:22:"session.client.browser";s:116:"Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.21 Safari/532.0";s:15:"session.counter";i:126;s:8:"registry";O:9:"JRegistry":3:{s:17:"_defaultNameSpace";s:7:"session";s:9:"_registry";a:1:{s:7:"session";a:1:{s:4:"data";O:8:"stdClass":0:{}}}s:7:"_errors";a:0:{}}s:4:"user";O:5:"JUser":19:{s:2:"id";i:0;s:4:"name";N;s:8:"username";N;s:5:"email";N;s:8:"password";N;s:14:"password_clear";s:0:"";s:8:"usertype";N;s:5:"block";N;s:9:"sendEmail";i:0;s:3:"gid";i:0;s:12:"registerDate";N;s:13:"lastvisitDate";N;s:10:"activation";N;s:6:"params";N;s:3:"aid";i:0;s:5:"guest";i:1;s:7:"_params";O:10:"JParameter":7:{s:4:"_raw";s:0:"";s:4:"_xml";N;s:9:"_elements";a:0:{}s:12:"_elementPath";a:1:{i:0;s:71:"C:\\ServidorWEB\\www\\Adhonep Novo\\libraries\\joomla\\html\\parameter\\element";}s:17:"_defaultNameSpace";s:8:"_default";s:9:"_registry";a:1:{s:8:"_default";a:1:{s:4:"data";O:8:"stdClass":0:{}}}s:7:"_errors";a:0:{}}s:9:"_errorMsg";N;s:7:"_errors";a:0:{}}s:19:"session.timer.start";i:1253616969;s:18:"session.timer.last";i:1253626811;s:17:"session.timer.now";i:1253627029;}'),
('admin', '1253626665', '6a9f7913fc9b5ae89f7180394d9e4f3a', 0, 62, 'Super Administrator', 25, 1, '__default|a:8:{s:15:"session.counter";i:75;s:19:"session.timer.start";i:1253617504;s:18:"session.timer.last";i:1253626665;s:17:"session.timer.now";i:1253626665;s:22:"session.client.browser";s:116:"Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.21 Safari/532.0";s:8:"registry";O:9:"JRegistry":3:{s:17:"_defaultNameSpace";s:7:"session";s:9:"_registry";a:5:{s:7:"session";a:1:{s:4:"data";O:8:"stdClass":0:{}}s:11:"application";a:1:{s:4:"data";O:8:"stdClass":1:{s:4:"lang";s:0:"";}}s:9:"com_menus";a:1:{s:4:"data";O:8:"stdClass":1:{s:8:"menutype";s:8:"mainmenu";}}s:6:"global";a:1:{s:4:"data";O:8:"stdClass":1:{s:4:"list";O:8:"stdClass":1:{s:5:"limit";s:2:"20";}}}s:13:"com_languages";a:1:{s:4:"data";O:8:"stdClass":1:{s:10:"limitstart";i:0;}}}s:7:"_errors";a:0:{}}s:4:"user";O:5:"JUser":19:{s:2:"id";s:2:"62";s:4:"name";s:13:"Administrator";s:8:"username";s:5:"admin";s:5:"email";s:24:"leonardo@devhouse.com.br";s:8:"password";s:65:"67a072816057d6149e207f618c99cbcb:LRS5lmNXhWPNvpSlrmHLnDMHsPUrLWvU";s:14:"password_clear";s:0:"";s:8:"usertype";s:19:"Super Administrator";s:5:"block";s:1:"0";s:9:"sendEmail";s:1:"1";s:3:"gid";s:2:"25";s:12:"registerDate";s:19:"2009-09-21 22:29:09";s:13:"lastvisitDate";s:19:"2009-09-22 02:15:58";s:10:"activation";s:0:"";s:6:"params";s:0:"";s:3:"aid";i:2;s:5:"guest";i:0;s:7:"_params";O:10:"JParameter":7:{s:4:"_raw";s:0:"";s:4:"_xml";N;s:9:"_elements";a:0:{}s:12:"_elementPath";a:1:{i:0;s:71:"C:\\ServidorWEB\\www\\Adhonep Novo\\libraries\\joomla\\html\\parameter\\element";}s:17:"_defaultNameSpace";s:8:"_default";s:9:"_registry";a:1:{s:8:"_default";a:1:{s:4:"data";O:8:"stdClass":0:{}}}s:7:"_errors";a:0:{}}s:9:"_errorMsg";N;s:7:"_errors";a:0:{}}s:13:"session.token";s:32:"d2e0d020a041aa4cc0a65203cdbbdee5";}');

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_stats_agents`
--

CREATE TABLE IF NOT EXISTS `jos_stats_agents` (
  `agent` varchar(255) NOT NULL default '',
  `type` tinyint(1) unsigned NOT NULL default '0',
  `hits` int(11) unsigned NOT NULL default '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `jos_stats_agents`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_templates_menu`
--

CREATE TABLE IF NOT EXISTS `jos_templates_menu` (
  `template` varchar(255) NOT NULL default '',
  `menuid` int(11) NOT NULL default '0',
  `client_id` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`menuid`,`client_id`,`template`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `jos_templates_menu`
--

INSERT INTO `jos_templates_menu` (`template`, `menuid`, `client_id`) VALUES
('rt_affinity_j15', 0, 0),
('khepri', 0, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_users`
--

CREATE TABLE IF NOT EXISTS `jos_users` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `username` varchar(150) NOT NULL default '',
  `email` varchar(100) NOT NULL default '',
  `password` varchar(100) NOT NULL default '',
  `usertype` varchar(25) NOT NULL default '',
  `block` tinyint(4) NOT NULL default '0',
  `sendEmail` tinyint(4) default '0',
  `gid` tinyint(3) unsigned NOT NULL default '1',
  `registerDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `lastvisitDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `activation` varchar(100) NOT NULL default '',
  `params` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `usertype` (`usertype`),
  KEY `idx_name` (`name`),
  KEY `gid_block` (`gid`,`block`),
  KEY `username` (`username`),
  KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=63 ;

--
-- Extraindo dados da tabela `jos_users`
--

INSERT INTO `jos_users` (`id`, `name`, `username`, `email`, `password`, `usertype`, `block`, `sendEmail`, `gid`, `registerDate`, `lastvisitDate`, `activation`, `params`) VALUES
(62, 'Administrator', 'admin', 'leonardo@devhouse.com.br', '67a072816057d6149e207f618c99cbcb:LRS5lmNXhWPNvpSlrmHLnDMHsPUrLWvU', 'Super Administrator', 0, 1, 25, '2009-09-21 22:29:09', '2009-09-22 11:05:14', '', '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `jos_weblinks`
--

CREATE TABLE IF NOT EXISTS `jos_weblinks` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `catid` int(11) NOT NULL default '0',
  `sid` int(11) NOT NULL default '0',
  `title` varchar(250) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `url` varchar(250) NOT NULL default '',
  `description` text NOT NULL,
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `hits` int(11) NOT NULL default '0',
  `published` tinyint(1) NOT NULL default '0',
  `checked_out` int(11) NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL default '0',
  `archived` tinyint(1) NOT NULL default '0',
  `approved` tinyint(1) NOT NULL default '1',
  `params` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `catid` (`catid`,`published`,`archived`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `jos_weblinks`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `locais`
--

CREATE TABLE IF NOT EXISTS `locais` (
  `idlocais` int(10) unsigned NOT NULL auto_increment,
  `local` varchar(255) character set latin1 NOT NULL,
  `endereco` varchar(255) character set latin1 default NULL,
  `bairro` varchar(100) character set latin1 default NULL,
  `telefone` varchar(16) character set latin1 default NULL,
  `desc` text character set latin1,
  `idpessoas` int(10) unsigned NOT NULL,
  `idcidades` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`idlocais`),
  KEY `fk_locais_pessoas1` (`idpessoas`),
  KEY `fk_locais_cidades1` (`idcidades`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Extraindo dados da tabela `locais`
--

INSERT INTO `locais` (`idlocais`, `local`, `endereco`, `bairro`, `telefone`, `desc`, `idpessoas`, `idcidades`) VALUES
(1, 'Casa do Leonardo', 'Rua Orestes Guimarães, 225 - apto. 604', 'Centro', '4730266908', 'A minha casa<br>', 18, 1),
(2, 'Igreja Santos Anjos', 'Rua da igreja, 45', 'Marinha', '4734372322', 'Igreja revestida em ouro.', 4, 4),
(4, 'Igreja Bola de Neve', 'Rua Felipe Schimit', 'Centro', '4832236578', 'A igreja da mocidade.', 42, 5),
(5, 'Auditório Municipal', 'Rua Central, 123', 'Centro', '(47) 3026-6908', 'Auditório Espaçoso', 43, 6),
(6, 'fdsa', 'fdsafdsa', 'ffdsa', '(47) 3026-6908', '?fdsaffdsafdsaf dsaf dsa fdsa fd<br>', 15, 1),
(7, 'kjhgkjhg', 'kljyhkgkj', 'uirtyr', '54654', '?hgfd ryjh fmjnhdf nhdf<br>', 2, 1),
(8, 'tryreytre', 'gh dfsgfds ', ' gsdf gdsf ', '5432432', 'abacedkajfdlsa<br>', 13, 6),
(9, 'gfsgfds', 'fdsaf dsaf dsa fdsaf dsa', 'f dsa fdsa fds', '543', '&nbsp;fdsafdsaf dsa fdsa<br>', 42, 6),
(10, 'aaaaaaaaaaaaa', 'fdsafdsafdsa', 'fdsafdsafdsafds', '(47) 3026-6908', 'afdsafdsafdsafdsadsaf', 11, 1),
(11, 'dffdsa', 'fdsafdsa', 'fdsaf', '(30) 2669-0808', 'dsafdsafdsafdsa', 42, 7);

-- --------------------------------------------------------

--
-- Estrutura da tabela `permissoes`
--

CREATE TABLE IF NOT EXISTS `permissoes` (
  `idpermissoes` int(10) unsigned NOT NULL auto_increment,
  `permissao` varchar(255) character set latin1 default NULL,
  PRIMARY KEY  (`idpermissoes`),
  KEY `permissao` (`permissao`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Extraindo dados da tabela `permissoes`
--

INSERT INTO `permissoes` (`idpermissoes`, `permissao`) VALUES
(1, 'agenda'),
(2, 'cidades'),
(3, 'downloads'),
(4, 'locais'),
(5, 'pessoas'),
(6, 'usuarios'),
(7, 'usuários somente na sua cidade');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pessoas`
--

CREATE TABLE IF NOT EXISTS `pessoas` (
  `idpessoas` int(10) unsigned NOT NULL auto_increment,
  `nome` varchar(255) character set latin1 NOT NULL,
  `email` varchar(255) character set latin1 NOT NULL,
  `senha` varchar(50) character set latin1 default NULL,
  `telefone` varchar(16) character set latin1 default NULL,
  `celular` varchar(16) character set latin1 default NULL,
  `endereco` varchar(255) character set latin1 default NULL,
  `bairro` varchar(100) character set latin1 default NULL,
  `idcidades` int(10) unsigned NOT NULL,
  `desc` text character set latin1,
  `acesso` tinyint(1) NOT NULL,
  `permissoes` varchar(255) character set latin1 default NULL,
  PRIMARY KEY  (`idpessoas`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_pessoas_cidades1` (`idcidades`),
  KEY `nome` (`nome`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Pessoas e Usuários do sistema' AUTO_INCREMENT=63 ;

--
-- Extraindo dados da tabela `pessoas`
--

INSERT INTO `pessoas` (`idpessoas`, `nome`, `email`, `senha`, `telefone`, `celular`, `endereco`, `bairro`, `idcidades`, `desc`, `acesso`, `permissoes`) VALUES
(1, 'Leonardo Lima de Vasconcellos', 'leonardo@devhouse.com.br', '0bc5b422a348b5958aacba5f863dd57f40ced581', '4730266908', '4799442321', 'Rua Orestes Guimarães, 225', 'Centro', 5, 'Programador Web', 1, 'permisso'),
(2, 'Denise Alcântara Bezzera de Lima', 'denise_jlle@hotmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '30266908', '99610414', 'Rua Orestes Guimarães, 225', 'Centro', 1, 'Minha Mãe', 1, NULL),
(3, 'Rafael Lima de Vasconcellos', 'rafael.lima@totvs.com.br', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '33380232', '781613314', '', '', 1, '', 1, ''),
(4, 'Ismar M.', 'ismar@ldi.com.br', '27f63f5204217f3f80adffeeb92351aa5d9b2c25', '30303030', '99999999', 'Rua Dona Francisca, 5347', 'Bairro', 1, 'Descrição Ismar', 1, NULL),
(5, 'Luis', 'luiz.camargo@agenciadmg.com.br', '123456', '33333333', '99999999', 'Rua Sem Nome, sn', 'Centro', 1, 'Descrição', 1, NULL),
(6, 'Victor Castoldi Vasconcellos', 'victor.castoldi@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '30303', '9449459', 'Rua sem nome, sn', 'Bairro', 1, '', 0, 'Permissões'),
(7, 'João da Silva', 'joao@dasilva.com.br', '7c4a8d09ca3762af61e59520943dc26494f8941b', '4732184329', '3243242', 'Rua sem nome,sn', 'bairro', 1, '', 0, 'Permissões'),
(8, 'Nome', 'email@email.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '46454645', '456456465', 'Rua Sem Nome, sn', 'Bairro', 1, 'fdsafdsafdsa', 0, 'Permisso'),
(9, 'Janjão', 'janjao@email.com', '7751a23fa55170a57e90374df13a3ab78efe0e99', '78908', '989987987', 'rua tal, numero tal', 'Bairro', 1, '', 1, 'Permissões'),
(11, 'Davi Golias', 'fdsajl@fjdaaaaa.com', '7751a23fa55170a57e90374df13a3ab78efe0e99', '57328473', '987459387', 'fjdsaklfjd123', 'Bairro', 2, '', 1, 'Permisso'),
(12, 'Grand Master Flash', 'grand@masterflash.com', '1bdc12f0f29da10f6b637646821c0c56e8c48559', '0987097', '98798798', 'fdsaçl fdjskla flkdsaj flksd', 'fdjsaklfjdsl', 1, '', 1, 'Permissões'),
(13, 'Anacleto Brocolli', 'anacleto@brocoli.com', 'cd3f0c85b158c08a2b113464991810cf2cdfc387', '5432342', '98797897', 'fhdsak fhdsa fj', 'fd salkfjds al', 1, '<br>', 1, 'Permisso'),
(15, 'Edimilson Creison', 'edmilson@creison.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '5432542', '987987', 'fdsafdsafdsa, sn', 'fdsafdsa', 1, '', 1, 'Permisso'),
(16, 'Juliano Barbosa', 'juliano@barbosa.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '98798', '98798789', 'fdsafdsa', 'fdsafdsa', 1, '', 1, 'Permissões'),
(17, 'Julian Moore', 'julian@moore.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '456456', '654654', 'fjad slakfj dsaçlkfj dsalf jdslaj', 'Bairro', 1, '', 1, 'Permissões'),
(18, 'Amina Munsta', 'amina@munsta.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '09809808', '9674987', 'ds flakfj dlksafj dlksa fldksa jflkdsaj lfd jalkf dlksa djflka jfldaj flkdsa jflkd jsaklf jdaskl fjdklsa fjdlksafdsa fdsa fdsa fdsa fdsa fdas fdsa  fdsa fdsa fdsa fdsa fdsaf dsa fdsa fdsaf dsa fdsaf dsaf  dsaf dsa fdsa ', 'Bairro', 7, 'fdsafdsafdsafdsafds', 0, 'Permisso'),
(19, 'Anastacia Velasco', 'ana@velasco.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '777777777', '98798498489', 'fdsafdsa fdsa fdsa fdsa fdsa', 'f dsa fdsa fdas fdas dsa', 1, 'dsa <a href="http://www.google.com">fdsaf </a>dsa <b>fdsa </b>fdsa <span style="background-color: rgb(255, 255, 0);">fdsa </span>fdsa <a href="http://www.google.com">fdsa </a>fd <font color="#99cc00">asf </font>dasf dsa dsa d<br>', 1, 'Permisso'),
(20, 'Ludimila Kadinski', 'lulu@kaka.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '43214321', '43214322', 'fdsafdsafdsafdsa', 'fdsafdsafdsa', 1, 'fdsa <a href="http://www.google.com/">fdsaf </a>dsa <b>fdsa </b>fdsa <span style="background-color: rgb(255, 255, 0);">fdsa </span>fdsa fdsa fd <font color="#99cc00">asf </font>dasf dsa dsa d', 0, 'Permisso'),
(21, 'Ratazana', 'rat@azana.com.br', '7e240de74fb1ed08fa08d38063f6a6a91462a815', '432432432', '432432', 'fdsafdsafdsafdsafdsafdsa', 'fdsafdsa', 1, 'dsafdsaf<font color="#ff6600">dsafdsa</font>fdsa', 1, 'Permisso'),
(22, 'All the fear I have', 'fear@tdv.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '123456', '98797987', 'endereço 124', 'América', 6, '<img src="images/ajax-loader.gif" vspace="6" align="Esquerda" hspace="6"><br><br><b>All </b><font color="#ff6600">the </font><i>fear </i>I <font color="#ff0000">have </font>is <font color="#339966">only </font><a href="http://www.tdv.com">inside </a><span style="background-color: rgb(255, 102, 0);">my </span><font color="#00ffff">mind</font><br>', 1, 'Permisso'),
(27, 'fdsafdsafd', 'afdsa@fdjsla.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '54325432', '12312', 'gfdsgfdsg', 'gfdsgfds', 4, 'A descrição está escrita aqui.<br>', 1, 'Permisso'),
(29, 'fjdkslajf', 'leoj@fjdsl.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '789797', '1234456', 'vsadsafdsafdsaf', 'fdsafdsaf', 1, 'dsafdsafdsa', 1, 'Permisso'),
(31, 'fjdsakljfdls', 'fhdsalk@fvjdslka.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '1321321', '14564654', 'fdasfdsafdsaf', 'dsafdsafdsaf', 1, 'dsafdsafads', 1, 'Permisso'),
(33, 'Fausta', 'sadfds@fjdls.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '5465465', '654564', 'fdsafdsafdsa', 'fdsafdsafd', 1, 'ffff', 1, 'Permisso'),
(36, 'fdsafdsa', '123@jfdls.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '4321321', '1431243', 'fdsafdsafdsa', 'fdsafdsa', 2, 'fdsafdsaf', 1, 'Permisso'),
(40, 'fdsafdsafdsafdsa', 'fjds@dlfkdsa.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '4321431', '43214321', 'fdsafdsa', 'fdsafdsa', 4, 'fdsafdsa', 0, 'Permisso'),
(41, 'Joey Ramone', 'fddjsajfdj@jfjfjfjfjfjjffjjf.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '43432432', '432432', 'fdsafdsafdsa, 123', 'bairro', 1, 'dsafd safd asf dsa fdsa fdsa fdsa <br>', 1, 'Permisso'),
(42, 'Bruna Bitencourt', 'bruna@bit.com.br', '7c4a8d09ca3762af61e59520943dc26494f8941b', '4325432432', '432432432', 'fdsafdsafdsaf', 'fdsafdsa', 1, 'yterytreuytreytre', 1, 'Permisso'),
(43, 'HP Lovecraft', 'hp@lovecraft.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '564654', '456465465', 'fdsafdsafdsafdsafdsa123', 'fdsafdsafdsa', 1, 'aaaaaaaaaaaaaaaaa', 1, 'Permisso'),
(44, 'KKK', 'fdsafaaaaddddsa@fdsajlf.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '123132', '4564654', 'fdsafdsa', 'fdasfdsa', 1, '?fdsafdsa', 1, 'Permisso'),
(45, 'Camila Rodrigues', 'camila@rodrigues.com.br', '7c4a8d09ca3762af61e59520943dc26494f8941b', '4730335589', '4799748553', 'Rua João Colin, 2345', 'América', 1, '<img src="images/imagens/camila_rodrigues.jpg" align="left" hspace="6" vspace="6">?Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse facilisis ligula sed ligula luctus congue. Fusce venenatis, lorem vitae porttitor lobortis, ipsum nunc facilisis ipsum, ac feugiat orci purus id velit. Maecenas vel lorem non magna eleifend varius et vel dui. Maecenas ut quam velit, ut gravida dolor. Aenean at enim risus, non feugiat ipsum. Nunc bibendum convallis tellus, porttitor dignissim leo fringilla ac. Curabitur congue enim ut quam placerat in interdum massa vestibulum. Duis sollicitudin elit et magna molestie vitae gravida est consequat. Quisque placerat, ante sit amet posuere suscipit, nibh magna posuere libero, rutrum consectetur elit nulla vitae nisl. Sed interdum laoreet justo vestibulum malesuada. Donec mattis volutpat mattis.<div><br></div><div>Etiam vitae sollicitudin lorem. Ut rhoncus purus eu ipsum bibendum tempor. Vestibulum scelerisque laoreet luctus. Aenean vehicula porttitor enim, eu bibendum diam blandit et. Proin sem libero, dapibus sit amet suscipit non, commodo eget nisl. Vivamus vitae arcu nisl, euismod egestas neque. In sed iaculis nulla. Quisque porttitor erat et ligula rutrum mollis pretium mi scelerisque. Mauris ornare porttitor volutpat. Donec eget quam mauris, eu aliquet massa. In dictum auctor dolor, a aliquam arcu mattis sit amet. Morbi et augue non turpis blandit convallis. Praesent at augue sapien, eu gravida leo. Morbi fringilla rutrum cursus. Etiam vitae ante et odio adipiscing convallis eu at lectus. Aenean auctor tortor ut urna egestas a tincidunt nisi commodo. Sed sed diam at orci elementum adipiscing.</div><div><br></div><div>Proin ut felis ut nisl sodales porta. Donec in eros vel nisi aliquet egestas gravida aliquet massa. Suspendisse facilisis viverra purus, vitae malesuada tortor vestibulum nec. Suspendisse quis tincidunt leo. Aliquam cursus commodo neque non suscipit. In molestie sagittis risus, sed euismod arcu lobortis quis. Integer et velit et ante semper scelerisque sed at tellus. Phasellus ornare dictum odio, at feugiat turpis venenatis id. Cras sed felis nunc. Etiam magna leo, ullamcorper quis ultricies eu, ultrices ut nisl. In hac habitasse platea dictumst. Vivamus ultrices, orci et ultricies tincidunt, mauris magna egestas leo, eu molestie purus metus id nibh. Nulla id ultricies magna. Duis tincidunt, dui vestibulum sagittis tempus, lorem felis suscipit sapien, ut porttitor dui urna non nibh.</div><div><br></div><div>Integer a turpis lorem. Pellentesque ac ullamcorper neque. Sed in turpis a dolor imperdiet egestas. Integer porttitor pulvinar lacinia. Sed nibh turpis, fermentum a venenatis ac, aliquet eu nisi. Nam arcu lectus, dignissim vel scelerisque non, facilisis non arcu. Vestibulum quis nibh dui. Nunc non nunc sed odio tincidunt hendrerit sollicitudin sit amet sem. Nunc congue pulvinar hendrerit. Vestibulum ut felis sapien, quis tincidunt erat. Nullam interdum purus ut eros consequat dignissim. Duis vehicula vestibulum tortor, et porttitor odio elementum at. Praesent vel tortor non orci lacinia pellentesque ac vitae massa. Proin eget facilisis risus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum egestas, eros ac tincidunt pretium, leo dui pellentesque nisl, non hendrerit libero odio ac eros. Nam posuere, urna non cursus vulputate, eros eros luctus ligula, nec congue tortor orci at felis.</div><div><br></div><div>Aliquam nunc dolor, congue et commodo non, laoreet sit amet orci. Donec euismod lobortis dictum. Sed malesuada fringilla sem, a facilisis justo scelerisque et. Vivamus rutrum lectus et dui hendrerit facilisis. Vestibulum enim massa, fermentum et luctus sed, suscipit a felis. Sed aliquet volutpat pharetra. Aliquam rutrum, lectus at varius rutrum, ante leo sollicitudin magna, sit amet dapibus orci erat vel quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aenean id dignissim velit. Maecenas tristique nisi erat. Nunc dapibus aliquam nulla, at placerat leo auctor vel. Quisque feugiat urna quis libero facilisis volutpat.&nbsp;</div>', 1, 'Permisso'),
(46, 'Oswaldo Marques', 'oswaldo@marques.com.br', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(41) 2323-5465', '(41) 9955-2322', 'Rua sem nome,sn', 'Batel', 9, 'fdsafdsadsafsa', 1, 'Permisso'),
(47, 'fdsafdsa', 'fdsafd@fdsacc.net', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(63) 2563-2564', '(24) 3243-2432', 'fdsafdsafdsa', 'fdsafdsa', 9, 'fdsafdsafdsa', 1, 'Permisso'),
(48, 'qqqqqqqqq', 'qq@qaqq.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(63) 4523-5432', '(23) 3223-3421', 'afdsafdsafdsa', 'fdsafdsa', 2, 'fdsafdsafdsa', 1, 'Permisso'),
(49, 'aaaaaaaaaaa', 'gfdsgfs@ggghhhjjkkj.org', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(43) 2143-2143', '(43) 2432-1543', 'fdsafdsafdsa', 'fdsafdsa', 3, 'fdsafdsafdsafd', 1, 'Permisso'),
(50, 'bbbbbbbbb', 'bb@bb.net', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(43) 2432-1423', '(23) 4324-3242', 'fdsafdsafdsafdsafdsafdsa', 'fdsafdsafdsa', 4, 'fdsa fdsa fdsa fda f dsa fdsa fdsa<br>', 1, 'Permisso'),
(51, 'cccccccc', 'ccc@ccccc.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(43) 2143-1431', '(43) 2412-4321', 'fdsadsafdsafdsa', 'fdsafdsa', 6, 'hgagafgda sfdsa fdsa fdsa fdsa fdsa<br>', 1, 'Permisso'),
(52, 'ddddd', 'ddd@fdsa.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(43) 2143-2143', '(32) 1432-1432', 'fdsafdsafdsa', 'fdsafdsafdsa', 5, 'safdsafdsafdsafdsafdsa fdsa fdsa fdsa fdsa fdsa fdsa fdsa fdsa fdsa <br>', 1, 'Permisso'),
(53, 'Monica', 'm@monica.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(43) 2451-3243', '(31) 2432-1431', 'fdsa fdsa fdsaf dsa fdsa', ' fdsa fdsa fdsa', 2, 'f dsafdsa fdsa fdsa fdas fdsa fdsa <br>', 1, 'Permisso'),
(54, 'Robert Langdon', 'robert@langdon.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(45) 6456-4564', '(45) 6456-4654', 'fdsafdsafdsa', 'fdsafdsa', 7, 'f dsafd <font color="#ff0000">safdsa </font>fdsa <span style="background-color: rgb(153, 204, 0);">fdsa </span>fdsa <b>fdsaf </b>dsa<br>', 1, 'Permisso'),
(55, 'Altamiro Lima', 'altamiro@lima.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(45) 6464-5646', '(64) 6546-5446', 'fdsaf dsa dfsa fdsa fdsa', 'fdsafdsa', 7, '<b>fdsa </b>fdsa <font color="#ff0000">fdsaf </font>dsa fdsa <span style="background-color: rgb(255, 255, 0);">fdsa </span>fsa<br>', 1, 'Permisso'),
(56, 'Jhon Lenon', 'john@beatles.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(56) 4654-6465', '(46) 4654-6546', 'fdsafdsafdsa', 'fdsafdsafdsa', 4, 'fdsaf dsa fdsa fdsa fdsa<br>', 1, 'Permisso'),
(57, 'Ronaldinho', 'ronaldo@selecao.com.br', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(45) 4645-6465', '(56) 4646-5464', 'fdsafdsafdsa', 'fdsafdsa', 5, 'fdsafdsa fdsa fdsa fdsa fdsa fdsa fdsa<br>', 1, 'Permisso'),
(58, 'Abadia Coristalina', 'abadia@fjdks.com', '53b722fe6a32e35699af061920916a4b927f4a61', '(45) 6464-6546', '(65) 4465-4564', 'fdsafdsafda', 'fdsafdsaf', 9, '<img src="images/add.png" vspace="6" align="left" hspace="6">fd asfd safdas fdsah tequ hg hgs htda hdat<img src="images/imagens/camila_rodrigues.jpg" vspace="6" align="right" hspace="6">', 0, 'Permisso'),
(59, 'aaF', 'a@a.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(32) 1432-1431', '(43) 2143-2143', 'fdsafdsaf', 'fdasfdsa', 5, 'fdsa fdsa fdsa fdsa fdsaf dsaf dsaf dsa fdsa fds<br>', 1, 'Permisso'),
(60, 'aa', 'aa@fdsa.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(23) 4153-2143', '(65) 4654-5665', '1231d3saf1d3safdsa', 'fdafdsa', 9, 'fdsafdas fdsoaf ldkçsaj fdsaj fdsaj fçldsaj fçldasj flçkds jalkfj dslçaj <br>', 1, 'Permisso'),
(61, 'aaa', 'aaa@fdasfdsa.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(54) 3254-3254', '(52) 4325-4325', 'fdsafdsafdsafd', 'fdsafdsa', 2, 'fdsafdsafdsafdsa', 1, 'Permisso'),
(62, 'b', 'afdasf@fdasfs.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(54) 3254-3254', '(54) 3254-3254', 'afdsafdsa fdsa fdfdas ', 'fdasfdsafdsa', 2, '&nbsp;fdsaf dsaf dsaf dsa fdsa fdsa fdsa fdsa<br>', 1, 'Permisso');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pessoas_atributospessoais`
--

CREATE TABLE IF NOT EXISTS `pessoas_atributospessoais` (
  `idpessoas` int(10) unsigned NOT NULL,
  `idatributospessoais` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`idpessoas`,`idatributospessoais`),
  KEY `fk_pessoas_has_atributospessoais_pessoas1` (`idpessoas`),
  KEY `fk_pessoas_has_atributospessoais_atributospessoais1` (`idatributospessoais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `pessoas_atributospessoais`
--

INSERT INTO `pessoas_atributospessoais` (`idpessoas`, `idatributospessoais`) VALUES
(22, 3),
(49, 2),
(57, 1),
(57, 2),
(57, 3),
(57, 4),
(58, 3),
(60, 1),
(60, 2),
(60, 3),
(60, 4),
(60, 5),
(61, 1),
(61, 2),
(61, 3),
(61, 4),
(61, 5),
(62, 1),
(62, 2),
(62, 3),
(62, 4),
(62, 5);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pessoas_cidades`
--

CREATE TABLE IF NOT EXISTS `pessoas_cidades` (
  `pessoas_idpessoas` int(10) unsigned NOT NULL,
  `cidades_idcidades` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`pessoas_idpessoas`,`cidades_idcidades`),
  KEY `fk_pessoas_has_cidades_pessoas` (`pessoas_idpessoas`),
  KEY `fk_pessoas_has_cidades_cidades` (`cidades_idcidades`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `pessoas_cidades`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `pessoas_permissoes`
--

CREATE TABLE IF NOT EXISTS `pessoas_permissoes` (
  `idpessoas` int(10) unsigned NOT NULL,
  `idpermissoes` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`idpessoas`,`idpermissoes`),
  KEY `fk_pessoas_has_permissoes_pessoas1` (`idpessoas`),
  KEY `fk_pessoas_has_permissoes_permissoes1` (`idpermissoes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `pessoas_permissoes`
--

INSERT INTO `pessoas_permissoes` (`idpessoas`, `idpermissoes`) VALUES
(19, 1),
(22, 5),
(58, 1),
(58, 2),
(58, 3),
(58, 4),
(58, 5),
(58, 7);

--
-- Restrições para as tabelas dumpadas
--

--
-- Restrições para a tabela `cidades_atributospessoais_pessoas`
--
ALTER TABLE `cidades_atributospessoais_pessoas`
  ADD CONSTRAINT `fk_cidades_has_atributospessoais_cidades1` FOREIGN KEY (`idcidades`) REFERENCES `cidades` (`idcidades`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cidades_has_atributospessoais_atributospessoais1` FOREIGN KEY (`idatributospessoais`) REFERENCES `atributospessoais` (`idatributospessoais`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cidades_has_atributospessoais_pessoas1` FOREIGN KEY (`idpessoas`) REFERENCES `pessoas` (`idpessoas`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `downloads`
--
ALTER TABLE `downloads`
  ADD CONSTRAINT `fk_downloads_pessoas1` FOREIGN KEY (`uploader`) REFERENCES `pessoas` (`idpessoas`) ON UPDATE NO ACTION;

--
-- Restrições para a tabela `locais`
--
ALTER TABLE `locais`
  ADD CONSTRAINT `fk_locais_cidades1` FOREIGN KEY (`idcidades`) REFERENCES `cidades` (`idcidades`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_locais_pessoas1` FOREIGN KEY (`idpessoas`) REFERENCES `pessoas` (`idpessoas`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `pessoas`
--
ALTER TABLE `pessoas`
  ADD CONSTRAINT `fk_pessoas_cidades1` FOREIGN KEY (`idcidades`) REFERENCES `cidades` (`idcidades`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `pessoas_atributospessoais`
--
ALTER TABLE `pessoas_atributospessoais`
  ADD CONSTRAINT `fk_pessoas_has_atributospessoais_atributospessoais1` FOREIGN KEY (`idatributospessoais`) REFERENCES `atributospessoais` (`idatributospessoais`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pessoas_has_atributospessoais_pessoas1` FOREIGN KEY (`idpessoas`) REFERENCES `pessoas` (`idpessoas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para a tabela `pessoas_cidades`
--
ALTER TABLE `pessoas_cidades`
  ADD CONSTRAINT `fk_pessoas_has_cidades_cidades` FOREIGN KEY (`cidades_idcidades`) REFERENCES `cidades` (`idcidades`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pessoas_has_cidades_pessoas` FOREIGN KEY (`pessoas_idpessoas`) REFERENCES `pessoas` (`idpessoas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para a tabela `pessoas_permissoes`
--
ALTER TABLE `pessoas_permissoes`
  ADD CONSTRAINT `fk_pessoas_has_permissoes_permissoes1` FOREIGN KEY (`idpermissoes`) REFERENCES `permissoes` (`idpermissoes`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pessoas_has_permissoes_pessoas1` FOREIGN KEY (`idpessoas`) REFERENCES `pessoas` (`idpessoas`) ON DELETE CASCADE ON UPDATE CASCADE;
