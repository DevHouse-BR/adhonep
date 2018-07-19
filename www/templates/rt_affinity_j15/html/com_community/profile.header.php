<?php if( $isMine ): ?>
<script type="text/javascript" language="javascript">
var cur_status = '';

function changeStatus()
{
	jQuery('#statustext').addClass('status-edit');
	jQuery('#save-status').show();
	cur_status = jQuery('#statustext').val();
}
function saveStatus()
{
	if ( cur_status != jQuery('#statustext').val() ) {
		var inputVal	= jQuery('#statustext').val();
		jax.call('community', 'status,ajaxUpdate', inputVal);
		jQuery('#profile-status span#profile-status-message').html(inputVal);
		jQuery('title').val(inputVal);
		cur_status = inputVal;
	}
	jQuery('#statustext').removeClass('status-edit');
	jQuery('#save-status').hide();
	jQuery('#statustext').blur();
	return false;
}
function saveChanges(e)
{
	var unicode = e.keyCode? e.keyCode : e.charCode;
	
	if ( unicode == 13 )
	{
		saveStatus();
		return false;
	}
}

jQuery(document).ready( function() {
	jQuery('#statustext').val('<?php echo addslashes(JText::_($profile->status)); ?>');
});

</script>
<?php endif; ?>
	<?php echo $adminControlHTML; ?>
	<div class="yellowbox-bl"><div class="yellowbox-br"><div class="yellowbox-tl"><div class="yellowbox-tr">
        <div class="center">
			<div class="profile-box">
				<!-- Avatar -->
				<div class="profile-avatar">
				    <?php if( $isMine ): ?>
					<a href="<?php echo CRoute::_('index.php?option=com_community&view=profile&task=edit'); ?>">
					<?php endif; ?>
					<img src="<?php echo $profile->largeAvatar; ?>" alt="<?php echo $user->getDisplayName(); ?>" />
					<?php if( $isMine ): ?>
					</a>
					<?php endif; ?>
				</div>
				<!-- Short Profile info -->
				<div class="profile-info">
					<div class="contentheading">
						<?php echo $user->getDisplayName(); ?>
					</div>
					<div id="profile-status">
						<span id="profile-status-message"><?php echo $profile->status; ?></span>
					</div>
					<ul class="profile-details">
					    <li class="title"><?php echo JText::_('CC KARMA'); ?></li>
			    <li>&nbsp;<img src="<?php echo $karmaImgUrl; ?>" alt="" /></li>

					    <li class="title"><?php echo JText::_('CC MEMBER SINCE'); ?></li>
					    <li><?php echo JHTML::_('date', $registerDate , JText::_('DATE_FORMAT_LC2')); ?></li>

					    <li class="title"><?php echo JText::_('CC LAST LOGIN'); ?></li>
					    <li><?php echo $lastLogin; ?></li>

					    <li class="title"><?php echo JText::_('CC PROFILE VIEW'); ?></li>
					    <li><?php echo JText::sprintf('CC PROFILE VIEW RESULT', $user->getViewCount() ) ;?></li>
					</ul>
					<div class="clr"></div>
				</div>
				<div class="clr"></div>
			</div>
		</div>
	</div></div></div></div>
	<div class="profile-tool-override">
		<div class="yellowbox-bl"><div class="yellowbox-br"><div class="yellowbox-tl"><div class="yellowbox-tr">
	        <div class="center">
				<div class="profile-toolbox-bl">
				    <div class="profile-toolbox-br">
				        <div class="profile-toolbox-tl">
							<?php if( !$isMine ): ?>
							<ul class="small-button">
								<?php if(!$isFriend && !$isMine) { ?>
							    <li class="btn-add-friend">
									<a href="javascript:void(0)" onclick="joms.friends.connect('<?php echo $profile->id;?>')"><span><?php echo JText::_('CC ADD AS FRIEND'); ?></span></a>
								</li>
								<?php } ?>
								<?php if($config->get('enablephotos')): ?>
							    <li class="btn-gallery">
									<a href="<?php echo CRoute::_('index.php?option=com_community&view=photos&task=myphotos&userid='.$profile->id); ?>">
										<span><?php echo JText::_('CC PHOTO GALLERY'); ?></span>
									</a>
								</li>
								<?php endif; ?>
								<?php if($showBlogLink): ?>
							    <li class="btn-blog">
						<a href="<?php echo CRoute::_('index.php?option=com_myblog&blogger=' . $user->getDisplayName() . '&Itemid=' . $blogItemId ); ?>">
										<span><?php echo JText::_('CC BLOG'); ?></span>
									</a>
								</li>
								<?php endif; ?>
								<?php if($config->get('enablevideos')): ?>
							    <li class="btn-videos">
									<a href="<?php echo CRoute::_('index.php?option=com_community&view=videos&task=myvideos&userid='.$profile->id); ?>">
										<span><?php echo JText::_('CC VIDEOS GALLERY'); ?></span>
									</a>
								</li>
								<?php endif; ?>

					<?php if( !$isMine && $config->get('enablepm')): ?>
							    <li class="btn-write-message">
									<a onclick="<?php echo $sendMsg; ?>" href="javascript:void(0);">
										<span><?php echo JText::_('CC WRITE MESSAGE'); ?></span>
									</a>
								</li>
								<?php endif; ?>
							</ul>
			    			<?php else : ?>
								<form name="status" class="status-input" onsubmit="return false;">
						        <div class="statustext">
						            <label for="statustext"><?php echo JText::_('CC MY STATUS'); ?></label>
									<div class="input-field-l"><input name="statustext" id="statustext" type="text" class="status" value="" onfocus="changeStatus();return false;" onblur="saveStatus();return false;" onkeyup="saveChanges(event);return false;" /></div>
									<a href="javascript:void(0);" id="save-status" style="display: none;" onclick="saveStatus();return false;"><?php echo JText::_('Save'); ?></a>
						        </div>
							</form>
		                	<div id="profile-header" class="js-box-grey" style="margin: 0 0 10px; padding-left: 40px;">
								<ul class="actions">
									<li class="profile">
				                        <a href="<?php echo CRoute::_('index.php?option=com_community&view=profile&task=edit'); ?>">
				                            <span><?php echo JText::_('CC EDIT PROFILE'); ?></span>
				                        </a>
									</li>
									<li class="avatar">
				                        <a href="<?php echo CRoute::_('index.php?option=com_community&view=profile&task=uploadAvatar'); ?>">
				                            <span><?php echo JText::_('CC EDIT AVATAR'); ?></span>
				                        </a>
									</li>
									<li class="privacy">
				                        <a href="<?php echo CRoute::_('index.php?option=com_community&view=profile&task=privacy'); ?>">
				                            <span><?php echo JText::_('CC EDIT PRIVACY'); ?></span>
				                        </a>
									</li>
									<?php if($config->get('enablevideos')){ ?>
										<li class="video">
					                        <a href="javascript:void(0);" onclick="joms.videos.addVideo();">
					                            <span><?php echo JText::_('CC ADD VIDEO'); ?></span>
					                        </a>
										</li>
									<?php } ?>
								</ul>
								<ul class="actions">
									<li class="apps">
				                        <a href="<?php echo CRoute::_('index.php?option=com_community&view=apps&task=browse'); ?>">
				                            <span><?php echo JText::_('CC ADD APPLICATIONS'); ?></span>
				                        </a>
									</li>
									<li class="group">
				                        <a href="<?php echo CRoute::_('index.php?option=com_community&view=groups&task=create'); ?>">
				                            <span><?php echo JText::_('CC ADD GROUP'); ?></span>
				                        </a>
									</li>
									<li class="invite">
				                        <a href="<?php echo CRoute::_('index.php?option=com_community&view=friends&task=invite'); ?>">
				                            <span><?php echo JText::_('CC INVITE FRIENDS'); ?></span>
				                        </a>
									</li>
								</ul>
				                <ul class="actions">
									<li class="write">
				                        <a href="<?php echo CRoute::_('index.php?option=com_community&view=inbox&task=write'); ?>">
				                            <span><?php echo JText::_('CC WRITE MESSAGE'); ?></span>
				                        </a>
									</li>
						<?php if( $config->get('enablepm')){ ?>
									<li class="inbox">
				                        <a href="<?php echo CRoute::_('index.php?option=com_community&view=inbox'); ?>">
				                            <span><?php echo JText::_('CC VIEW YOUR INBOX'); ?></span>
				                        </a>
									</li>
						<?php } ?>
									<?php if($config->get('enablephotos')){ ?>
										<li class="photo">
					                        <a href="<?php echo CRoute::_('index.php?option=com_community&view=photos&task=uploader&userid='.$profile->id); ?>">
					                            <span><?php echo JText::_('CC UPLOAD PHOTOS'); ?></span>
					                        </a>
										</li>
									<?php } ?>
								</ul>
				                <div class="clr"></div>
							</div>
							<ul class="updates">
							    <li class="title"><?php echo JText::_('CC NEW UPDATES'); ?></li>
							    <li>
									<a href="<?php echo CRoute::_('index.php?option=com_community&view=inbox'); ?>" class="inbox">
										<?php echo JText::sprintf('CC NEW MESSAGES', $unread); ?>
									</a>
								</li>
							    <li>
									<a href="<?php echo CRoute::_('index.php?option=com_community&view=friends&task=pending'); ?>" class="friend">
										<?php echo JText::sprintf('CC NEW FRIEND REQUESTS', $pending); ?></a>
								</li>
							</ul>
			                <div class="clr"></div>
							<?php endif; ?>
						</div>
					</div>
				</div>
			</div>
		</div></div></div></div>
	</div>