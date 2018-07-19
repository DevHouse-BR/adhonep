<?php
/**
 * @package		JomSocial
 * @subpackage 	Template 
 * @copyright (C) 2008 by Slashes & Dots Sdn Bhd - All rights reserved!
 * @license http://www.azrul.com Copyrighted Commercial Software
 * 
 * @param	my		User object
 **/
defined('_JEXEC') or die();
?>
<p><?php echo JText::_('CC INVITE TEXT'); ?></p>
<form action="<?php echo CRoute::getURI(); ?>" method="post">

<dl class="2cols" style="width: 80%; margin: 0 auto;">
    <dt class="col-left" style="margin: 0pt 0pt 10px;">
        <?php echo JText::_('CC INVITE FROM'); ?>:
    </dt>
    <dd class="col-right" style="margin: 0pt 0pt 10px;">
        <div class="inputbox" style="width: 100%;"><strong><?php echo $my->email; ?></strong></div>
	</dd>
    
    <dt class="col-left">
        <?php echo JText::_('CC INVITE TO'); ?>:
        
    </dt>
    <dd class="col-right">
        <textarea class="inputbox" style="width: 100%; height: 100px; margin: 0;" name="emails"><?php echo (! empty($post['emails'])) ? $post['emails'] : '' ; ?></textarea><br />
        <span class="small" style="padding: 0 0 0 10px; line-height: normal;"><?php echo JText::_('CC SEPARATE BY COMMA'); ?></span>
	</dd>
    
    <dt class="col-left">
        <?php echo JText::_('CC INVITE MESSAGE'); ?>:
    </dt>
    <dd class="col-right">
        <textarea class="inputbox" style="width: 100%; height: 100px; margin: 0;" name="message"><?php echo (! empty($post['message'])) ? $post['message'] : '' ; ?></textarea><br />
        <span class="small" style="padding: 0 0 0 10px; line-height: normal;"><?php echo JText::_('CC OPTIONAL');?></span>
	</dd>
    
    <dt class="col-left">
    </dt>
    
    <dd class="col-right">
        <input type="hidden" name="action" value="invite" />
        <div class="readon-wrap1"><div class="readon1-l"></div><a class="readon-main"><span class="readon1-m"><span class="readon1-r"><input type="submit" class="button" value="<?php echo JText::_('CC INVITE BUTTON'); ?>"></span></span></a></div><div class="clr"></div>
	</dd>
</dl>
<div style="clear: both;"></div>		
</form>