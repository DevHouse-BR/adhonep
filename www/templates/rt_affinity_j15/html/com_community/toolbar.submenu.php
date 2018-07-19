<?php
/**
 * @category 	Template
 * @package		JomSocial
 * @subpackage	Core 
 * @copyright (C) 2008 by Slashes & Dots Sdn Bhd - All rights reserved!
 * @license http://www.azrul.com Copyrighted Commercial Software
 */
?>
<script type="text/javascript">
jQuery(document).ready( function() {
	jQuery('#community-wrap ul.submenu li a:last').css('border-right', '0');
});
</script>
<div class="submenu-surround">
	<div class="yellowbox-bl"><div class="yellowbox-br"><div class="yellowbox-tl"><div class="yellowbox-tr">
	    <div class="center">
			<div class="cSubmenu submenu-l">
			    <div class="submenu-r">
					<ul class="submenu">
					<?php
					foreach($submenu as $menu)
					{
						$action		= (isset($menu->action) && ($menu->action) ) ? ' style="float: right;"' : '';
						$active		= '';
			
						if( isset( $menu->onclick ) && !empty( $menu->onclick) )
						{
							$link	= 'href="javascript:void(0);" onclick="' . $menu->onclick . '"';
						}
						else
						{
							$active		= ( JString::strtolower( $menu->view ) == JString::strtolower($view) && JString::strtolower( $menu->task ) == JString::strtolower($task) ) ? ' class="active"' : '';
							$link		= 'href="' . CRoute::_( $menu->link ) . '"';
						}
					?>
						<li<?php echo $action;?>>
							<a <?php echo $link;?><?php echo $active;?>><?php echo $menu->title;?></a>
						</li>
					<?php
					}
					?>
					</ul>
				</div>
			</div>
		</div>
	</div></div></div></div>
</div>