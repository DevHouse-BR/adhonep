<?php
/**
 * @package		JomSocial
 * @subpackage 	Template 
 * @copyright (C) 2008 by Slashes & Dots Sdn Bhd - All rights reserved!
 * @license http://www.azrul.com Copyrighted Commercial Software
 * 
 * @param	applications	An array of applications object
 * @param	pagination		JPagination object 
 */
defined('_JEXEC') or die();
?>
<div class="yellowbox-bl"><div class="yellowbox-br"><div class="yellowbox-tl"><div class="yellowbox-tr">
	<div class="center">
		<form action="<?php echo CRoute::getURI(); ?>" method="post" id="jomsForm" name="jomsForm" class="community-form-validate">
		<div class="ctitle">
			<h2><?php echo JText::_( 'CC_REG_TITLE_USER_INFO' ); ?></h2>
		</div>
		<table class="ccontentTable paramlist" cellspacing="1" cellpadding="0">
		    <tbody>
				<tr>
					<td class="paramlist_key">
						<label id="jsnamemsg" for="jsname">*<?php echo JText::_( 'CC NAME' ); ?></label>												
					</td>
					<td class="paramlist_value">
					    <div class="login-fixed"><div class="input-field-l"><input type="text" name="jsname" id="jsname" size="40" value="<?php echo $data['html_field']['jsname']; ?>" class="inputbox required validate-name" maxlength="50" /></div></div>
						<span id="errjsnamemsg" style="display:none;">&nbsp;</span>
					</td>
				</tr>
    
				<tr>
					<td class="paramlist_key">
						<label id="jsusernamemsg" for="jsusername">*<?php echo JText::_( 'CC USERNAME' ); ?></label>
					</td>
					<td class="paramlist_value">
					    <div class="login-fixed"><div class="input-field-l"><input type="text" id="jsusername" name="jsusername" size="40" value="<?php echo $data['html_field']['jsusername']; ?>" 
						       class="inputbox required validate-username" 
							   maxlength="25" /></div></div>
					    <input type="hidden" name="usernamepass" id="usernamepass" value="N"/>							   
						<span id="errjsusernamemsg" style="display:none;">&nbsp;</span>
					</td>
				</tr>
				<tr>
					<td class="paramlist_key">
						<label id="jsemailmsg" for="jsemail">*<?php echo JText::_( 'CC EMAIL' ); ?></label>
					</td>
					<td class="paramlist_value">
					    <div class="login-fixed"><div class="input-field-l"><input type="text" id="jsemail" name="jsemail" size="40" value="<?php echo $data['html_field']['jsemail']; ?>" class="inputbox required validate-email" maxlength="100" /></div></div>
					    <input type="hidden" name="emailpass" id="emailpass" value="N"/>
					    <span id="errjsemailmsg" style="display:none;">&nbsp;</span>
					</td>
				</tr>
				<tr>
					<td class="paramlist_key">
						<label id="pwmsg" for="jspassword">*<?php echo JText::_( 'CC PASSWORD' ); ?></label>
					</td>
					<td class="paramlist_value">
					    <div class="login-fixed"><div class="input-field-l"><input class="inputbox required validate-password" type="password" id="jspassword" name="jspassword" size="40" value="" /></div></div>
					    <span id="errjspasswordmsg" style="display:none;">&nbsp;</span>
					</td>
				</tr>
				<tr>
					<td class="paramlist_key">
						<label id="pw2msg" for="jspassword2">*<?php echo JText::_( 'CC VERIFY PASSWORD' ); ?></label>
					</td>
					<td class="paramlist_value">
					    <div class="login-fixed"><div class="input-field-l"><input class="inputbox required validate-passverify" type="password" id="jspassword2" name="jspassword2" size="40" value="" /></div></div>
					    <span id="errjspassword2msg" style="display:none;">&nbsp;</span>
					</td>
				</tr>
				<tr>
				    <td class="paramlist_key">&nbsp;</td>
					<td class="paramlist_value">						
						<?php echo JText::_( 'CC_REG_REQUIRED_FILEDS' ); ?>
					</td>
				</tr>				
		    </tbody>
		</table>    
		<?php
		if( $config->get('enableterms') )
		{
		?>
		<div class="ctitle">
		<h2><?php echo JText::_( 'CC_REG_TITLE_TNC' ); ?></h2>
		</div>
		<table class="ccontentTable paramlist" cellspacing="1" cellpadding="0">
		  <tbody>
			<tr>
				<td class="paramlist_key" id="tncmsg" for="tnc">
				    <input type="checkbox" name="tnc" id="tnc" value="Y"
					       class="inputbox required"/>
		
				</td>
				<td class="paramlist_value">
					<?php echo JText::_('CC I HAVE READ').' <a href="javascript:void(0);" onclick="joms.registrations.windowTitle=\'' . JText::_('CC TERMS AND CONDITION') . '\';joms.registrations.showTermsWindow();">'.JText::_('CC TERMS AND CONDITION').'</a>.';?>
				</td>
			</tr>
		</tbody>
		</table>			
		<?php
		}
		?>
		<table class="ccontentTable paramlist" cellspacing="1" cellpadding="0">
		  <tbody>
			<tr>
				<td class="paramlist_key">&nbsp;</td>
				<td class="paramlist_value">
					<div id="cwin-wait" style="display:none;"></div>
					<div class="readon-wrap1"><div class="readon1-l"></div><a class="readon-main"><span class="readon1-m"><span class="readon1-r"><input class="button validateSubmit" type="submit" id="btnSubmit" value="<?php echo JText::_('CC NEXT'); ?>" name="submit"></span></span></a></div><div class="clr"></div>
				</td>
			</tr>
		</tbody>
		</table>
		<input type="hidden" name="task" value="register_save" />
		<input type="hidden" name="id" value="0" />
		<input type="hidden" name="gid" value="0" />
		<input type="hidden" id="authenticate" name="authenticate" value="0" />
		<input type="hidden" id="authkey" name="authkey" value="" />
		</form>
	</div>
</div></div></div></div>
<script type="text/javascript">
  cvalidate.init();

jQuery( '#jomsForm' ).submit( function() {
    jQuery('#btnSubmit').hide();
	jQuery('#cwin-wait').show();
	
	if(jQuery('#authenticate').val() != '1')
	{
		joms.registrations.authenticate();
		return false;			
	}
});

</script>
