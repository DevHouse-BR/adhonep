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

<div class="frontpage">
<script type="text/javascript"> joms.filters.bind();</script>
<?php echo $header;?>
        <div class="rightColContainer">
			<!-- Search -->
            <div class="yellowbox-bl"><div class="yellowbox-br"><div class="yellowbox-tl"><div class="yellowbox-tr">
                <div class="center">
                	<h3 class="frontTitle"><?php echo JText::_('CC SEARCH'); ?></h3>
	                <form name="search" id="cFormSearch" method="post" action="<?php echo CRoute::_('index.php?option=com_community&view=search');?>">
	                    <div class="input-field-l"><input type="text" class="inputbox" id="keyword" name="q" /></div>
	                    <div class="readon-wrap1"><div class="readon1-l"></div><a class="readon-main"><span class="readon1-m"><span class="readon1-r"><input type="submit" name="submit" class="button" value="<?php echo JText::_('CC BUTTON SEARCH'); ?>" /></span></span></a></div><div class="clr"></div>
	                	<div class="small">
	                    	<?php echo JText::sprintf('CC TRY ADVANCED SEARCH', CRoute::_('index.php?option=com_community&view=search&task=advancesearch') ); ?>
	                	</div>
	                </form>
                </div>
            </div></div></div></div>
			<div class="clr"></div>
			<!-- Latest Groups -->
			<?php if($config->get('enablegroups') ) { ?>
				<?php if( $config->get('showlatestgroups') == '1' || ($config->get('showlatestgroups') == '2' && $my->id != 0 ) ) { ?>
				<div class="yellowbox-bl"><div class="yellowbox-br"><div class="yellowbox-tl"><div class="yellowbox-tr">
					<div class="center">
						<?php echo $latestGroups; ?>
					</div>
				</div></div></div></div>
				<?php } ?>
			<?php } ?>
			<!-- Latest Groups -->
			
			<!-- Latest Photo -->
			<?php if($config->get('enablephotos')){ ?>
				<?php if( $config->get('showlatestphotos') == '1' || ($config->get('showlatestphotos') == '2' && $my->id != 0 ) ) { ?>
					<div class="yellowbox-bl"><div class="yellowbox-br"><div class="yellowbox-tl"><div class="yellowbox-tr">
						<div class="center" style="overflow: hidden;">
						    <h3 class="frontTitle"><?php echo JText::_('CC NEW PHOTOS'); ?></h3>
						    <ul style="margin: 0pt; padding: 0pt; list-style: none;">
						    	<?php
						    		for( $i = 0 ; $i < count( $latestPhotos ); $i++ )
						    		{
						    			$row	=& $latestPhotos[$i];
								?>
							    <li style="display: inline; padding: 0; background: none; margin: 0 3px 0 0 !important;">
									<a href="<?php echo CRoute::_('index.php?option=com_community&view=photos&task=photo&albumid=' . $row->albumid .  '&userid=' . $row->user->id) . '#photoid=' . $row->id;?>">
								<img class="avatar hasTip" title="<?php echo htmlspecialchars($row->caption);?>::<?php echo JText::sprintf('CC PHOTO UPLOADED BY' , $row->user->getDisplayName() );?>" src="<?php echo JURI::root() . $row->thumbnail; ?>" width="45" height="45" alt="<?php echo $row->user->getDisplayName();?>"/></a>
								</li>
								<?php
									}
								?>
							</ul>
						    <div style="text-align: right;">
						        <a href="<?php echo CRoute::_('index.php?option=com_community&view=photos'); ?>"><?php echo JText::_('CC VIEW ALL PHOTOS'); ?></a>
						    </div>
						</div>
					</div></div></div></div>
				<?php } ?>
			<?php } ?>
			<!-- Latest Photo -->

			<!-- Who's online -->
			<div class="yellowbox-bl"><div class="yellowbox-br"><div class="yellowbox-tl"><div class="yellowbox-tr">
				<div class="center" style="overflow: hidden;">
				    <h3 class="frontTitle"><?php echo JText::_('CC WHOSE ONLINE'); ?></h3>
				    <ul class="application-group-avatars" style="margin: 0pt; padding: 0pt; list-style: none;">
				    	<?php
				    		for($i=0; $i<count($onlineMembers); $i++)
				    		{
				    			$row	=& $onlineMembers[$i];
						?>
					    <li style="display: inline; padding: 0; background: none; margin: 0 3px 0 0 !important;">
						<a href="<?php echo CRoute::_('index.php?option=com_community&view=profile&userid='.$row->id ); ?>"><img class="avatar hasTip" src="<?php echo $row->user->getThumbAvatar(); ?>" title="<?php echo cAvatarTooltip($row->user); ?>" width="45" height="45" alt="<?php echo $row->user->getDisplayName();?>" /></a>
						</li>
						<?php
							}
						?>
					</ul>
				</div>
			</div></div></div></div>
			<!-- Who's online -->
		</div>
		<div class="leftColContainer">
			<?php if( $config->get('showlatestmembers') == '1' || ($config->get('showlatestmembers') == '2' && $my->id != 0 ) ) { ?>
			<!-- Featured Members -->
            <div class="app-box" id="latest-members">
                <div class="app-box-header"><div class="app-box-header">
                	<h2 class="app-box-title"><?php echo JText::_('CC MEMBERS'); ?></h2>
                    <div class="app-box-menus">
                        <div class="app-box-menu toggle">
                            <a class="app-box-menu-icon"
                               href="javascript: void(0)"
                               onclick="joms.apps.toggle('#latest-members');"><span class="app-box-menu-title"><?php echo JText::_('CC EXPAND');?></span></a>
                        </div>
                    </div>
                </div></div>
                <div class="app-box-content">
                    <div id="latest-members-nav" class="filterlink">
                        <div style="float: right;">
                            <a class="newest-member active-state" href="javascript:void(0);"><?php echo JText::_('CC NEWEST') ?></a>
                            <a class="active-member" href="javascript:void(0);"><?php echo JText::_('CC ACTIVE') ?></a>
                            <a class="popular-member" href="javascript:void(0);"><?php echo JText::_('CC POPULAR') ?></a>
                        </div>
                        <div class="loading"></div>
                    </div>
                    <div style="position: relative;">
                        <div id="latest-members-container">
                            <ul class="application-group-avatars" style="" id="membersBox">
                                <?php foreach ( $rows as $row ) : ?>
                                <li style="">
                                    <a href="<?php echo CRoute::_('index.php?option=com_community&view=profile&userid='.$row->id ); ?>"><img class="avatar hasTip" src="<?php echo $row->smallAvatar; ?>" title="<?php echo cAvatarTooltip($row); ?>" width="45" height="45" alt="<?php echo $row->user->getDisplayName();?>"/></a>
                                </li>
                                <?php endforeach; ?>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="app-box-footer no-border">
                    <a href="<?php echo CRoute::_('index.php?option=com_community&view=search&task=browse'); ?>"><?php echo JText::sprintf('CC BROWSE ALL' , $totalMembers );?></a>
                </div>
            </div>
            <!-- Featured Members -->
			<?php } ?>

			<?php if($config->get('enablevideos')) { ?>
				<?php if( $config->get('showlatestvideos') == '1' || ($config->get('showlatestvideos') == '2' && $my->id != 0 ) ) { ?>
				<!-- Latest Video -->
	            <div class="app-box" id="latest-videos">
	                <div class="app-box-header"><div class="app-box-header">
	                	<h2 class="app-box-title"><?php echo JText::_('CC LATEST VIDEOS'); ?></h2>
	                    <div class="app-box-menus">
	                        <div class="app-box-menu toggle">
	                            <a class="app-box-menu-icon"
	                               href="javascript: void(0)"
	                               onclick="joms.apps.toggle('#latest-videos');"><span class="app-box-menu-title"><?php echo JText::_('CC EXPAND');?></span></a>
	                        </div>
	                    </div>
	                </div></div>
	                <div class="app-box-content">
						<?php foreach( $latestVideos as $video ) { ?>
	
				        <div class="video-item hasTip" id="<?php echo "video-" . $video->id ?>" title="<?php echo $video->description; ?>">
				        <div class="video-item">
				            <div class="video-thumb">
			                    <a class="video-thumb-url" href="<?php echo $video->url; ?>" style="width: <?php echo $params->videoThumbWidth; ?>px; height:<?php echo $params->videoThumbHeight; ?>px;">
									<img src="<?php echo $video->thumb; ?>" style="width: <?php echo $params->videoThumbWidth; ?>px; height:<?php echo $params->videoThumbHeight; ?>px;" alt="<?php echo $video->title; ?>" />
								</a>
			                    <span class="video-durationHMS"><?php echo $video->durationHMS; ?></span>
				            </div>
				            <div class="video-summary">
				                <div class="video-title">
				                	<a href="<?php echo $video->url; ?>"><?php echo $video->title; ?></a>
				                </div>
				                <div class="video-details small">
				                    <div class="video-hits"><?php echo JText::sprintf('CC VIDEO HITS COUNT', $video->hits) ?></div>
				                    <div class="video-lastupdated">
										<?php echo JText::sprintf('CC VIDEO LAST UPDATED', $video->created ); ?>
									</div>
				                    <div class="video-creatorName">
										<a href="<?php echo CRoute::_('index.php?option=com_community&view=profile&userid='.$video->creator); ?>">
											<?php echo $video->creatorName; ?>
										</a>
									</div>
				                </div>
				            </div>
	                        
				            <div class="clr"></div>
						</div>
				        </div>
						<?php } ?>
	                </div>
	                <div class="app-box-footer no-border">
	                    <a href="<?php echo CRoute::_('index.php?option=com_community&view=videos'); ?>"><?php echo JText::_('CC VIEW ALL VIDEOS'); ?></a>
	                </div>
	            </div>
	            <!-- Latest Video -->
	            <?php } ?>
			<?php } ?>

			<?php if( $config->get('showactivitystream') == '1' || ($config->get('showactivitystream') == '2' && $my->id != 0 ) ) { ?>
			<!-- Recent Activities -->
			<div class="app-box" id="recent-activities">
                <div class="app-box-header"><div class="app-box-header">
                    <h2 class="app-box-title"><?php echo JText::_('CC RECENT ACTIVITIES'); ?></h2>
                    <div class="app-box-menus">
                        <div class="app-box-menu toggle">
                            <a class="app-box-menu-icon"
                               href="javascript: void(0)"
                               onclick="joms.apps.toggle('#recent-activities');"><span class="app-box-menu-title"><?php echo JText::_('CC EXPAND');?></span></a>
                        </div>
                    </div>
				</div></div>
                <div class="app-box-content">
					<?php if($alreadyLogin==1): ?>
                    <div id="activity-stream-nav" class="filterlink">
                        <div style="float: right;">
                            <a class="all-activity active-state" href="javascript:void(0);"><?php echo JText::_('CC SHOW ALL') ?></a>
                            <a class="me-and-friends-activity" href="javascript:void(0);"><?php echo JText::_('CC ME AND FRIENDS') ?></a>
                        </div>
                        <div class="loading"></div>
                    </div>
                    <?php endif; ?>
                    <div style="position: relative;">
                        <div id="activity-stream-container">
                            <?php echo $userActivities; ?>
                        </div>
                    </div>
                </div>
			</div>
          	<!-- Recent Activities -->
          	<?php } ?>
		</div>
		<div class="clr"></div>
</div>