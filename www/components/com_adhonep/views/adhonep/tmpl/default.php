<?php defined('_JEXEC') or die('Restricted access'); 

$scriptsUrl = JURI::base().'admin/js/';

JHTML::stylesheet('ext-all.css',  'admin/extjs/resources/css/');
JHTML::stylesheet('DevHouse.css',  'admin/css/');
JHTML::stylesheet('Adhonep.css',  'admin/css/');

JHTML::script('ext-base.js',  'admin/extjs/adapter/ext/');
JHTML::script('ext-all-debug.js',  'admin/extjs/');

JHTML::script('pt-BR-EXTJS.js',  $scriptsUrl);
JHTML::script('pt-BR.js',  $scriptsUrl);
JHTML::script('DesktopHelpers.js',  $scriptsUrl);
JHTML::script('HttpHelpers.js',  $scriptsUrl);


JHTML::script('extensoes.js',  $scriptsUrl);
JHTML::script('ClassesBase.js',  $scriptsUrl);
JHTML::script('AccessController.js',  $scriptsUrl);
JHTML::script('Stores.js',  $scriptsUrl);
JHTML::script('GridPessoas.js',  $scriptsUrl);
JHTML::script('FormPessoas.js',  $scriptsUrl);

?>
<script language="JavaScript" type="text/javascript">
	var FormPessoasWindow;
	var gridPessoas;
	
	DevHouseDesktop.Stores.storeAtributosPessoais.proxy.setUrl("admin/atributospessoais/atributospessoaisCheckBoxGroup", true);
	DevHouseDesktop.Stores.storeAtributosPessoais.reload();
	
	DevHouseDesktop.Stores.storePermissoes.proxy.setUrl("admin/permissoes/permissoesCheckBoxGroup", true);
	DevHouseDesktop.Stores.storePermissoes.reload();
	
	AccessController.setUrl('admin/pessoas/accessControl', true);
	AccessController.init();
	
	function createFormWindow(options){
		if(options){
			var opcoes = {};
			var urlToLoad = DevHouseDesktop.FormPessoas.formPessoasConfig.formConfig.loadUrl;
			if(typeof options.carregaRegistro != 'undefined'){
				opcoes.carregaRegistro = true;
				opcoes.loadUrl = DevHouseDesktop.FormPessoas.formPessoasConfig.formConfig.loadUrl + options.id;
			}
			if(typeof options.storeToReload != 'undefined'){
				opcoes.storeToReload = options.storeToReload;
			}
			Ext.apply(DevHouseDesktop.FormPessoas.formPessoasConfig.formConfig,opcoes);
			var form = new ClassesBase.Forms.FormPanelBasico(DevHouseDesktop.FormPessoas.formPessoasConfig);
			Ext.apply(DevHouseDesktop.FormPessoas.formPessoasConfig.formConfig,{
				carregaRegistro:false,
				loadUrl: urlToLoad,
				storeToReload:null
			});
		}
		if(!form) var form = new ClassesBase.Forms.FormPanelBasico(DevHouseDesktop.FormPessoas.formPessoasConfig);
		FormPessoasWindow = new Ext.Window({
			id: 'id-window-form-pessoas',
			title: Ext.names.FormPessoasTitle,
			iconCls: 'pessoas',
			width: 610,
        	height: 550,
			plain:true,
			layout: 'fit',
			items: form
		});
		FormPessoasWindow.show();
	}

	Ext.onReady(function(){
    	Ext.QuickTips.init();
		
		Ext.apply(DevHouseDesktop.FormPessoas.formPessoasConfig.formConfig, {
			loadUrl: 'admin/pessoas/getPessoa/',
			url: 'admin/pessoas/salvaPessoa'
		});
		
		Ext.apply(DevHouseDesktop.GridPessoas.gridPessoasConfig.columnModelConfig[0], {
			renderer: function(data, cell, record, rowIndex, columnIndex, store) {
				return '<img style="cursor:pointer" src="admin/images/user_edit.png" ext:qtitle="' + Ext.names.Editar + '" ext:qwidth="150" ext:qtip="' + Ext.names.EditarTip +'" />';
			}
		});
		Ext.apply(DevHouseDesktop.GridPessoas.gridPessoasConfig.columnModelConfig[1], {
			renderer: function(data, cell, record, rowIndex, columnIndex, store) {			
				return '<div style="cursor:pointer" id="id-pessoas-desc-tip-' + rowIndex + '"><img src="admin/images/user_comment.png" align="left" />&nbsp;' + data + '</div>';
			}
		});
		Ext.apply(DevHouseDesktop.GridPessoas.gridPessoasConfig.columnModelConfig[5], {
			renderer: function(data, cell, record, rowIndex, columnIndex, store) {
				return record.data.cidade;
			}
		});
		Ext.apply(DevHouseDesktop.GridPessoas.gridPessoasConfig.tbarConfig[0], {
			handler: function(botao, evento) {
				var grid = Ext.getCmp('id-grid-pessoas');
				createFormWindow({storeToReload:grid.store});
			}
		});
		Ext.apply(DevHouseDesktop.GridPessoas.gridPessoasConfig.tbarConfig[3], {
			handler: function(){
				window.open('admin/pessoas/pessoasGridPrint');
			}
		});
		Ext.apply(DevHouseDesktop.GridPessoas.gridPessoasConfig.gridConfig, {
			renderTo:'conteudo-extjs',
			getUrl:'admin/pessoas/pessoasGrid',
			putUrl: 'admin/pessoas/salvaPessoaGrid',
			deleteUrl: 'admin/pessoas/removePessoas',
			height:500
		});
		Ext.apply(DevHouseDesktop.GridPessoas.gridPessoasConfig.gridConfig.listeners, {
			cellclick: function(grid, rowIndex, columnIndex, evento){
			    if(columnIndex == 0){
					var record = grid.getStore().getAt(rowIndex);
					createFormWindow({carregaRegistro:true, id:record.data[record.fields.keys[0]], storeToReload:grid.getStore()});
				}
			}
		});
		var task = new Ext.util.DelayedTask(function(){
		    gridPessoas = new ClassesBase.Grids.GridEditorBasico(DevHouseDesktop.GridPessoas.gridPessoasConfig);
		});
		task.delay(1000);
	});
</script>
<div id="conteudo-extjs"></div>