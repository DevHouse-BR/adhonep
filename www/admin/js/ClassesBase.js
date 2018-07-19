/**
 * @author Leonardo
 */
Ext.namespace("ClassesBase.Grids");

ClassesBase.Grids.GridEditorBasico = function(config){
	
	this.proxyConfig = {
		url: config.gridConfig.getUrl,
		method: 'POST'
    }
	Ext.apply(this.proxyConfig, config.proxyConfig);
	
	this.readerConfig = {
		root: 'rows',
		totalProperty: 'results'
    }
	Ext.apply(this.readerConfig, config.readerConfig);
	
	this.storeConfig = {
		autoLoad: true,
		remoteSort: true,
		proxy: new Ext.data.HttpProxy(this.proxyConfig),
		baseParams:{
			start: 0,          
		    limit: 30
		},
		listeners: {
			exception: HttpHelpers.failHandler
		},
		reader: new Ext.data.JsonReader(this.readerConfig, config.readerFields)
	}
	Ext.ux.util.mapObj(this.storeConfig, config.storeConfig);
	this.dataStore = new Ext.data.Store(this.storeConfig);
	
	
	this.tbarConfig = [{
			text: Ext.names.Incluir,
			tooltip: Ext.names.IncluirTip,
			iconCls:'add',
			handler:function(botao, evento){
				var module = DevHouseDesktop.getModule(config.gridConfig.formModule);
				var window = DevHouseDesktop.desktop.getWindow(config.gridConfig.formModuleWindow);
				var opcoes = {carregaRegistro:false};
				if(module){
					if(window){
						window.close();
					}
					if(this.grid){
						var grid = Ext.getCmp(this.grid);
						opcoes.storeToReload = grid.store;
					}
					module.createWindow(opcoes);
				}
			}
		},{
			text: Ext.names.Excluir,
			tooltip: Ext.names.ExcluirTip,
			iconCls:'remove',
		   	scope : this,
			handler : HttpHelpers.excluirRegistro.createDelegate(this, [{grid: config.gridConfig.id, url: config.gridConfig.deleteUrl, campoid:config.readerFields[0].name}], true)
		},
		'-',
		Ext.names.Pesquisar,
		{
			xtype: 'searchfield',
	        width:240,
			id:'buscafield',
			hideMode: 'offsets',
			store: this.dataStore,
			paramName: 'query'		
		},
		'->',
		{
			text: Ext.names.Imprimir,
			tooltip: Ext.names.ImprimirTip,
			iconCls: 'print'
	}];
	if(config.tbarConfig) this.tbarConfig = Ext.ux.util.mapObjWOrder(this.tbarConfig, config.tbarConfig);
	
	this.bbarConfig = {
		store: this.dataStore,
		displayInfo: true,
		pageSize: 30,
		animate: true,
		plugins: new Ext.ux.plugins.ProgressPagingToolbar()
	}
	if(config.bbarConfig) Ext.apply(this.bbarConfig, config.bbarConfig);

	this.gridColumnModel = new Ext.grid.ColumnModel(config.columnModelConfig);
	
	
	this.gridConfig = {
		store: this.dataStore,
		cm: this.gridColumnModel,
		stripeRows:true,
		loadMask: true,
		clicksToEdit:2,
		selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
		viewConfig: {
			autoFill: true,
		    forceFit:true
		},
		listeners:{
			cellclick:function(grid, rowIndex, columnIndex, evento){
			    if(columnIndex == 0){
					var module = DevHouseDesktop.getModule(config.gridConfig.formModule);
					var window = DevHouseDesktop.desktop.getWindow(config.gridConfig.formModuleWindow);
					var record = grid.getStore().getAt(rowIndex);
					if(module){
						if(window){
							window.close();
						}
						module.createWindow({carregaRegistro:true, id:record.data[record.fields.keys[0]], storeToReload:grid.getStore()});
					}
				}
			},
			afteredit: function (evento){
				var parametros = new Object();
				parametros[evento.record.fields.keys[0]] = evento.record.data[evento.record.fields.keys[0]];
				parametros[evento.field] = evento.value;
				HttpHelpers.salvaGrid({
					url: config.gridConfig.putUrl,
					params: parametros
				}, evento.grid.store);
			}
		},
		tbar: this.tbarConfig,
		bbar: new Ext.PagingToolbar(this.bbarConfig)
	}
	Ext.ux.util.mapObj(this.gridConfig, config.gridConfig);
	
	return new Ext.grid.EditorGridPanel(this.gridConfig);
}


Ext.namespace("ClassesBase.Forms");
ClassesBase.Forms.FormPanelBasico = function(config){

	this.buttonsConfig = [{
		text: Ext.names.Salvar,
		iconCls:'salvar',
		formBind: true,
		handler: function(botao, evento){
			var form = Ext.getCmp(config.formConfig.id);
			form.getForm().submit({
				waitMsg: Ext.names.Aguarde,
				method:'POST', 
				reset:true,
				success:function(){
					var form = Ext.getCmp(config.formConfig.id);
					var window = Ext.getCmp(form.windowId);
					var fechajanela = Ext.getCmp(config.formConfig.id + '-fechajanela');
					
					if (fechajanela.checked) 
						window.close();
					else {
						form.getForm().clear();
						form.getForm().reset();
					}
					if(typeof DevHouseDesktop.desktop != "undefined") DesktopHelpers.showNotification({title:Ext.names.Concluido,iconCls:'alerta',html: Ext.names.SaveSuccess});
					if(form.storeToReload) form.storeToReload.reload();
				}, 
				failure: HttpHelpers.failHandler
			});
		}
	},{
		text: Ext.names.Cancelar,
		iconCls:'cancelar',
		handler: function(botao, evento){
			var fechajanela = Ext.getCmp(config.formConfig.id + '-fechajanela');
			var form = Ext.getCmp(config.formConfig.id);
			var window = Ext.getCmp(form.windowId);
			if(fechajanela.checked)	window.close(); 
			else form.getForm().reset();
		}
	},{
		xtype: 'label',
		text:Ext.names.FechaJanela
	},{
		xtype: 'checkbox',
		id: config.formConfig.id + '-fechajanela',
		checked: true,
		name: 'fechajanela'
	}];		
	if(config.buttonsConfig) this.buttonsConfig = Ext.ux.util.mapObjWOrder(this.buttonsConfig, config.buttonsConfig);
	
	this.formConfig = {
		labelAlign: 'top',
		url: 'url/urlPadrao.html',
		bodyStyle:'padding:0px',
		layout:'fit',
		monitorValid:true,
		trackResetOnLoad :true,
		frame:true,
		width: 600,
		items: config.formItems,
		buttons: this.buttonsConfig,
		listeners:{
			afterrender:function(form){
				if(form.carregaRegistro){
					form.getForm().load({
					    url: form.loadUrl,
						waitMsg: Ext.names.Aguarde,
					    failure: HttpHelpers.failHandler
					});
				}
			}
		}
	}
	Ext.ux.util.mapObj(this.formConfig, config.formConfig);
	
	return new Ext.form.FormPanel(this.formConfig);		
}