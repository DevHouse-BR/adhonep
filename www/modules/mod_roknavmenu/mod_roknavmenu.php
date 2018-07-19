<?php
/**
 * @version $Id$
 * @package RocketWerx
 * @subpackage	RokNavMenu
 * @copyright Copyright (C) 2009 RocketWerx. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 */

// no direct access
defined('_JEXEC') or die('Restricted access');

// Include the syndicate functions only once
require_once (dirname(__FILE__).DS.'helper.php');
$params->def('menutype', 			'mainmenu');
$params->def('class_sfx', 			'');
$params->def('menu_images', 		0);

// Added in 1.5
$params->def('startLevel', 		0);
$params->def('endLevel', 			0);
$params->def('showAllChildren', 	0);

// Cache this basd on access level
$conf =& JFactory::getConfig();
if ($conf->getValue('config.caching') && $params->get("module_cache", 0)) { 
	$user =& JFactory::getUser();
	$aid  = (int) $user->get('aid', 0);
	switch ($aid) {
	    case 0:
	        $level = "public";
	        break;
	    case 1:
	        $level = "registered";
	        break;
	    case 2:
	        $level = "special";
	        break;
	}
	
	// Cache this based on access level
	$cache =& JFactory::getCache('mod_roknavmenu-' . $level);
	$menudata = $cache->call(array('modRokNavMenuHelper', 'getMenuData'), $params);
}
else {
    $menudata = modRokNavMenuHelper::getMenuData($params);
}
$menu = modRokNavMenuHelper::getFormattedMenu($menudata, $params);

$layout_file = JPATH_ROOT.DS.'templates'.DS.$mainframe->getTemplate().DS.'html'.DS.'mod_roknavmenu'.DS.'layouts'.DS.$params->get('custom_layout', "default").'.php';
$default_layout = JModuleHelper::getLayoutPath('mod_roknavmenu');

if (JFile::exists($layout_file)) {  //there is a custom_layout defined
	//Run the template layout if its there if not run the default layout
	//see if there is a custom layout defined			
	require($layout_file);
}
else {
	require($default_layout);
}