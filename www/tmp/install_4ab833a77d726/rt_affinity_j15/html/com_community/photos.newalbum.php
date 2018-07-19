<?php
/**
 * @package		JomSocial
 * @subpackage 	Template 
 * @copyright (C) 2008 by Slashes & Dots Sdn Bhd - All rights reserved!
 * @license http://www.azrul.com Copyrighted Commercial Software
 */
defined('_JEXEC') or die();
?>
<div style="width: 80%; margin: 0 auto;"><div class="form-surround">
	<form name="newalbum" id="newalbum" method="post" action="<?php echo CRoute::getURI(); ?>" class="community-form-validate">
	<dl>
		<dt class="col-left">
			<label for="name"><?php echo JText::_('CC ALBUM NAME');?><span style="color: red;">*</span></label>
		</dt>
		<dd class="col-right"><input type="text" name="name" class="inputbox required" size="35" style="width: 100%" /></dd>

		<dt class="col-left"><label for="description"><?php echo JText::_('CC ALBUM DESCRIPTION');?></label></dt>
		<dd class="col-right"><textarea name="description" class="inputbox" style="width: 100%"></textarea></dd>

	    <dt class="col-left"></dt>
		<dd class="col-right">
			<div class="readon-wrap1"><div class="readon1-l"></div><a class="readon-main"><span class="readon1-m"><span class="readon1-r"><input type="submit" value="<?php echo JText::_('CC CREATE ALBUM BUTTON');?>" class="button validateSubmit"/></span></span></a></div><div class="clr"></div>
		</dd>
	</dl>
	<div class="clr"></div>
	</form>
</div></div>
<script type="text/javascript">
	cvalidate.init();
</script>