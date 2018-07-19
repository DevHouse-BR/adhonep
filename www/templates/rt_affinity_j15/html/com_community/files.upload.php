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

<div>
	<span><?php echo JText::_('CC SUPPORTED EXTENSIONS');?></span>
	<span>.pdf .txt .zip .html</span>
</div>
<div class="button-surround"><div class="form-surround">
<form name="newalbum" id="newalbum" method="post" action="<?php echo CRoute::getURI(); ?>" enctype="multipart/form-data" class="community-form-validate">
<div>
	<span style="float: left; width: 30%;"><?php echo JText::_('CC UPLOAD'); ?>:</span>
	<span><input type="file" name="filedata" class="required" /></span>
</div>
<div>
	<div class="readon-wrap1"><div class="readon1-l"></div><a class="readon-main"><span class="readon1-m"><span class="readon1-r"><button class="button validateSubmit"><?php echo JText::_('CC BUTTON START UPLOAD'); ?></button></span></span></a></div><div class="clr"></div>
</div>
</form></div></div>
<script type="text/javascript">
	cvalidate.init();
</script>