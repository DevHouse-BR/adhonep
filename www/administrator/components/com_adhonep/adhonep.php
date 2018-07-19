<?php
/**
 * Joomla! 1.5 component adhonep
 *
 * @version $Id: adhonep.php 2009-10-08 17:53:58 svn $
 * @author DevHouse.com.br
 * @package Joomla
 * @subpackage adhonep
 * @license Copyright (c) 2009 - All Rights Reserved
 *
 * Executa todas as funções específicas do sistema Adhonep
 *
 * This component file was created using the Joomla Component Creator by Not Web Design
 * http://www.notwebdesign.com/joomla_component_creator/
 *
 */

// no direct access
defined('_JEXEC') or die('Restricted access');

/*
 * Define constants for all pages
 */
define( 'COM_ADHONEP_DIR', 'images'.DS.'adhonep'.DS );
define( 'COM_ADHONEP_BASE', JPATH_ROOT.DS.COM_ADHONEP_DIR );
define( 'COM_ADHONEP_BASEURL', JURI::root().str_replace( DS, '/', COM_ADHONEP_DIR ));

// Require the base controller
require_once JPATH_COMPONENT.DS.'controller.php';

// Require the base controller
require_once JPATH_COMPONENT.DS.'helpers'.DS.'helper.php';

// Initialize the controller
$controller = new AdhonepController( );

// Perform the Request task
$controller->execute( JRequest::getCmd('task'));
$controller->redirect();
?>