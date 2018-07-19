<?php
$url = base_url();
?>
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br" xml:lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title id="title">Administração Sistema ADHONEP</title>
		<style type="text/css">
			.chave{
				 background-image:url(images/key.png) !important;
			}
			.cadeado{
				 background-image:url(images/lock.png) !important;
			}
			#loading-mask{
		        position:absolute;
		        left:0;
		        top:0;
		        width:100%;
		        height:100%;
		        z-index:20000;
		        background-color:white;
		    }
		    #loading{
		        position:absolute;
		        left:45%;
		        top:40%;
		        padding:2px;
		        z-index:20001;
		        height:auto;
		    }
		    #loading a {
		        color:#225588;
		    }
		    #loading .loading-indicator{
		        background:white;
		        color:#444;
		        font:bold 13px tahoma,arial,helvetica;
		        padding:10px;
		        margin:0;
		        height:auto;
				width:220px;
		    }
		    #loading-msg {
		        font: normal 10px arial,tahoma,sans-serif;
		    }
		</style>
    </head>
    <body>
    <img id="background" src="<?=$url?>../wallpapers/<?=$background?>" width="100%" height="100%" style="position:fixed !important;top:0;left:0;" />
    <div id="loading-mask" style=""></div>
		<div id="loading">
		    <div class="loading-indicator">
		    	<img src="images/ajax-loader.gif" width="42" height="42" style="margin-right:8px;float:left;vertical-align:top;"/>Adhonep RC 1.0<br /><span id="loading-msg">Carregando Estilos e Imagens...</span>
			</div>
		</div>
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Estilos Core...';</script>
		<link rel="stylesheet" type="text/css" href="<?=$url?>extjs/resources/css/ext-all.css" />
		<!--<link rel="stylesheet" type="text/css" href="<?=$url?>extjs/resources/css/xtheme-gray-extend.css" />-->
		<link rel="stylesheet" type="text/css" href="<?=$url?>css/desktop.css" />
        <script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Core Base do Sistema...';</script>
   		<script type="text/javascript" src="<?=$url?>extjs/adapter/ext/ext-base.js"></script>
   		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Core do Sistema...';</script>
        <script type="text/javascript" src="<?=$url?>extjs/ext-all.js"></script>
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Idiomas...';</script>
    	<script type="text/javascript" src="<?=$url?>js/pt-BR-EXTJS.js"></script>
		<script type="text/javascript" src="<?=$url?>js/pt-BR.js"></script>
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Helpers...';</script>
        <script type="text/javascript" src="<?=$url?>js/DesktopHelpers.js"></script>
		<script type="text/javascript" src="<?=$url?>js/HttpHelpers.js"></script>
		<script type="text/javascript" src="<?=$url?>js/extensoes.js"></script>
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Login...';</script>
        <script type="text/javascript" src="<?=$url?>js/login.js"></script>
		
    </body>
</html>