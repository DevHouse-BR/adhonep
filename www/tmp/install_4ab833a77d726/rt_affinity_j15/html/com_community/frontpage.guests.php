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
<div class="guest-block">
	<div class="yellowbox-bl"><div class="yellowbox-br"><div class="yellowbox-tl"><div class="yellowbox-tr">
		<div class="center">
			<table cellpadding="0" cellspacing="0" border="0" width="100%" class="guest-block">
			    <tr>
			        <td valign="top">
					    <div class="introduction">
					        <h1><?php echo JText::_('CC GET CONNECTED TITLE'); ?></h1>
					        <ul id="featurelist">
					            <li><?php echo JText::_('CC CONNECT AND EXPAND'); ?></li>
					            <li><?php echo JText::_('CC VEW PROFILES AND ADD FRIEND'); ?></li>
					            <li><?php echo JText::_('CC SHARE PHOTOS AND VIDEOS'); ?></li>
					            <li><?php echo JText::_('CC CREATE OWN GROUP OR JOIN'); ?></li>
					        </ul>
					        <div class="joinbutton">
								<a id="joinButton" href="<?php echo CRoute::_( 'index.php?option=com_community&view=register' , false ); ?>" title="<?php echo JText::_('CC JOIN US NOW'); ?>">
								    <?php echo JText::_('CC JOIN US NOW'); ?>
								</a>
							</div>
					    </div>
			        </td>
			        <td width="200">
					    <div class="loginform">
					    	<form action="<?php echo CRoute::getURI();?>" method="post" name="login" id="form-login" >
					        <h2><?php echo JText::_('CC MEMBER LOGIN'); ?></h2>
					            <label>
									<?php echo JText::_('CC USERNAME'); ?><br />
					                <div class="input-field-l"><input type="text" class="inputbox frontlogin" name="username" id="username" /></div>
					            </label>

					            <label>
									<?php echo JText::_('CC PASSWORD'); ?><br />
					                <div class="input-field-l"><input type="password" class="inputbox frontlogin" name="passwd" id="password" /></div>
					            </label>

                                <?php if(JPluginHelper::isEnabled('system', 'remember')) : ?>
								<label for="remember">
									<input type="checkbox" alt="<?php echo JText::_('CC REMEMBER MY DETAILS'); ?>" value="yes" id="remember" name="remember"/>
									<?php echo JText::_('CC REMEMBER MY DETAILS'); ?>
								</label>
								<?php endif; ?>

								<div style="text-align: center; padding: 10px 0 5px;">
								    <div class="readon-wrap1"><div class="readon1-l"></div><a class="readon-main"><span class="readon1-m"><span class="readon1-r"><input type="submit" value="<?php echo JText::_('CC BUTTON LOGIN');?>" name="submit" id="submit" class="button" /></span></span></a></div><div class="clr"></div>
									<input type="hidden" name="option" value="com_user" />
									<input type="hidden" name="task" value="login" />
									<input type="hidden" name="return" value="<?php echo $return; ?>" />
									<?php echo JHTML::_( 'form.token' ); ?>
								</div>
								
								<a href="<?php echo CRoute::_( 'index.php?option=com_user&view=reset' ); ?>" class="login-forgot-password">
									<span><?php echo JText::_('CC FORGOT PASSWORD'); ?></span>
								</a><br />
								<a href="<?php echo CRoute::_( 'index.php?option=com_user&view=remind' ); ?>" class="login-forgot-username">
									<span><?php echo JText::_('CC FORGOT USERNAME'); ?></span>
								</a>
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
									                                			FB.Facebook.init( "<?php echo $config->get('fbconnectkey');?>" , "<?php echo CRoute::_('index.php?option=com_community&view=connect&task=receiver&tmpl=component');?>");
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
					    </div>
			        </td>
			    </tr>
			</table>
		</div>
	</div></div></div></div>
</div>
<div class="clr"></div>
<div class="k2-break1"><div class="k2-break2"></div><div class="k2-break3"></div></div>
<div class="k2-break-div"></div>
<div class="k2-break4"><div class="k2-break5"></div><div class="k2-break6"></div></div>