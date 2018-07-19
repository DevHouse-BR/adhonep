<?php
/**
 * @package		JomSocial
 * @subpackage 	Template 
 * @copyright (C) 2008 by Slashes & Dots Sdn Bhd - All rights reserved!
 * @license http://www.azrul.com Copyrighted Commercial Software
 * 
 * 
 */
defined('_JEXEC') or die();
?>
<div class="video-search-form"><div class="input-surround">
	<form name="searchVideo" action="<?php echo CRoute::getURI(); ?>" method="get">
		<div class="input-field-l"><input type="text" class="inputbox" id="search-text" name="search-text" size="50" /></div>
		<input type="hidden" name="option" value="com_community" />
		<input type="hidden" name="task" value="search" />
		<input type="hidden" name="view" value="videos" />
		<div class="clr"></div>
		<div class="readon-wrap1"><div class="readon1-l"></div><a class="readon-main"><span class="readon1-m"><span class="readon1-r"><input type="submit" name="search" class="button" value="<?php echo JText::_('CC BUTTON SEARCH');?>"/></span></span></a></div><div class="clr"></div>
	</form>
</div></div>

<?php
if( $posted )
{
	if( $result )
	{
?>
	<div class="video-results">
        <?php
		foreach($result as $video)
		{
		?>
        <div class="video-result">
            <div class="video-thumb">
                <a class="video-thumb-url" href="<?php echo $video->url; ?>"><img src="<?php echo $video->thumb; ?>" width="<?php echo $params->videoThumbWidth; ?>" height="<?php echo $params->videoThumbHeight; ?>" alt="" /></a>
                <span class="video-durationHMS"><?php echo $video->durationHMS; ?></span>
            </div>
    
            <div class="video-summary">
                <div class="video-title"><a href="<?php echo $video->url; ?>"><?php echo $video->title; ?></a></div>
                <div class="video-shortdesc"><?php echo $video->shortdesc; ?></div>
                <div class="video-details small">
                    <?php echo JText::sprintf('CC VIDEO CREATED ON' , $video->created );?>
                </div>
            </div>
            
            <div class="clr"></div>
        </div>
        <?php
		}
		?>
    </div>
<?php
	} else { echo JText::_('CC NO RESULT'); }
}
?>