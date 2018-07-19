<?php
/**
 * @package		JomSocial
 * @subpackage 	Template 
 * @copyright (C) 2008 by Slashes & Dots Sdn Bhd - All rights reserved!
 * @license http://www.azrul.com Copyrighted Commercial Software
 * 
 * @param	$groupId	The current group id.
 */
defined('_JEXEC') or die();
?>
<form action="<?php echo CRoute::_('index.php?option=com_community&view=groups&task=uploadavatar');?>" method="post" enctype="multipart/form-data">

<p><?php echo JText::_('CC GROUP UPLOAD DESC');?></p>
<div class="upload">
    <input type="file" name="filedata" size="40" class="button file" />
    <div class="clr"></div>
	<div class="readon-wrap1"><div class="readon1-l"></div><a class="readon-main"><span class="readon1-m"><span class="readon1-r"><input type="submit" value="<?php echo JText::_('CC BUTTON UPLOAD');?>" class="button" /></span></span></a></div><div class="clr"></div>
    <input type="hidden" name="groupid" value="<?php echo $groupId; ?>" />
    <input type="hidden" name="action" value="avatar"/>
</div>

<div class="ctitle"><h2><?php echo JText::_('CC GROUP THUMBNAIL AVATAR');?></h2></div>
<div class="avatar">
    <img src="<?php echo $thumbnail;?>" alt="<?php echo JText::_('Thumbnail Avatar');?>" border="0" />
</div>
<div class="caption">
    <?php echo JText::_('CC GROUP AVATAR NOTE SMALL');?>
</div>
<div class="clr"></div>

<div class="ctitle"><h2><?php echo JText::_('CC GROUP LARGE AVATAR');?></h2></div>
<div class="avatar">
    <img src="<?php echo $avatar;?>" alt="<?php echo JText::_('CC GROUP LARGE AVATAR');?>" border="0" />
</div>
<div class="clr"></div>
</form>