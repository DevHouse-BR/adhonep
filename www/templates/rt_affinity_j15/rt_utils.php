<?php
defined( '_JEXEC' ) or die( 'Restricted index access' );

jimport('joomla.filesystem.file');

global $Itemid, $modules_list, $mainmodulesBlocks, $template_real_width, $leftcolumn_width, $rightcolumn_width, $menu_rows_per_column, $menu_columns, $menu_multicollevel, $mainmod2_width, $mainmod3_width, $active, $subnav;

if ($mtype!="module") :
	// menu code
	$document	= &JFactory::getDocument();
	$renderer	= $document->loadRenderer( 'module' );
	$options	 = array( 'style' => "raw" );
	$module	 = JModuleHelper::getModule( 'mod_roknavmenu' );
	$topnav = false; $subnav = false;
	
	// Get the params for the menu type and render the main menu
	$menu_params_file = JPATH_ROOT.DS.'templates'.DS.$this->template.DS."menus".DS.$mtype.".ini";
	if (JFile::exists($menu_params_file)) :
		$menu_params_content = file_get_contents($menu_params_file);
		eval("\$module->params = \"$menu_params_content\";");
	endif;
	$topnav = $renderer->render( $module, $options );
	
	// See if this is a splitmenu and render the subnav 
	if ($mtype=="splitmenu") :		
		$module	 = JModuleHelper::getModule( 'mod_roknavmenu' );
		$menu_params_file = JPATH_ROOT.DS.'templates'.DS.$this->template.DS."menus".DS.$mtype."_subnav.ini";
		if (JFile::exists($menu_params_file)) :
			$menu_params_content = file_get_contents($menu_params_file);
			eval("\$module->params = \"$menu_params_content\";");
		endif;
		$options = array( 'style' => "submenu");
		$subnav = $renderer->render( $module, $options );
	endif;

endif;

// make sure subnav is empty
if (strlen($subnav) < 10) $subnav = false;
//Are we in edit mode
$editmode = false;
if (JRequest::getCmd('task') == 'edit' ) :
	$editmode = true;
endif;

$mainmodulesBlocks = array(
	'case1' => array('showcase', 'showcase2', 'showcase3'),
	'case2' => array('user1', 'user2', 'user3'),
	'case3' => array('main1', 'main2', 'main3'),
	'case4' => array('main4', 'main5', 'main6'),
	'case5' => array('user4', 'user5', 'user6'),
	'case6' => array('user7', 'user8', 'user9'),
	'case7' => array('bottom', 'bottom2', 'bottom3')
);

$menu = &JSite::getMenu();
$active = $menu->getActive();

$showmod_count = ($this->countModules('showcase')>0) + ($this->countModules('showcase2')>0) + ($this->countModules('showcase3')>0);
$showmod_width = $showmod_count > 0 ? ' w' . floor(99 / $showmod_count) : '';
$mainmod_count = ($this->countModules('user1')>0) + ($this->countModules('user2')>0) + ($this->countModules('user3')>0);
$mainmod_width = $mainmod_count > 0 ? ' w' . floor(99 / $mainmod_count) : '';
$mainmod2_count = ($this->countModules('main1')>0) + ($this->countModules('main2')>0) + ($this->countModules('main3')>0);
$mainmod2_width = $mainmod2_count > 0 ? ' w' . floor(99 / $mainmod2_count) : '';
$mainmod3_count = ($this->countModules('main4')>0) + ($this->countModules('main5')>0) + ($this->countModules('main6')>0);
$mainmod3_width = $mainmod3_count > 0 ? ' w' . floor(99 / $mainmod3_count) : '';
$mainmod4_count = ($this->countModules('user4')>0) + ($this->countModules('user5')>0) + ($this->countModules('user6')>0);
$mainmod4_width = $mainmod4_count > 0 ? ' w' . floor(99 / $mainmod4_count) : '';
$mainmod5_count = ($this->countModules('user7')>0) + ($this->countModules('user8')>0) + ($this->countModules('user9')>0);
$mainmod5_width = $mainmod5_count > 0 ? ' w' . floor(99 / $mainmod5_count) : '';
$bottommod_count = ($this->countModules('bottom')>0) + ($this->countModules('bottom2')>0) + ($this->countModules('bottom3')>0);
$bottommod_width = $bottommod_count > 0 ? ' w' . floor(99 / $bottommod_count) : '';

$leftcolumn_width = ((!$active and $this->countModules('inactive')) or $this->countModules('left')>0 or $this->countModules('search-left')>0 or ($subnav and $splitmenu_col=="leftcol")) ? $leftcolumn_width : 0;
$rightcolumn_width = (!$editmode and ($this->countModules('right')>0 or $this->countModules('search-right')>0 or ($subnav and $splitmenu_col=="rightcol"))) ? $rightcolumn_width : 0;

function body_surround(&$document, $content) {
	$start = "<div class=\"body-surround-top\"><div class=\"body-surround-top2\"><div class=\"body-surround-top3\"></div></div></div>
	<div class=\"body-surround\"><div class=\"body-surround2\"><div class=\"body-surround3\">";
	$end = "</div></div></div><div class=\"body-surround-bottom\"><div class=\"body-surround-bottom2\"><div class=\"body-surround-bottom3\"></div></div></div>";
	
	return $start.$content.$end;
}

function body_surround_start(&$document) {
	echo "<div class=\"body-surround-top\"><div class=\"body-surround-top2\"><div class=\"body-surround-top3\"></div></div></div>
	<div class=\"body-surround\"><div class=\"body-surround2\"><div class=\"body-surround3\">";
}

function body_surround_end(&$document) {
	echo "</div></div></div><div class=\"body-surround-bottom\"><div class=\"body-surround-bottom2\"><div class=\"body-surround-bottom3\"></div></div></div>";
}

$mainbody_width = $template_width-20;
$maincontent_width = $mainbody_width-$rightcolumn_width;

$leftinset_width = ($this->countModules('inset')>0 and !$editmode) ? $leftinset_width : "0";
$rightinset_width = ($this->countModules('inset2')>0 and !$editmode) ? $rightinset_width : "0";
$template_real_width = $template_width;
/* IE6 Template_width Fix */
if (rok_isIe(6)) {}
/* end */
$template_width = 'margin: 0 auto; width: ' . $template_width . 'px;';
$template_path = $this->baseurl . "/templates/" . $this->template;
$fullpath = 'http://'.JRequest::getVar('SERVER_NAME','','SERVER','STRING').$_SERVER['REQUEST_URI'];
$user =& JFactory::getUser();


									
function rok_isIe($version = false) {   

	$agent=$_SERVER['HTTP_USER_AGENT'];  

	$found = strpos($agent,'MSIE ');  
	if ($found) { 
	        if ($version) {
	            $ieversion = substr(substr($agent,$found+5),0,1);   
	            if ($ieversion == $version) return true;
	            else return false;
	        } else {
	            return true;
	        }
	        
        } else {
                return false;
        }
	if (stristr($agent, 'msie'.$ieversion)) return true;
	return false;        
}

function modulesClasses($case, $loaded_only = false, $extra = false) {
  global $mainmodulesBlocks;
  $document	= &JFactory::getDocument();

  $modules = $mainmodulesBlocks[$case];
  $loaded = 0;
  $loadedModule = array();
  $classes = array();

  foreach($mainmodulesBlocks[$case] as $block) if ($document->countModules($block)>0) { $loaded++; array_push($loadedModule, $block); }
  if ($loaded_only) return $loaded;

  $width = getModuleWidth($case, $loaded, $extra);
  switch ($loaded) {
    case 1:
      $classes[$loadedModule[0]][0] = 'full';
      $classes[$loadedModule[0]][1] = $width[0];
      break;
    case 2: 
      for ($i = 0; $i < count($loadedModule); $i++){
        if (!$i) {
		$classes[$loadedModule[$i]][0] = 'first';
		$classes[$loadedModule[$i]][1] = $width[0];
	}
        else {
		$classes[$loadedModule[$i]][0] = 'last';
		$classes[$loadedModule[$i]][1] = $width[1];
	}
      }
      break;
    case 3:
      for ($i = 0; $i < count($loadedModule); $i++){
        if (!$i) {
		$classes[$loadedModule[$i]][0] = 'first';
		$classes[$loadedModule[$i]][1] = $width[0];
	}
        elseif ($i == 1) {
		$classes[$loadedModule[$i]][0] = 'middle';
		$classes[$loadedModule[$i]][1] = $width[1];
	}
        else {
		$classes[$loadedModule[$i]][0] = 'last';
		$classes[$loadedModule[$i]][1] = $width[2];
	}
      }
      break;
  }
  
  return $classes;
  
}

function getModuleWidth($type, $loaded, $extra = false) {
	global $template_real_width;
	$width = $template_real_width - 30 - 10;
	if (strlen($extra) > 0) $width += 10;
	$ieFix = 0;
	$result = array();
	
	$width_original = $width;

	switch ($loaded) {
		case 1:
			$result[0] = $width_original + 10;
			if (!$extra) $result[0] += 10;
			break;
		case 2:
			$width = floor($width / 2);
			$result[0] = $width;
			$result[1] = $width_original - $result[0];
			if (!$extra) {
				$result[0] += 5;
				$result[1] += 5;
			}
 			break;
		case 3:
			$width = floor($width / 3);
			$result[0] = $result[1] = $width;
			$result[2] = $width_original - ($result[0] + $result[1]);
			if ($extra != false) {
				$result[0] -= 5;
				$result[2] -= 5;
			}
			break;
	}
	
	return $result;
}

function getMainWidth(){
	$mainWidth = getModuleWidth(false, 1);
	$result = $mainWidth[0];
	
	return $result;
}

?>