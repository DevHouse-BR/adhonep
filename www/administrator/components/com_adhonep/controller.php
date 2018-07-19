<?php
/**
 * Joomla! 1.5 component adhonep
 *
 * @version $Id: controller.php 2009-10-08 17:53:58 svn $
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

jimport( 'joomla.application.component.controller' );
require_once( JPATH_COMPONENT.DS.'helpers'.DS.'helper.php' );

/**
 * adhonep Controller
 *
 * @package Joomla
 * @subpackage adhonep
 */
class AdhonepController extends JController {
    /**
     * Constructor
     * @access private
     * @subpackage adhonep
     */
    function __construct() {
        //Get View
        if(JRequest::getCmd('view') == '') {
            JRequest::setVar('view', 'default');
        }
        $this->item_type = 'Default';
        parent::__construct();
    }
}
?>