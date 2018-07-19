<?php
/**
 * @package		JomSocial
 * @subpackage 	Template 
 * @copyright (C) 2008 by Slashes & Dots Sdn Bhd - All rights reserved!
 * @license http://www.azrul.com Copyrighted Commercial Software
 * 
 */
defined('_JEXEC') or die();

$html = "<script type=\"text/javascript\">
jQuery(document).ready( function() {
	if ( jQuery('#cToolbarNav').length > 0 ) {
		jQuery('#cToolbarNav').css('margin-bottom', '0');
	}
});
</script>";
$mainframe =& JFactory::getApplication();
$mainframe->addCustomHeadTag( $html );
?>
<div class="yellowbox-bl" id="miniheader"><div class="yellowbox-br"><div class="yellowbox-tl"><div class="yellowbox-tr">
    <div class="center">
		<div class="profile-toolbox-bl" id="miniheader">
		    <div class="profile-toolbox-br">
		        <div class="profile-toolbox-tl">
		            <div style="float: left;">
						<div style="float: left; margin: 0 10px 0 0; width: 40px;">
						    <a href="<?php echo CRoute::_('index.php?option=com_community&view=profile&userid='.$user->id); ?>">
								<img width="32" src="<?php echo $user->getThumbAvatar(); ?>" alt="<?php echo $user->getDisplayName(); ?>" class="avatar" />
							</a>
						</div>
						<div style="margin: 0 0 0 50px;">
							<strong><span class="profile-toolbox-name"><?php echo $user->getDisplayName(); ?></span></strong><br />
							<a href="<?php echo CRoute::_('index.php?option=com_community&view=profile&userid='.$user->id); ?>">
								<?php echo JText::_('CC GO TO PROFILE'); ?>
							</a>
						</div>
					</div>
			
					<div style="float: right;">
						<ul class="small-button" style="padding-top:5px;">
							<?php if(!$isFriend && !$isMine) { ?>
						    <li class="btn-add-friend">
								<a href="javascript:void(0)" onclick="joms.friends.connect('<?php echo $user->id;?>')"><span><?php echo JText::_('CC ADD AS FRIEND'); ?></span></a>
							</li>
							<?php } ?>

							<?php if($config->get('enablephotos')): ?>
						    <li class="btn-gallery">
								<a href="<?php echo CRoute::_('index.php?option=com_community&view=photos&task=myphotos&userid='.$user->id); ?>">
									<span><?php echo JText::_('CC PHOTO GALLERY'); ?></span>
								</a>
							</li>
							<?php endif; ?>

							<?php if($config->get('enablevideos')): ?>
						    <li class="btn-videos">
								<a href="<?php echo CRoute::_('index.php?option=com_community&view=videos&task=myvideos&userid='.$user->id); ?>">
									<span><?php echo JText::_('CC VIDEOS GALLERY'); ?></span>
								</a>
							</li>
							<?php endif; ?>

							<?php if( !$isMine ): ?>
						    <li class="btn-write-message">
								<a onclick="<?php echo $sendMsg; ?>" href="javascript:void(0);">
									<span><?php echo JText::_('CC WRITE MESSAGE'); ?></span>
								</a>
							</li>
							<?php endif; ?>
						</ul>
					</div>
					<div style="clear: both;"></div>
				</div>
			</div>
		</div>
	</div>
</div></div></div></div>