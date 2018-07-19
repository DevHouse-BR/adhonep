<?php

// This information has been pulled out of index.php to make the template more readible.
//
// This data goes between the <head></head> tags of the template
// 
// 

/*
{
	limit: {y: false},
	radius: 16,
	ghostOpacity: 0.5
}


sortableElements
sortableGhost
sortableOpacity
sortableRadius

*/

$this->addStylesheet($this->baseurl."/templates/".$this->template."/css/template.css");
$this->addStylesheet($this->baseurl."/templates/".$this->template."/css/".$tstyle.".css");
$this->addStylesheet($this->baseurl."/templates/".$this->template."/css/typography.css");
if($thirdparty_styling=="true") :
$this->addStylesheet($this->baseurl."/templates/".$this->template."/css/extras.css");
endif;
$this->addStylesheet($this->baseurl."/templates/system/css/system.css");
$this->addStylesheet($this->baseurl."/templates/system/css/general.css");
if($mtype=="moomenu" or $mtype=="suckerfish") :
    $this->addStylesheet($this->baseurl."/templates/".$this->template."/css/rokmoomenu.css");
endif;
$inlinestyle = "
	div.wrapper { ".$template_width."padding:0;}
	#leftcol { width:".$leftcolumn_width."px;padding:0;float:left;}
	#rightcol { width:".$rightcolumn_width."px;padding:0;}
	#main-body { width:".(intval($mainbody_width)-intval($rightcolumn_width))."px;padding:0;float:left;}
	#maincol { width:".(intval($maincontent_width)-intval($leftcolumn_width)-45)."px;padding:0;float:right;}
	#inset-block-left { width:".$leftinset_width."px;padding:0;}
	#inset-block-right { width:".$rightinset_width."px;padding:0;}
	#maincontent-block { margin-right:".$rightinset_width."px;margin-left:".$leftinset_width."px;}";
$this->addStyleDeclaration($inlinestyle);
?>
<?php if (rok_isIe()) :?>
<!--[if IE 7]>
<link href="<?php echo $this->baseurl; ?>/templates/<?php echo $this->template?>/css/template_ie7.css" rel="stylesheet" type="text/css" />	
<![endif]-->	
<?php endif; ?>
<?php if (rok_isIe(6)) :?>
<!--[if lte IE 6]>
<link href="<?php echo $this->baseurl; ?>/templates/<?php echo $this->template?>/css/template_ie6.css" rel="stylesheet" type="text/css" />
<script src="<?php echo $this->baseurl; ?>/templates/<?php echo $this->template?>/js/DD_belatedPNG.js"></script>
<script type="text/javascript">
	var pngClasses = ['.png', '.roksearch_wrapper1', '.roksearch_wrapper2', '.feature-arrow-l', '.feature-arrow-r', '.feature-block-tl', '.feature-block-tr', '.feature-block-bl', '.feature-block-br', '.rokstories-tip', '.feature-block-title2', '.feature-block-title3', '.roksearch_odd', '.roksearch_even'];
	
	pngClasses.each(function(fixMePlease) {
		DD_belatedPNG.fix(fixMePlease);
	});
</script>
<![endif]-->
<?php endif; ?>
<?php 
if($enable_fontspans=="true") :
    $this->addScript($this->baseurl."/templates/".$this->template."/js/rokfonts.js");
    $rokfonts = 
    "window.addEvent('domready', function() {
		var modules = ['side-mod','module','moduletable'];
		var header = ['h3'];
		RokBuildSpans(modules, header);
	});";
    $this->addScriptDeclaration($rokfonts);
endif;
if(rok_isIe(6) and $enable_ie6warn=="true" and $js_compatibility=="false") : 
    $this->addScript($this->baseurl."/templates/".$this->template."/js/rokie6warn.js");
endif;
if($clientside_date == "true" and $js_compatibility=="false") :
    $this->addScript($this->baseurl."/templates/".$this->template."/js/rokdate.js");
endif; 
$this->addScript($this->baseurl."/templates/".$this->template."/js/rokutils.js");
if($enable_inputstyle == "true" and $js_compatibility=="false") :
    $this->addScript($this->baseurl."/templates/".$this->template."/js/rokutils.inputs.js");
	$exclusionList = "InputsExclusion.push($inputs_exclusion)";
	$this->addScriptDeclaration($exclusionList);
endif;

// Sortables
if (($sortables=="true" || $sortables_ver=="true" || $sortables_modules=="true") && $js_compatibility=="false") {
	$this->addScript($this->baseurl."/templates/".$this->template."/js/roksortable.js");
	$this->addScriptDeclaration("var AffinitySettings = {};");
}

if ($sortables=="true" and $js_compatibility=="false") :
	$this->addScriptDeclaration("AffinitySettings.horizontal = {ghost: $sortables_ghost, ghostOpacity: $sortables_opacity, radius: $sortables_radius};");
endif;

if ($sortables_ver=="true" and $js_compatibility=="false") :
	$this->addScriptDeclaration("AffinitySettings.vertical = {ghost: $sortables_ghost_ver, ghostOpacity: $sortables_opacity_ver, radius: $sortables_radius_ver};");
endif;

if ($sortables_modules=="true" and $js_compatibility=="false") :
	$this->addScriptDeclaration("AffinitySettings.modules = {ghost: $sortables_ghost_modules, ghostOpacity: $sortables_opacity_modules, radius: $sortables_radius_modules};");
endif;


if($mtype=="moomenu" and $js_compatibility=="false") :
    $this->addScript($this->baseurl."/templates/".$this->template."/js/rokmoomenu.js");
    $this->addScript($this->baseurl."/templates/".$this->template."/js/mootools.bgiframe.js");
    $mooinit =
    "window.addEvent('domready', function() {
    	new Rokmoomenu(".'$E'."('ul.menutop '), {
    		bgiframe: ".$moo_bgiframe.",
    		delay: ".$moo_delay.",
    		verhor: true,
    		animate: {
    			props: ['height'],
    			opts: {
    				duration: ".$moo_duration.",
    				fps: ".$moo_fps.",
    				transition: Fx.Transitions.".$moo_transition."
    			}
    		},
    		bg: {
    			enabled: ".$moo_bg_enabled.",
    			overEffect: {
    				duration: ".$moo_bg_over_duration.",
    				transition: Fx.Transitions.".$moo_bg_over_transition."
    			},
    			outEffect: {
    				duration: ".$moo_bg_out_duration.",
    				transition: Fx.Transitions.".$moo_bg_out_transition."
    			}
    		},
    		submenus: {
    			enabled: ".$moo_sub_enabled.",
    			opacity: ".$moo_sub_opacity.",
    			overEffect: {
    				duration: ".$moo_sub_over_duration.",
    				transition: Fx.Transitions.".$moo_sub_over_transition."
    			},
    			outEffect: {
    				duration: ".$moo_sub_out_duration.",
    				transition: Fx.Transitions.".$moo_sub_out_transition."
    			},
    			offsets: {
    				top: ".$moo_sub_offsets_top.",
    				right: ".$moo_sub_offsets_right.",
    				bottom: ".$moo_sub_offsets_bottom.",
    				left: ".$moo_sub_offsets_left."
    			}
    		}
    	});
    });";
    $this->addScriptDeclaration($mooinit);
endif;
if((rok_isIe(6) or rok_isIe(7)) and ($mtype=="suckerfish" or $mtype=="splitmenu")) :
    $this->addScript($this->baseurl."/templates/".$this->template."/js/ie_suckerfish.js");

endif; ?>