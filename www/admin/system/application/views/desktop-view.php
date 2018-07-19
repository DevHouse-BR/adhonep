<?php
$url = base_url();
?>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title id="title">Administra&ccedil;&atilde;o Sistema ADHONEP</title>
        <style type="text/css">
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
    <body  scroll="no">
   		<img src="<?=$background?>" width="100%" height="100%" style="position:fixed !important;top:0;left:0;z-index:0;" />
   		<div id="loading-mask" style=""></div>
		<div id="loading">
		    <div class="loading-indicator">
		    	<img src="images/ajax-loader.gif" width="42" height="42" style="margin-right:8px;float:left;vertical-align:top;"/>Adhonep RC 1.0<br /><span id="loading-msg">Carregando Estilos e Imagens...</span>
			</div>
		</div>
		
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Estilos Core...';</script>
		<link rel="stylesheet" type="text/css" href="<?=$url?>extjs/resources/css/ext-all.css" />

		<!--<link rel="stylesheet" type="text/css" href="<?=$url?>extjs/resources/css/xtheme-gray-extend.css" />-->
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Estilos do Sistema...';</script>
        <link rel="stylesheet" type="text/css" href="<?=$url?>css/desktop.css" />
		<link rel="stylesheet" type="text/css" href="<?=$url?>css/DevHouse.css" />
		<link rel="stylesheet" type="text/css" href="<?=$url?>css/Adhonep.css" />
        <script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Core Base do Sistema...';</script>
   		<script type="text/javascript" src="<?=$url?>extjs/adapter/ext/ext-base.js"></script>
   		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Core do Sistema...';</script>
        <script type="text/javascript" src="<?=$url?>extjs/ext-all.js"></script>
		
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Google Maps...';</script>
		<!--<script src="http://maps.google.com/maps?file=api&amp;v=2.x&amp;key=ABQIAAAA2CKu_qQN-JHtlfQ5L7BLlRT2yXp_ZAY8_ufC3CFXhHIE1NvwkxQl3I3p2yrGARYK4f4bkjp9NHpm5w" type="text/javascript"></script>-->
        <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=ABQIAAAAzT9OYEniEH3QVaXmY7GllRRA-sGEayBHcnAQBy11V2yWRQ2thBTL42v3QEEOcneZ4-g1IO8VKl5vjw" type="text/javascript"></script>
		
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Idiomas...';</script>
    	<script type="text/javascript" src="<?=$url?>js/pt-BR-EXTJS.js"></script>
		<script type="text/javascript" src="<?=$url?>js/pt-BR.js"></script>
        <script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Helpers...';</script>
        <script type="text/javascript" src="<?=$url?>js/DesktopHelpers.js"></script>
		<script type="text/javascript" src="<?=$url?>js/HttpHelpers.js"></script>
        <script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Menu Iniciar...';</script>
        <script type="text/javascript" src="<?=$url?>js/StartMenu.js"></script>
        <script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Barra de Tarefas...';</script>
    	<script type="text/javascript" src="<?=$url?>js/TaskBar.js"></script>
    	<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Desktop...';</script>
    	<script type="text/javascript" src="<?=$url?>js/Desktop.js"></script>
    	<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Aplicativo...';</script>
    	<script type="text/javascript" src="<?=$url?>js/App.js"></script>
    	<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Core Módulos...';</script>
    	<script type="text/javascript" src="<?=$url?>js/Module.js"></script>
    	<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Extensões...';</script>
		<script type="text/javascript" src="<?=$url?>js/extensoes.js"></script>
		<script type="text/javascript" src="<?=$url?>js/ClassesBase.js"></script>
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Access Control...';</script>
        <script type="text/javascript" src="<?=$url?>js/AccessController.js"></script>
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Gerenciador de Imagens...';</script>
		<script type="text/javascript" src="image_manager/js/mcimagemanager.js"></script>
    	<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Init Desktop...';</script>
    	<script type="text/javascript" src="<?=$url?>js/initDesktop.js"></script>
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Stores...';</script>
    	<script type="text/javascript" src="<?=$url?>js/Stores.js"></script>
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Pessoas...';</script>
    	<script type="text/javascript" src="<?=$url?>js/GridPessoas.js"></script>
		<script type="text/javascript" src="<?=$url?>js/ModuloGridPessoas.js"></script>
		<script type="text/javascript" src="<?=$url?>js/FormPessoas.js"></script>
		<script type="text/javascript" src="<?=$url?>js/ModuloFormPessoas.js"></script>
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Cidades...';</script>
    	<script type="text/javascript" src="<?=$url?>js/cidades.js"></script>
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Locais...';</script>
    	<script type="text/javascript" src="<?=$url?>js/locais.js"></script>-->
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Atributos Pessoais...';</script>
    	<script type="text/javascript" src="<?=$url?>js/atributospessoais.js"></script>
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Downloads...';</script>
    	<script type="text/javascript" src="<?=$url?>js/downloads.js"></script>
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Idéias...';</script>
    	<script type="text/javascript" src="<?=$url?>js/ideias.js"></script>
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Carregando Agenda...';</script>
    	<script type="text/javascript" src="<?=$url?>js/agenda.js"></script>
		<script type="text/javascript" src="<?=$url?>js/teste.js"></script>
   		
   		
   		<div style="width:100%; height:100%;z-index:10; position:absolute;left:0px;top:0px;">
			<div id="x-desktop">			
				<dl id="x-shortcuts">
					<dt id="id-modulo-grid-pessoas-shortcut">
						<a href="#"><img src="<?=$url?>images/s.gif" />
						<div>Pessoas</div></a>
					</dt>
					<dt id="cidades-win-shortcut">
						<a href="#"><img src="<?=$url?>images/s.gif" />
						<div>Cidades</div></a>
					</dt>
					<dt id="locais-win-shortcut">
						<a href="#"><img src="<?=$url?>images/s.gif" />
						<div>Locais</div></a>
					</dt>
					<dt id="atributospessoais-win-shortcut">
						<a href="#"><img src="<?=$url?>images/s.gif" />
						<div>Atributos Pessoais</div></a>
					</dt>
					<dt id="downloads-win-shortcut">
						<a href="#"><img src="<?=$url?>images/s.gif" />
						<div>Downloads</div></a>
					</dt>
					<dt id="ideias-win-shortcut">
						<a href="#"><img src="<?=$url?>images/s.gif" />
						<div>Idéias</div></a>
					</dt>
					<dt id="agenda-win-shortcut">
						<a href="#"><img src="<?=$url?>images/s.gif" />
						<div>Agenda</div></a>
					</dt>
				</dl>
				<dl id="x-shortcuts2" style="position:absolute; left:76;top:0px;">
					<!--<dt id="id-modulo-grid-teste-shortcut">
						<a href="#"><img src="<?=$url?>images/s.gif" />
						<div>Teste</div></a>
					</dt>-->
				</dl>
			</div>
			

			<div id="ux-taskbar">
				<div id="ux-taskbar-start"></div>
				<div id="ux-taskbuttons-panel"></div>
				<div class="x-clear"></div>
			</div>
		</div>
    </body>
</html>