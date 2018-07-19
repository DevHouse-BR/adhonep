<?php
/**
 * @package		JomSocial
 * @subpackage 	Template 
 * @copyright (C) 2008 by Slashes & Dots Sdn Bhd - All rights reserved!
 * @license http://www.azrul.com Copyrighted Commercial Software
 * 
 * @param	my	Current browser's CUser object.
 **/
defined('_JEXEC') or die();
?>
<div class="form-surround">
<form action="<?php echo CRoute::getURI();?>" id="uploadForm" method="post" enctype="multipart/form-data">
<p style="margin-top: 30px;">
    <?php echo JText::_('CC UPLOAD NEW PICTURE DESCRIPTION');?>
	<?php echo JText::sprintf('CC MAX FILE SIZE FOR UPLOAD' , $uploadLimit ); ?>
</p>
<div>
    <input class="inputbox button" type="file" id="file-upload" name="Filedata" style="color: #666;" />
    <input class="button2" size="30" type="submit" id="file-upload-submit" value="<?php echo JText::_('CC BUTTON UPLOAD PICTURE');?>">
    <input type="hidden" name="action" value="doUpload" />
</div>
</form>
</div>
<div class="ctitle" style="margin-top: 30px;">
	<h2><?php echo JText::_('CC PICTURE LARGE HEADING');?></h2>
    <?php if($firstLogin){ echo '<a href="'.$skipLink.'">' . JText::_('CC SKIP UPLOAD AVATAR') . '</a>';} ?>
</div>
<p><?php echo JText::_('CC LARGE PICTURE DESCRIPTION');?></p>
<img src="<?php echo $my->getAvatar();?>" border="0" alt="" />
<div class="ctitle">
	<h2><?php echo JText::_('CC PICTURE THUMB HEADING');?></h2>
</div>
<p><?php echo JText::_('CC SMALL PICTURE DESCRIPTION');?></p>
<img src="<?php echo $my->getThumbAvatar();?>" border="0" alt="" />