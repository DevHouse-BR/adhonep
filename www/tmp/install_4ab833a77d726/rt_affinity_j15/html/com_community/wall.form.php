<script type="text/javascript" language="javascript">

function wallRemove( id )
{
	if(confirm('<?php echo JText::_('CC CONFIRM REMOVE WALL'); ?>'))
	{		
		jQuery('#wall_'+id).fadeOut('normal').remove();
		if(typeof getCacheId == 'function') {
			cache_id = getCacheId();
		}else{
			cache_id = "";
		}	
		jax.call('community','<?php echo $ajaxRemoveFunc; ?>', id, cache_id );
	}
}

jQuery(document).ready(function()
{
	joms.utils.textAreaWidth('#wall-message');
});
</script>
<div class="button-surround"><div class="yellowbox-bl"><div class="yellowbox-br"><div class="yellowbox-tl"><div class="yellowbox-tr">
    <div class="center">
		<textarea id="wall-message" name="message" class="inputbox2"></textarea>
		<div class="readon-wrap1"><div class="readon1-l"></div><a class="readon-main"><span class="readon1-m"><span class="readon1-r"><button id="wall-submit" class="button" onclick="joms.walls.add('<?php echo $uniqueId; ?>', '<?php echo $ajaxAddFunction;?>');return false;" name="save">
		<?php echo JText::_('CC WALL ADD COMMENT');?>
		</button></span></span></a></div>

		<?php if(!empty($viewAllLink)): ?>
		<div class="show-all-link">
			<a href="<?php echo $viewAllLink; ?>">
				<?php echo JText::_('CC SHOW ALL'); ?>
			</a>
		</div>
		<?php endif; ?>
		<div class="clr"></div>
	</div>
</div></div></div></div></div>