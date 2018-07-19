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

<div class="denied-box">
<div class="componentheading"><?php echo JText::_('CC MEMBER LOGIN');?></div>
<?php echo JText::_('CC PERMISSION DENIED');?>
<div class="loginform"><div class="input-surround">
	<form action="<?php echo CRoute::getURI();?>" method="post" name="login" id="form-login" >

		<label for="username" class="jom-username"><?php echo JText::_('CC USERNAME'); ?></label>
		<div class="input-field-l"><input type="text" class="inputbox frontlogin" name="username" id="username" /></div>

		<div style="clear: left;"></div>		

		<label for="passwd" class="jom-pass"><?php echo JText::_('CC PASSWORD'); ?></label>
		<div class="input-field-l"><input type="password" class="inputbox frontlogin" name="passwd" id="password" /></div>

		<div style="clear: left;"></div>		

		<?php if(JPluginHelper::isEnabled('system', 'remember')) : ?>
		<label for="remember" style="padding: 4px 0 4px 80px;">
			<input type="checkbox" alt="<?php echo JText::_('CC REMEMBER MY DETAILS'); ?>" value="yes" id="remember" name="remember"/>
			<?php echo JText::_('CC REMEMBER MY DETAILS'); ?>
		</label>
		<?php endif; ?>

		<div style="padding: 4px 0 0 80px">
			<div class="readon-wrap1"><div class="readon1-l"></div><a class="readon-main"><span class="readon1-m"><span class="readon1-r"><input type="submit" value="<?php echo JText::_('CC BUTTON LOGIN');?>" name="submit" id="submit" class="button" /></span></span></a></div><div class="clr"></div>
			<input type="hidden" name="option" value="com_user" />
			<input type="hidden" name="task" value="login" />
			<input type="hidden" name="return" value="<?php echo $return; ?>" />
			<?php echo JHTML::_( 'form.token' ); ?>
		</div>

		<div style="padding: 12px 0 0 80px">
			<a href="<?php echo CRoute::_( 'index.php?option=com_user&view=reset' ); ?>" class="login-forgot-password"><span><?php echo JText::_('CC FORGOT PASSWORD'); ?></span></a>
			<br/>
			<a href="<?php echo CRoute::_( 'index.php?option=com_user&view=remind' ); ?>" class="login-forgot-username"><span><?php echo JText::_('CC FORGOT USERNAME'); ?></span></a>
			<br/>
			<a href="<?php echo CRoute::_( 'index.php?option=com_community&view=register' ); ?>" class="login-forgot-username"><span><?php echo JText::_('CC CREATE ACCOUNT'); ?></span></a>
		</div>
	</form>
	<?php
		if( $config->get('fbconnectkey') && $config->get('fbconnectsecret') )
		{
	?>
	<script type="text/javascript" src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php"></script>
	<script type="text/javascript">
		window.addEvent('domready', function()
		{
			FB_RequireFeatures(["XFBML"], function() {
				FB.Facebook.init( "<?php echo $config->get('fbconnectkey');?>" , "index.php?option=com_community&view=connect&task=receiver");
			});
		});

		function FBLogin()
		{
				FB.Facebook.get_sessionState().waitUntilReady(
						function() {
							joms.connect.update();
						});
		}
	</script>
	<div style="text-align: center;">
		<div class="white">
			<fb:login-button size="large" background="white" length="long" onlogin="FBLogin();"></fb:login-button>
		</div>
	</div>
	<?php
		}
	?>
</div></div>
</div>