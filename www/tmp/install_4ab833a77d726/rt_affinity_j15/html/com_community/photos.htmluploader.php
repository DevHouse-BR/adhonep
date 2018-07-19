<?php
/**
 * @package		JomSocial
 * @subpackage 	Template 
 * @copyright (C) 2008 by Slashes & Dots Sdn Bhd - All rights reserved!
 * @license http://www.azrul.com Copyrighted Commercial Software
 */
defined('_JEXEC') or die();
?>
<?php
if( $albums )
{
?>
	<script type="text/javascript" src="<?php echo JURI::root(); ?>components/com_community/assets/ajaxfileupload.pack.js"></script>
	<script type="text/javascript" language="javascript">
	function submitForm()
	{
		jQuery('#changeAlbum').submit();
	}
	</script>
	<form name="changeAlbum" id="changeAlbum" action="<?php echo CRoute::getURI();?>" method="POST">
	<div>
		<div><strong><?php echo JText::_( 'CC SELECT PHOTO ALBUM' ); ?></strong></div>
		<select name="albumid" onchange="submitForm();" class="inputbox">
		<?php
		$selected	= ( !empty( $albumId ) ) ? 'selected="selected"' : '';
		?>
			<option value="-1"<?php echo $selected;?>><?php echo JText::_('CC SELECT ALBUM');?></option>
		<?php
		foreach($albums as $album)
		{
			if($albumId != '' && ($album->id == $albumId))
			{
		?>
			<option value="<?php echo $album->id;?>" selected="selected"><?php echo $album->name;?></option>
		<?php
			}
			else
			{
		?>
			<option value="<?php echo $album->id;?>"><?php echo $album->name;?></option>
		<?php
			}
		}
		?>
		</select>
	</div>
	</form>
	<?php
	// This section only proceeds when user selects an album
	if( !empty( $albumId ) )
	{
	?>
	<script type="text/javascript" language="javascript">
	joms.uploader.postUrl 		= '<?php echo CRoute::_('index.php?option=com_community&view=photos&task=jsonupload&no_html=1&tmpl=component&albumid=' . $albumId , false );?>';
	joms.uploader.uploadText	= '<?php echo JText::_('CC PHOTO UPLOADING');?>';
	
	jQuery(document).ready( function() {
		joms.uploader.addNewUpload();
		
	});
	</script>
	<div><strong><?php echo JText::_('CC SELECT PHOTOS'); ?></strong></div>
	<div class="clr"></div>
	<div id="photoupload-container">
		<div id="photoupload" class="upload-form">
			<a class="remove" href="javascript:void(0);"></a>
			<input class="text input" type="file" size="35" name="Filedata" id="Filedata" />
			<span>
				<input type="checkbox" name="default" value="1" /><?php echo JText::_('CC SET AS ALBUM COVER'); ?>
			</span>
			<input type="hidden" name="elementIndex" class="elementIndex" />
		</div>
	</div>
	<div class="add-new-upload">
		<a onclick="joms.uploader.addNewUpload();" href="javascript:void(0);" class="add add-upload"><?php echo JText::_('CC UPLOAD ANOTHER PHOTO' ); ?></a>
	</div>
	<div class="button-surround"><div class="readon-wrap1"><div class="readon1-l"></div><a class="readon-main"><span class="readon1-m"><span class="readon1-r"><button class="button button-upload" onclick="joms.uploader.startUpload();" id="upload-photos-button"><?php echo JText::_('CC BUTTON START UPLOAD');?></button></span></span></a></div><div class="clr"></div></div>
	<div><?php echo JText::sprintf('CC MAXIMUM UPLOAD LIMIT' , $uploadLimit ); ?></div>
	<?php
	}
	?>
<?php
}
else
{
?>
	<div>
		<span><?php echo JText::_('CC NO ALBUM'); ?></span>
		<span>
			<a href="<?php echo $createAlbumLink;?>">
			<?php echo JText::_('CC CREATE ALBUM NOW');?>
			</a>
		</span>
	</div>
<?php
}
?>