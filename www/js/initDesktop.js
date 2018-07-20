DevHouseDesktop = new Ext.app.App({
	init :function(){
		Ext.QuickTips.init();
		DevHouseDesktop.Stores.storeAtributosPessoais.load();
		DevHouseDesktop.Stores.storePermissoes.load();
		AccessController.init();
	},

	getModules : function(){
		return [
			new DevHouseDesktop.ModuloGridPessoas(),
			new DevHouseDesktop.ModuloFormPessoas(),
			new DevHouseDesktop.CidadesCreateWindow(),
			new DevHouseDesktop.CidadesWindow(),
			new DevHouseDesktop.LocaisCreateWindow(),
			new DevHouseDesktop.LocaisWindow(),
			new DevHouseDesktop.AtributosPessoaisCreateWindow(),
			new DevHouseDesktop.AtributosPessoaisWindow(),
			new DevHouseDesktop.DownloadsCreateWindow(),
			new DevHouseDesktop.DownloadsWindow(),
			new DevHouseDesktop.IdeiasCreateWindow(),
			new DevHouseDesktop.IdeiasWindow(),
			new DevHouseDesktop.AgendaCreateWindow(),
			new DevHouseDesktop.AgendaWindow(),
			new DevHouseDesktop.ModuloGridTeste()
		];
	},

    // config for the start menu
    getStartConfig : function(){
        return {
			items:[{
				text:'Cadastros',
                iconCls:'cadastros',
				scope:DevHouseDesktop,
				handler: function(){return false},
				menu:{
					items:[{
						text: Ext.names.FormPessoasTitle,
			            iconCls:'pessoas',
			            handler: function(){
							var m = DevHouseDesktop.getModule('id-modulo-form-pessoas');
							m.createWindow();
						}
					},{
						text: 'Cadastro de Cidades',
			            iconCls:'cidades',
			            handler: function(){
							var m = DevHouseDesktop.getModule('cidades-create-win');
							m.createWindow();
						}
					},{
						text: 'Cadastro de Locais',
			            iconCls:'locais',
			            handler: function(){
							var m = DevHouseDesktop.getModule('locais-create-win');
							m.createWindow();
						}
					},{
						text: 'Cadastro de Atributos Pessoais',
			            iconCls:'atributosPessoais',
			            handler: function(){
							var m = DevHouseDesktop.getModule('atributospessoais-create-win');
							m.createWindow();
						}
					},{
						text: 'Cadastro de Downloads',
			            iconCls:'downloads',
			            handler: function(){
							var m = DevHouseDesktop.getModule('downloads-create-win');
							m.createWindow();
						}
					},{
						text: 'Cadastro de Idéias',
			            iconCls:'ideias',
			            handler: function(){
							var m = DevHouseDesktop.getModule('ideias-create-win');
							m.createWindow();
						}
					},{
						text: 'Cadastro de Agenda',
			            iconCls:'agenda',
			            handler: function(){
							var m = DevHouseDesktop.getModule('agenda-create-win');
							m.createWindow();
						}
					}]
				}
			},{
				text:'Consultas',
                iconCls:'consultas',
				scope:DevHouseDesktop,
				handler: function(){return false},
				menu:{
					items:[{
						text: Ext.names.GridPessoasTitle,
			            iconCls:'pessoas',
			            handler: function(){
							var m = DevHouseDesktop.getModule('pessoas-win');
							m.createWindow();
						}
					},{
						text: 'Consultar Cidades',
			            iconCls:'cidades',
			            handler: function(){
							var m = DevHouseDesktop.getModule('cidades-win');
							m.createWindow();
						}
					},{
						text: 'Consultar Locais',
			            iconCls:'locais',
			            handler: function(){
							var m = DevHouseDesktop.getModule('locais-win');
							m.createWindow();
						}
					},{
						text: 'Consultar Atributos Pessoais',
			            iconCls:'atributosPessoais',
			            handler: function(){
							var m = DevHouseDesktop.getModule('atributospessoais-win');
							m.createWindow();
						}
					},{
						text: 'Consultar Downloads',
			            iconCls:'downloads',
			            handler: function(){
							var m = DevHouseDesktop.getModule('downloads-win');
							m.createWindow();
						}
					},{
						text: 'Consultar Idéias',
			            iconCls:'ideias',
			            handler: function(){
							var m = DevHouseDesktop.getModule('ideias-win');
							m.createWindow();
						}
					},{
						text: 'Consultar Agenda',
			            iconCls:'agenda',
			            handler: function(){
							var m = DevHouseDesktop.getModule('agenda-win');
							m.createWindow();
						}
					}]
				}
			}],
            title: DesktopHelpers.getCookie("usuario"),
            iconCls: 'user',
            toolItems: [{
                text:'Ajustes',
                iconCls:'settings',
                scope:DevHouseDesktop,
				handler: function(){
					ajustes = DevHouseDesktop.desktop.createWindow({
						id: 'ajustes-win',
		                title:'Configurações do Sistema',
		                width:400,
		                height:200,
		                iconCls: 'settings',
		                shim: false,
		                animCollapse: false,
		                constrainHeader: true,
		                layout: 'anchor',
						resizable: false,
		                items: AjustesGrid = new Ext.grid.PropertyGrid({
							width: 400,
							height: 200,
							stripeRows: true,
							anchor: '100% 100%',
							viewConfig : {
						        forceFit: true,
						        autoFill: true
						    },
							customEditors: {
							  'Teste de Opção': new Ext.grid.GridEditor(new Ext.form.ComboBox({
							  	triggerAction: 'all',
								editable: false,
							    store: ['sim', 'não']
							  }), {})
							},
							store: AjustesGridStore = new Ext.data.Store({
								autoLoad: true,
								proxy: new Ext.data.HttpProxy({
									url: 'ajustes/ajustesGrid',
									method: 'POST'
								}),
								reader: new Ext.data.DynamicJsonReader({root: 'data'})
							}),
							bbar: [
								'->',
								{
								text: 'Salvar',
								tooltip: 'Salvar Alterações', 
								iconCls:'salvar',
								handler: function() {
									var AjustesGridValues = Ext.util.JSON.encode(AjustesGridStore.getAt(0).data);
									Ext.Ajax.request({
										url: 'ajustes/salvaAjustes',
										method: 'POST',
										scope: this,
										success: function(response, options){
											var contentType = response.getResponseHeader('Content-Type');
											if(contentType != "application/json"){
												Ext.MessageBox.show({
										            title: Ext.names.Erro,
										            msg: Ext.names.ErroHTTPNotJSON + response.responseText,
										            buttons: Ext.MessageBox.OK,
										            icon: Ext.MessageBox.ERROR
										        });
											}
											else{
												var resposta = Ext.util.JSON.decode(response.responseText);
												if(resposta.success){
													DesktopHelpers.showNotification({title:'Concluido',iconCls:'info-icon',html: 'Dados gravados com sucesso!'});
													ajustes.close();
												}
											}
										},
										failure:HttpHelpers.failHandler,
										params: {
											ajustes: AjustesGridValues
										}
									});
								}
							},'&nbsp;',{
								text: 'Cancelar',
								tooltip: 'Cancelar Alterações', 
								iconCls:'cancelar',
								handler: function() {
									ajustes.close();
								}
							}]
						})
					});
					AjustesGridStore.on('load', function(){
						AjustesGridStore.fields = AjustesGridStore.recordType.prototype.fields;
						AjustesGrid.setSource(AjustesGridStore.getAt(0).data);
					})
					ajustes.show();
				}
			},'-',{
                text:'Créditos',
                iconCls:'creditos',
                scope:this,
				handler: function(){
					var creditos = new Ext.Window({
						closable: false,			
						title: 'Créditos',
						id: 'creditos-win',
						width: 550,
						resizable:false,
						height: 200,
						iconCls: 'creditos', 
						modal: true,	
						bodyStyle: 'padding: 4px;padding-left:8px;background-color:#fff',
						html: '<div style="font-family:tahoma"><table cellspacing="10" width="100%"><tr><td width="220" align="center"><span style="font-size:13px;font-weight:bold">ADHONEP - 2009</span></td><td width="85%" valign="middle"><span style="font-size:10px;font-weight:bold">&nbsp;Sistema ADHONEP JOVEM</span></td></tr><tr><td width="13%" align="center"><a href="http://www.devhouse.com.br" target="_blank"><img src="http://www.devhouse.com.br/devhouse_logo.png" width="220" border="0"></a></td><td valign="top" style="padding:6px;font-size:10px"><span style="font-size:10px;font-weight:bold">Versão:</span> RC 1.0<br><span style="font-weight:bold">DevHouse - Todos os Direitos Reservados &copy; 2009</span></td></tr></table></div>',
						buttons:[
							{
								text: 'Fechar',
								handler: function(){
									creditos.close();
								}
							}
						]
					});	
					creditos.show();
				}
            },'-',{
                text:'Logout',
                iconCls:'logout',
                scope:this,
				handler: function(){
					//alert('logout');
					//DesktopHelpers.showNotification({title:'Concluido',iconCls:'alerta',html: 'Dados gravados com sucesso!'});
					Ext.Ajax.request({
						url: 'login/logout',
						method: 'GET',
						scope: this,
						success: function(response, options){
							var resposta = Ext.util.JSON.decode(response.responseText);
							if(resposta.success){
								location = "login";
							}
						},
						failure:HttpHelpers.failHandler
					});
				}
            }]
        };
    }
});

