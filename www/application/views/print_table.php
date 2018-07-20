<?php
$url = base_url();
?>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title id="title">Sistema ADHONEP - Impressão</title>
        <style type="text/css" media="all">
        	body{
        		font-family:Arial, Helvetica, sans-serif;
        	}
			.tabela{
				border: solid 1px gray;
			}
        	.cabecalho{
        		background-color:#b5c0f0;
				color:#f4f7fd;
        	}
			.sobre{
				background-color: #dfefff;
			}
			.normal{
				background: #f4f7fd;
			}
			.alt{
				background-color: #eef0fd;
			}
			#imprimir{
				border: solid 3px gray;
				background-color:#dfefff;
				padding:10px;
				margin-bottom:10px;
			}	
        </style>
		<style type="text/css" media="print">
			#imprimir{
				display:none;
			}		
        </style>
    </head>
    <body>
    	<div id="imprimir">
    		<input type="button" value="Imprimir" onclick="window.print();" />
			<input type="button" value="Fechar" onclick="window.close();" style="float:right;"/>
    	</div>
   		<?=$tabela?>
    </body>
</html>