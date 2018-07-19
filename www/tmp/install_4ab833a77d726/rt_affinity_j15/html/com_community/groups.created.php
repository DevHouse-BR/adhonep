<?php
/**
 * @package		JomSocial
 * @subpackage 	Template 
 * @copyright (C) 2008 by Slashes & Dots Sdn Bhd - All rights reserved!
 * @license http://www.azrul.com Copyrighted Commercial Software
 * 
 */
defined('_JEXEC') or die();
?>
<p><?php echo JText::_('CC GROUP CREATED DESCRIPTION');?></p>
<ul class="group-created">
	<li>
		<a href="<?php echo $linkUpload; ?>"><?php echo JText::_('CC GROUP UPLOAD NEW AVATAR');?></a>
	</li>
	<li>
		<a href="<?php echo $linkBulletin; ?>"><?php echo JText::_('CC GROUP POST NEW BULLETIN');?></a>
	</li>
	<li>
		<a href="<?php echo $linkEdit;?>">
			<?php echo JText::_('CC EDIT GROUP DETAILS');?>
		</a>
	</li>
	<li>
		<a href="<?php echo $link; ?>">
			<?php echo JText::_('CC VIEW GROUP NOW');?>
		</a>
	</li>
</ul>


