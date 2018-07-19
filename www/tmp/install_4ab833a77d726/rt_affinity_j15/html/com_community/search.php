<?php
/**
 * @package		JomSocial
 * @subpackage 	Template 
 * @copyright (C) 2008 by Slashes & Dots Sdn Bhd - All rights reserved!
 * @license http://www.azrul.com Copyrighted Commercial Software
 * 
 * @param	author		string
 * @param	$results	An array of user objects for the search result
 */
defined('_JEXEC') or die();
?>
<div class="input-surround">
	<form method="get" action="">
		<input type="hidden" name="option" value="com_community" />
		<input type="hidden" name="view" value="search" />
		<div class="login-fixed"><div class="input-field-l"><input type="text" class="inputbox" size="40" name="q" value="<?php echo $query; ?>" /></div></div>
		<div class="clr"></div>
		<div class="readon-wrap1"><div class="readon1-l"></div><a class="readon-main"><span class="readon1-m"><span class="readon1-r"><input type="submit" value="<?php echo JText::_('CC BUTTON SEARCH');?>" class="button" name="Search" /></span></span></a></div><div class="clr"></div>
	</form>
</div>
<?php
if( $results )
{
?>
	<h2>
		<?php echo JText::_('CC SEARCH RESULTS');?>
	</h2>
	<?php echo $resultHTML;?>
<?php		
}
else if( empty( $results ) && !empty( $query ) )
{
?>
	<br />
	<div class="yellowbox-bl"><div class="yellowbox-br"><div class="yellowbox-tl"><div class="yellowbox-tr">
		<div class="center">
		<?php echo JText::_('CC NO RESULT FROM SEARCH');?>
		</div>
	</div></div></div></div>
<?php
}
?>