-- phpMyAdmin SQL Dump
-- version 2.8.2.4
-- http://www.phpmyadmin.net
-- 
-- Servidor: localhost:3306
-- Tempo de Geração: Jul 03, 2010 as 09:33 PM
-- Versão do Servidor: 5.0.45
-- Versão do PHP: 5.2.3
-- 
-- Banco de Dados: `adhonep`
-- 

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `agenda`
-- 

CREATE TABLE `agenda` (
  `idagenda` int(10) unsigned NOT NULL auto_increment,
  `datahora` datetime NOT NULL,
  `novos` int(11) default NULL,
  `total` int(11) default NULL,
  `desc` text,
  `site` tinyint(1) NOT NULL default '1',
  `idlocais` int(10) unsigned NOT NULL,
  `statuslocal` enum('vermelho','amarelo','verde') default 'vermelho',
  `idpessoas` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`idagenda`),
  KEY `fk_agenda_locais1` (`idlocais`),
  KEY `fk_agenda_pessoas1` (`idpessoas`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- 
-- Extraindo dados da tabela `agenda`
-- 

INSERT INTO `agenda` (`idagenda`, `datahora`, `novos`, `total`, `desc`, `site`, `idlocais`, `statuslocal`, `idpessoas`) VALUES (1, '2009-10-16 20:00:00', 0, 0, '', 1, 1, 'vermelho', 1),
(2, '2009-11-28 20:00:00', 0, 0, '', 1, 1, 'verde', 1);

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `agenda_encarregados`
-- 

CREATE TABLE `agenda_encarregados` (
  `idagenda` int(10) unsigned NOT NULL,
  `idpessoas` int(10) unsigned NOT NULL,
  `tipo` tinyint(3) unsigned NOT NULL,
  `status` enum('vermelho','amarelo','verde') NOT NULL default 'vermelho',
  PRIMARY KEY  (`idagenda`,`idpessoas`,`tipo`),
  KEY `fk_agenda_encarregados_agenda1` (`idagenda`),
  KEY `fk_agenda_encarregados_pessoas1` (`idpessoas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Extraindo dados da tabela `agenda_encarregados`
-- 

INSERT INTO `agenda_encarregados` (`idagenda`, `idpessoas`, `tipo`, `status`) VALUES (1, 2, 1, 'amarelo'),
(1, 2, 2, 'vermelho'),
(1, 2, 3, 'verde'),
(1, 2, 4, 'verde'),
(2, 1, 2, 'vermelho'),
(2, 3, 3, 'amarelo'),
(2, 4, 1, 'amarelo'),
(2, 5, 4, 'vermelho');

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `ajustes`
-- 

CREATE TABLE `ajustes` (
  `nome` varchar(255) NOT NULL,
  `valor` varchar(255) default NULL,
  PRIMARY KEY  (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Extraindo dados da tabela `ajustes`
-- 

INSERT INTO `ajustes` (`nome`, `valor`) VALUES ('Onde Usar Idéias', 'Opção 1;Opção 2; Opção 3; Opção 4');

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `atributospessoais`
-- 

CREATE TABLE `atributospessoais` (
  `idatributospessoais` int(10) unsigned NOT NULL auto_increment,
  `atributo` varchar(255) NOT NULL,
  `aplicacao` tinyint(4) NOT NULL,
  PRIMARY KEY  (`idatributospessoais`),
  KEY `atributo` (`atributo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

-- 
-- Extraindo dados da tabela `atributospessoais`
-- 

INSERT INTO `atributospessoais` (`idatributospessoais`, `atributo`, `aplicacao`) VALUES (1, 'Preletor', 1),
(2, 'Músico', 1),
(3, 'Mestre Cerimônia', 1),
(4, 'Testem. cinco minutos', 1);

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `cidades`
-- 

CREATE TABLE `cidades` (
  `idcidades` int(10) unsigned NOT NULL auto_increment,
  `cidade` varchar(100) NOT NULL,
  `capitulo` varchar(50) default NULL,
  `imagem` varchar(255) default NULL,
  `desc` text,
  PRIMARY KEY  (`idcidades`),
  UNIQUE KEY `cidade` (`cidade`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Cidades do sistema' AUTO_INCREMENT=8 ;

-- 
-- Extraindo dados da tabela `cidades`
-- 

INSERT INTO `cidades` (`idcidades`, `cidade`, `capitulo`, `imagem`, `desc`) VALUES (1, 'Joinville', '017', 'joinville.jpg', 'Cidade de Joinville'),
(2, 'Itajaí', '', NULL, ''),
(3, 'Florianópolis', '', NULL, ''),
(4, 'Brusque', '', NULL, ''),
(5, 'São Paulo', '', NULL, ''),
(6, 'Florida', '3', NULL, 'fdasfd'),
(7, 'Flor de Liz', '3', NULL, 'fdsa');

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `cidades_atributospessoais_pessoas`
-- 

CREATE TABLE `cidades_atributospessoais_pessoas` (
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


-- --------------------------------------------------------

-- 
-- Estrutura da tabela `downloads`
-- 

CREATE TABLE `downloads` (
  `iddownloads` int(10) unsigned NOT NULL auto_increment,
  `arquivo` varchar(255) NOT NULL,
  `caminho` varchar(255) NOT NULL,
  `uploader` int(10) unsigned NOT NULL,
  `autor` varchar(255) default NULL,
  `qtddownloads` bigint(20) unsigned NOT NULL default '0',
  PRIMARY KEY  (`iddownloads`),
  KEY `fk_downloads_pessoas1` (`uploader`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- 
-- Extraindo dados da tabela `downloads`
-- 

INSERT INTO `downloads` (`iddownloads`, `arquivo`, `caminho`, `uploader`, `autor`, `qtddownloads`) VALUES (1, '0', '', 1, '0', 1);

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `ideias`
-- 

CREATE TABLE `ideias` (
  `idideias` int(10) unsigned NOT NULL auto_increment,
  `ideia` varchar(255) NOT NULL,
  `ondeusar` varchar(255) NOT NULL,
  `autor` varchar(255) default NULL,
  `desc` text,
  PRIMARY KEY  (`idideias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Extraindo dados da tabela `ideias`
-- 


-- --------------------------------------------------------

-- 
-- Estrutura da tabela `jos_banner`
-- 

CREATE TABLE `jos_banner` (
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

CREATE TABLE `jos_bannerclient` (
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

CREATE TABLE `jos_bannertrack` (
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

CREATE TABLE `jos_categories` (
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

CREATE TABLE `jos_components` (
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
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 AUTO_INCREMENT=36 ;

-- 
-- Extraindo dados da tabela `jos_components`
-- 

INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (1, 'Banners', '', 0, 0, '', 'Banner Management', 'com_banners', 0, 'js/ThemeOffice/component.png', 0, 'track_impressions=0\ntrack_clicks=0\ntag_prefix=\n\n', 1),
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
(33, 'Control Panel', '', 0, 0, '', 'Control Panel', 'com_cpanel', 0, '', 1, '', 1),
(34, 'adhonep', 'option=com_adhonep', 0, 0, 'option=com_adhonep', 'adhonep', 'com_adhonep', 0, 'js/ThemeOffice/component.png', 0, '', 1),
(35, 'adhonep', '', 0, 34, 'option=com_adhonep', 'adhonep', 'com_adhonep', 0, 'js/ThemeOffice/component.png', 0, '', 1);

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `jos_contact_details`
-- 

CREATE TABLE `jos_contact_details` (
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

CREATE TABLE `jos_content` (
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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- 
-- Extraindo dados da tabela `jos_content`
-- 

INSERT INTO `jos_content` (`id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`) VALUES (1, 'dfadsa', 'fdsafdsa', '', '<p><span style="color: #000000; font-family: ''Times New Roman''; font-size: medium; line-height: normal;"> </span></p>\r\n<div style="color: #333333; font-family: Tahoma, Helvetica, Arial, sans-serif; font-size: 76%; background-image: initial; background-repeat: initial; background-attachment: initial; -webkit-background-clip: initial; -webkit-background-origin: initial; background-color: #ffffff; line-height: 1.3em; background-position: initial initial; margin: 0px;">\r\n<p style="margin-top: 10px; margin-bottom: 15px;"><span style="color: #000000; font-family: ''Times New Roman''; font-size: medium; line-height: normal;"> </span></p>\r\n<div style="color: #333333; font-family: Tahoma, Helvetica, Arial, sans-serif; font-size: 76%; background-image: initial; background-repeat: initial; background-attachment: initial; -webkit-background-clip: initial; -webkit-background-origin: initial; background-color: #ffffff; line-height: 1.3em; background-position: initial initial; margin: 0px;">\r\n<p style="margin-top: 10px; margin-bottom: 15px;"> </p>\r\n<div style="color: #333333; font-family: Tahoma, Helvetica, Arial, sans-serif; font-size: 12px; background-image: initial; background-repeat: initial; background-attachment: initial; -webkit-background-clip: initial; -webkit-background-origin: initial; background-color: #ffffff; line-height: 1.3em; margin: 0px;">\r\n<p style="margin-top: 10px; margin-bottom: 15px;">fd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd salfd sajflkd alkfjd</p>\r\n</div>\r\n</div>\r\n<p> </p>\r\n</div>\r\n<p> </p>', '', 1, 0, 0, 0, '2009-09-22 02:41:41', 62, '', '2009-09-22 12:59:48', 62, 0, '0000-00-00 00:00:00', '2009-09-22 02:41:41', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 2, 0, 1, '', '', 0, 0, 'robots=\nauthor=');

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `jos_content_frontpage`
-- 

CREATE TABLE `jos_content_frontpage` (
  `content_id` int(11) NOT NULL default '0',
  `ordering` int(11) NOT NULL default '0',
  PRIMARY KEY  (`content_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Extraindo dados da tabela `jos_content_frontpage`
-- 

INSERT INTO `jos_content_frontpage` (`content_id`, `ordering`) VALUES (1, 1);

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `jos_content_rating`
-- 

CREATE TABLE `jos_content_rating` (
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

CREATE TABLE `jos_core_acl_aro` (
  `id` int(11) NOT NULL auto_increment,
  `section_value` varchar(240) NOT NULL default '0',
  `value` varchar(240) NOT NULL default '',
  `order_value` int(11) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `hidden` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `jos_section_value_value_aro` (`section_value`(100),`value`(100)),
  KEY `jos_gacl_hidden_aro` (`hidden`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

-- 
-- Extraindo dados da tabela `jos_core_acl_aro`
-- 

INSERT INTO `jos_core_acl_aro` (`id`, `section_value`, `value`, `order_value`, `name`, `hidden`) VALUES (10, 'users', '62', 0, 'Administrator', 0);

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `jos_core_acl_aro_groups`
-- 

CREATE TABLE `jos_core_acl_aro_groups` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `lft` int(11) NOT NULL default '0',
  `rgt` int(11) NOT NULL default '0',
  `value` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `jos_gacl_parent_id_aro_groups` (`parent_id`),
  KEY `jos_gacl_lft_rgt_aro_groups` (`lft`,`rgt`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

-- 
-- Extraindo dados da tabela `jos_core_acl_aro_groups`
-- 

INSERT INTO `jos_core_acl_aro_groups` (`id`, `parent_id`, `name`, `lft`, `rgt`, `value`) VALUES (17, 0, 'ROOT', 1, 22, 'ROOT'),
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

CREATE TABLE `jos_core_acl_aro_map` (
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

CREATE TABLE `jos_core_acl_aro_sections` (
  `id` int(11) NOT NULL auto_increment,
  `value` varchar(230) NOT NULL default '',
  `order_value` int(11) NOT NULL default '0',
  `name` varchar(230) NOT NULL default '',
  `hidden` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `jos_gacl_value_aro_sections` (`value`),
  KEY `jos_gacl_hidden_aro_sections` (`hidden`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

-- 
-- Extraindo dados da tabela `jos_core_acl_aro_sections`
-- 

INSERT INTO `jos_core_acl_aro_sections` (`id`, `value`, `order_value`, `name`, `hidden`) VALUES (10, 'users', 1, 'Users', 0);

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `jos_core_acl_groups_aro_map`
-- 

CREATE TABLE `jos_core_acl_groups_aro_map` (
  `group_id` int(11) NOT NULL default '0',
  `section_value` varchar(240) NOT NULL default '',
  `aro_id` int(11) NOT NULL default '0',
  UNIQUE KEY `group_id_aro_id_groups_aro_map` (`group_id`,`section_value`,`aro_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Extraindo dados da tabela `jos_core_acl_groups_aro_map`
-- 

INSERT INTO `jos_core_acl_groups_aro_map` (`group_id`, `section_value`, `aro_id`) VALUES (25, '', 10);

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `jos_core_log_items`
-- 

CREATE TABLE `jos_core_log_items` (
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

CREATE TABLE `jos_core_log_searches` (
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

CREATE TABLE `jos_groups` (
  `id` tinyint(3) unsigned NOT NULL default '0',
  `name` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Extraindo dados da tabela `jos_groups`
-- 

INSERT INTO `jos_groups` (`id`, `name`) VALUES (0, 'Public'),
(1, 'Registered'),
(2, 'Special');

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `jos_menu`
-- 

CREATE TABLE `jos_menu` (
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
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

-- 
-- Extraindo dados da tabela `jos_menu`
-- 

INSERT INTO `jos_menu` (`id`, `menutype`, `name`, `alias`, `link`, `type`, `published`, `parent`, `componentid`, `sublevel`, `ordering`, `checked_out`, `checked_out_time`, `pollid`, `browserNav`, `access`, `utaccess`, `params`, `lft`, `rgt`, `home`) VALUES (1, 'mainmenu', 'Capa', 'capa', 'index.php?option=com_content&view=frontpage', 'component', 1, 0, 20, 0, 1, 0, '0000-00-00 00:00:00', 0, 0, 0, 3, 'num_leading_articles=1\nnum_intro_articles=4\nnum_columns=2\nnum_links=4\norderby_pri=\norderby_sec=front\nmulti_column_order=1\nshow_pagination=2\nshow_pagination_results=1\nshow_feed_link=1\nshow_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 1),
(2, 'mainmenu', 'Quem Somos', 'quem-somos', 'http://www.google.com', 'url', 1, 0, 0, 0, 2, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'menu_image=-1\n\n', 0, 0, 0),
(3, 'mainmenu', 'Opção 1', 'opcao-1', 'http://www.google.com', 'url', 1, 2, 0, 1, 1, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'menu_image=-1\n\n', 0, 0, 0),
(4, 'mainmenu', 'Opção 2', 'opcao-2', '', 'url', 1, 2, 0, 1, 2, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'menu_image=-1\n\n', 0, 0, 0),
(5, 'mainmenu', 'Unidades', 'unidades', 'http://www.google.com', 'url', 1, 0, 0, 0, 3, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'menu_image=-1\n\n', 0, 0, 0),
(6, 'mainmenu', 'Fotos Eventos', 'fotos-eventos', 'http://www.google.com', 'url', 1, 0, 0, 0, 4, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'menu_image=-1\n\n', 0, 0, 0),
(7, 'mainmenu', 'Palavra da Liderança', 'palavra-da-lideranca', 'http://www.google.com', 'url', 1, 0, 0, 0, 5, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'menu_image=-1\n\n', 0, 0, 0),
(8, 'mainmenu', 'Contato', 'contato', '', 'url', 1, 0, 0, 0, 6, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'menu_image=-1\n\n', 0, 0, 0),
(9, 'mainmenu', 'Teste Adhonep', 'teste-adhonep', 'index.php?option=com_adhonep&view=adhonep', 'component', 1, 0, 34, 0, 7, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'page_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `jos_menu_types`
-- 

CREATE TABLE `jos_menu_types` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `menutype` varchar(75) NOT NULL default '',
  `title` varchar(255) NOT NULL default '',
  `description` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `menutype` (`menutype`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- 
-- Extraindo dados da tabela `jos_menu_types`
-- 

INSERT INTO `jos_menu_types` (`id`, `menutype`, `title`, `description`) VALUES (1, 'mainmenu', 'Main Menu', 'The main menu for the site');

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `jos_messages`
-- 

CREATE TABLE `jos_messages` (
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

CREATE TABLE `jos_messages_cfg` (
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

CREATE TABLE `jos_migration_backlinks` (
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

CREATE TABLE `jos_modules` (
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
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

-- 
-- Extraindo dados da tabela `jos_modules`
-- 

INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (1, 'Main Menu', '', 1, 'left', 0, '0000-00-00 00:00:00', 1, 'mod_mainmenu', 0, 0, 1, 'menutype=mainmenu\nmoduleclass_sfx=_menu\n', 1, 0, ''),
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

CREATE TABLE `jos_modules_menu` (
  `moduleid` int(11) NOT NULL default '0',
  `menuid` int(11) NOT NULL default '0',
  PRIMARY KEY  (`moduleid`,`menuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Extraindo dados da tabela `jos_modules_menu`
-- 

INSERT INTO `jos_modules_menu` (`moduleid`, `menuid`) VALUES (1, 0),
(16, 0);

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `jos_newsfeeds`
-- 

CREATE TABLE `jos_newsfeeds` (
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

CREATE TABLE `jos_plugins` (
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
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;

-- 
-- Extraindo dados da tabela `jos_plugins`
-- 

INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (1, 'Authentication - Joomla', 'joomla', 'authentication', 0, 1, 1, 1, 0, 0, '0000-00-00 00:00:00', ''),
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
-- Estrutura da tabela `jos_poll_data`
-- 

CREATE TABLE `jos_poll_data` (
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

CREATE TABLE `jos_poll_date` (
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

CREATE TABLE `jos_poll_menu` (
  `pollid` int(11) NOT NULL default '0',
  `menuid` int(11) NOT NULL default '0',
  PRIMARY KEY  (`pollid`,`menuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Extraindo dados da tabela `jos_poll_menu`
-- 


-- --------------------------------------------------------

-- 
-- Estrutura da tabela `jos_polls`
-- 

CREATE TABLE `jos_polls` (
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
-- Estrutura da tabela `jos_sections`
-- 

CREATE TABLE `jos_sections` (
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

CREATE TABLE `jos_session` (
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

INSERT INTO `jos_session` (`username`, `time`, `session_id`, `guest`, `userid`, `usertype`, `gid`, `client_id`, `data`) VALUES ('', '1275189756', 'aan21qs54ck6ii6418prrdu5f7', 1, 0, '', 0, 0, '__default|a:7:{s:15:"session.counter";i:1;s:19:"session.timer.start";i:1275189756;s:18:"session.timer.last";i:1275189756;s:17:"session.timer.now";i:1275189756;s:22:"session.client.browser";s:49:"msnbot/2.0b (+http://search.msn.com/msnbot.htm)._";s:8:"registry";O:9:"JRegistry":3:{s:17:"_defaultNameSpace";s:7:"session";s:9:"_registry";a:1:{s:7:"session";a:1:{s:4:"data";O:8:"stdClass":0:{}}}s:7:"_errors";a:0:{}}s:4:"user";O:5:"JUser":19:{s:2:"id";i:0;s:4:"name";N;s:8:"username";N;s:5:"email";N;s:8:"password";N;s:14:"password_clear";s:0:"";s:8:"usertype";N;s:5:"block";N;s:9:"sendEmail";i:0;s:3:"gid";i:0;s:12:"registerDate";N;s:13:"lastvisitDate";N;s:10:"activation";N;s:6:"params";N;s:3:"aid";i:0;s:5:"guest";i:1;s:7:"_params";O:10:"JParameter":7:{s:4:"_raw";s:0:"";s:4:"_xml";N;s:9:"_elements";a:0:{}s:12:"_elementPath";a:1:{i:0;s:108:"/var/www/vhosts/devhouse.com.br/subdomains/premiere/httpdocs/adhonep/libraries/joomla/html/parameter/element";}s:17:"_defaultNameSpace";s:8:"_default";s:9:"_registry";a:1:{s:8:"_default";a:1:{s:4:"data";O:8:"stdClass":0:{}}}s:7:"_errors";a:0:{}}s:9:"_errorMsg";N;s:7:"_errors";a:0:{}}}');

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `jos_stats_agents`
-- 

CREATE TABLE `jos_stats_agents` (
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

CREATE TABLE `jos_templates_menu` (
  `template` varchar(255) NOT NULL default '',
  `menuid` int(11) NOT NULL default '0',
  `client_id` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`menuid`,`client_id`,`template`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Extraindo dados da tabela `jos_templates_menu`
-- 

INSERT INTO `jos_templates_menu` (`template`, `menuid`, `client_id`) VALUES ('rt_affinity_j15', 0, 0),
('khepri', 0, 1);

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `jos_users`
-- 

CREATE TABLE `jos_users` (
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
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 AUTO_INCREMENT=63 ;

-- 
-- Extraindo dados da tabela `jos_users`
-- 

INSERT INTO `jos_users` (`id`, `name`, `username`, `email`, `password`, `usertype`, `block`, `sendEmail`, `gid`, `registerDate`, `lastvisitDate`, `activation`, `params`) VALUES (62, 'Administrator', 'admin', 'leonardo@devhouse.com.br', '67a072816057d6149e207f618c99cbcb:LRS5lmNXhWPNvpSlrmHLnDMHsPUrLWvU', 'Super Administrator', 0, 1, 25, '2009-09-21 22:29:09', '2009-10-08 22:50:15', '', '');

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `jos_weblinks`
-- 

CREATE TABLE `jos_weblinks` (
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

CREATE TABLE `locais` (
  `idlocais` int(10) unsigned NOT NULL auto_increment,
  `local` varchar(255) NOT NULL,
  `endereco` varchar(255) default NULL,
  `bairro` varchar(100) default NULL,
  `telefone` varchar(16) default NULL,
  `desc` text,
  `idpessoas` int(10) unsigned NOT NULL,
  `idcidades` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`idlocais`),
  KEY `fk_locais_pessoas1` (`idpessoas`),
  KEY `fk_locais_cidades1` (`idcidades`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- 
-- Extraindo dados da tabela `locais`
-- 

INSERT INTO `locais` (`idlocais`, `local`, `endereco`, `bairro`, `telefone`, `desc`, `idpessoas`, `idcidades`) VALUES (1, 'LDI', 'Rua Dona Francisca, 4215', 'Bom Retiro', '(47) 3026-6500', '', 2, 1),
(2, 'JIC - Joinville Iate Clube', 'Rua', 'Espinheiros', '', '<br>', 5, 1),
(3, 'Casa do Palha', 'comandante frederico stoll, 46', 'centro', '(47) 4646-5465', '', 1, 1);

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `permissoes`
-- 

CREATE TABLE `permissoes` (
  `idpermissoes` int(10) unsigned NOT NULL auto_increment,
  `permissao` varchar(255) default NULL,
  PRIMARY KEY  (`idpermissoes`),
  KEY `permissao` (`permissao`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

-- 
-- Extraindo dados da tabela `permissoes`
-- 

INSERT INTO `permissoes` (`idpermissoes`, `permissao`) VALUES (8, 'administrador'),
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

CREATE TABLE `pessoas` (
  `idpessoas` int(10) unsigned NOT NULL auto_increment,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(50) default NULL,
  `telefone` varchar(16) default NULL,
  `celular` varchar(16) default NULL,
  `endereco` varchar(255) default NULL,
  `bairro` varchar(100) default NULL,
  `idcidades` int(10) unsigned NOT NULL,
  `desc` text,
  `acesso` tinyint(1) NOT NULL,
  PRIMARY KEY  (`idpessoas`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_pessoas_cidades1` (`idcidades`),
  KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Pessoas e Usuários do sistema' AUTO_INCREMENT=9 ;

-- 
-- Extraindo dados da tabela `pessoas`
-- 

INSERT INTO `pessoas` (`idpessoas`, `nome`, `email`, `senha`, `telefone`, `celular`, `endereco`, `bairro`, `idcidades`, `desc`, `acesso`) VALUES (1, 'Leonardo Lima de Vasconcellos', 'leonardo@devhouse.com.br', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(47) 3030-3333', '(47) 9999-9999', 'Rua sem nome, sn', 'Centro', 1, 'Analista de Sistemas', 1),
(2, 'Ismar Rubens Marquardt', 'ismar@ldi.com.br', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(47) 3801-2372', '(47) 8415-2272', 'Rua Ituporanga, 100', 'Bom Retiro', 1, '', 1),
(3, 'Jeferson Batera', 'jefabatera@hotmail.com', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '', '', '', 'Floresta', 1, '', 0),
(4, 'Camila', 'camila@hotmail.com', 'c5c8066d458ef32d2d9d6c641cd90b1f5259ebed', '', '431243124321', 'Rua', 'itajai', 2, '<br>', 1),
(5, 'Teste', 'teste@teste.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(48) 1546-4564', '(48) 9481-2648', 'Rua fjdsakfjdsaljkl', 'fdsafdsa', 3, 'fdsa fdsa fdsa fdsa <br>', 1),
(6, 'Fernando fjdsaklfdjsal', 'fernando_marcucci@hotmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(47) 3026-6908', '(47) 9999-4456', 'gjsdflçgsdfjlg sdflgj dflçsj', 'affdjsalfdjs', 1, 'gasjfldsj afdj salfj dsa<img src="images/accordian.gif" align="left" hspace="6" vspace="6">', 0),
(7, 'fdsafdsa', 'leo@le3o.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(34) 2143-1314', '(12) 3456-7894', 'fdsafdas', 'fdasfdsa', 3, 'fdasfdsafas<img src="images/accordian.gif" align="left" hspace="6" vspace="6">', 1),
(8, 'Lilian', 'lilian@lilian.com.br', '7c4a8d09ca3762af61e59520943dc26494f8941b', '(45) 6465-4654', '(49) 8789-7894', 'fdklsajfldasj', 'centro', 1, '', 1);

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `pessoas_atributospessoais`
-- 

CREATE TABLE `pessoas_atributospessoais` (
  `idpessoas` int(10) unsigned NOT NULL,
  `idatributospessoais` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`idpessoas`,`idatributospessoais`),
  KEY `fk_pessoas_has_atributospessoais_pessoas1` (`idpessoas`),
  KEY `fk_pessoas_has_atributospessoais_atributospessoais1` (`idatributospessoais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Extraindo dados da tabela `pessoas_atributospessoais`
-- 

INSERT INTO `pessoas_atributospessoais` (`idpessoas`, `idatributospessoais`) VALUES (2, 1),
(2, 2),
(2, 3),
(2, 4),
(3, 2),
(5, 1),
(5, 2),
(5, 3),
(5, 4),
(6, 2),
(6, 3),
(7, 3),
(7, 4);

-- --------------------------------------------------------

-- 
-- Estrutura da tabela `pessoas_cidades`
-- 

CREATE TABLE `pessoas_cidades` (
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

CREATE TABLE `pessoas_permissoes` (
  `idpessoas` int(10) unsigned NOT NULL,
  `idpermissoes` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`idpessoas`,`idpermissoes`),
  KEY `fk_pessoas_has_permissoes_pessoas1` (`idpessoas`),
  KEY `fk_pessoas_has_permissoes_permissoes1` (`idpermissoes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Extraindo dados da tabela `pessoas_permissoes`
-- 

INSERT INTO `pessoas_permissoes` (`idpessoas`, `idpermissoes`) VALUES (1, 8),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(4, 1),
(4, 3),
(4, 4),
(4, 5),
(5, 8),
(6, 8),
(7, 1),
(7, 2);

-- 
-- Restrições para as tabelas dumpadas
-- 

-- 
-- Restrições para a tabela `agenda`
-- 
ALTER TABLE `agenda`
  ADD CONSTRAINT `fk_agenda_locais1` FOREIGN KEY (`idlocais`) REFERENCES `locais` (`idlocais`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_agenda_pessoas1` FOREIGN KEY (`idpessoas`) REFERENCES `pessoas` (`idpessoas`) ON UPDATE CASCADE;

-- 
-- Restrições para a tabela `agenda_encarregados`
-- 
ALTER TABLE `agenda_encarregados`
  ADD CONSTRAINT `fk_agenda_encarregados_agenda1` FOREIGN KEY (`idagenda`) REFERENCES `agenda` (`idagenda`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_agenda_encarregados_pessoas1` FOREIGN KEY (`idpessoas`) REFERENCES `pessoas` (`idpessoas`) ON UPDATE CASCADE;

-- 
-- Restrições para a tabela `cidades_atributospessoais_pessoas`
-- 
ALTER TABLE `cidades_atributospessoais_pessoas`
  ADD CONSTRAINT `fk_cidades_has_atributospessoais_atributospessoais1` FOREIGN KEY (`idatributospessoais`) REFERENCES `atributospessoais` (`idatributospessoais`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cidades_has_atributospessoais_cidades1` FOREIGN KEY (`idcidades`) REFERENCES `cidades` (`idcidades`) ON UPDATE CASCADE,
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
