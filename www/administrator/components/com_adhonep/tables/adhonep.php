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

// Include library dependencies
jimport('joomla.filter.input');

/**
* Table class
*
* @package          Joomla
* @subpackage		adhonep
*/
class TableItem extends JTable {

	/**
	 * Primary Key
	 *
	 * @var int
	 */
	var $id = null;


    /**
	 * Constructor
	 *
	 * @param object Database connector object
	 * @since 1.0
	 */
	function __construct(& $db) {
		parent::__construct('#__adhonep', 'id', $db);
	}

	/**
	 * Overloaded check method to ensure data integrity
	 *
	 * @access public
	 * @return boolean True on success
	 */
	function check() {
		return true;
	}

}
?>