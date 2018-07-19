<?php
/**
 * @package		JomSocial
 * @subpackage 	Template 
 * @copyright (C) 2008 by Slashes & Dots Sdn Bhd - All rights reserved!
 * @license http://www.azrul.com Copyrighted Commercial Software
 * 
 * @params	isMine		boolean is this group belong to me
 * @params	members		An array of member objects 
 */
defined('_JEXEC') or die();
?>
<div class="button-surround">
<form name="addnews" method="post" action="<?php echo CRoute::getURI(); ?>" class="add-news">
	<div>
		<label for="title" style="font-weight: 700;"><?php echo JText::_('CC NEWS TITLE'); ?>:</label>
	</div>
	<div>
		<input id="news-title" value="<?php echo $title; ?>" type="text" size="50" name="title" class="inputbox" style="width: 350px;" />
	</div>
	<div>
		<label for="description" style="font-weight: 700;"><?php echo JText::_('CC NEWS DESCRIPTION'); ?>:</label>
	</div>
	
	<div>
		<?php
			if( $config->get( 'htmleditor' ) )
			{
		?>
		<?php echo $editor->display( 'message',  $message , '95%', '450', '10', '20' , false ); ?>
		<?php
			}
			else
			{
		?>
			<textarea style="width: 350px;" name="message"></textarea>
		<?php
			}
		?>
	</div>
	<div class="clr"></div>	
	<div style="text-align: center; padding-top: 20px;">
		<div class="readon-wrap1"><div class="readon1-l"></div><a class="readon-main"><span class="readon1-m"><span class="readon1-r"><input type="submit" value="<?php echo JText::_('CC NEWS ADD REPLY'); ?>" class="button" /></span></span></a></div>
		
		<div style="width: 25px; float: left; display: block; position: relative;">&nbsp;</div>
		
		<div class="readon-wrap1"><div class="readon1-l"></div><a class="readon-main"><span class="readon1-m"><span class="readon1-r"><button class="button" onclick="javascript:history.go(-1);return false;"><?php echo JText::_('CC BUTTON CANCEL'); ?></button></span></span></a></div><div class="clr"></div>
	</div>
</form>
</div>