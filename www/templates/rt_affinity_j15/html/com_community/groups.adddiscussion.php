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
<div style="width: 80%; margin: 0 auto;">
<form action="<?php echo CRoute::getURI(); ?>" method="post" class="add-discussion">
	<dl>
	    <dt class="col-left" style="width: 30%;">
			<label for="title"><?php echo JText::_('CC DISCUSSION TITLE');?>:</label>
		</dt>
		<dd class="col-right" style="width: 65%;">
			<input type="text" name="title" size="40" class="inputbox" style="width: 90%" />
		</dd>
	    <dt class="col-left" style="width: 30%;">
			<label for="message"><?php echo JText::_('CC DISCUSSION MESSAGE');?>:</label>
		</dt>
		<dd class="col-right" style="width: 65%;">
			<textarea rows="3" cols="40" name="message" class="inputbox" style="width: 90%"></textarea>
		</dd>
	    <dt class="col-left" style="width: 30%;">
		</dt>
		<dd class="col-right" style="width: 65%;">
		    <input type="hidden" value="<?php echo $group->id; ?>" name="groupid" />
			<div class="readon-wrap1"><div class="readon1-l"></div><a class="readon-main"><span class="readon1-m"><span class="readon1-r"><input type="submit" class="button" value="<?php echo JText::_('CC ADD DISCUSSION BUTTON');?>" /></span></span></a></div><div class="clr"></div>
		</dd>
	</dl>
	<div class="clr"></div>
</form>
</div>