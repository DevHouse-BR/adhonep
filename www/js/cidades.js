/**
 * @author Leonardo
 */

var CidadesGridWindow;
var JanelaCidadesCreateWindow;


DevHouseDesktop.CidadesWindow = Ext.extend(Ext.app.Module, {
    id:'cidades-win',
    init : function(){
        this.launcher = {
            text: 'Consultar Cidades',
            iconCls:'cidades',
            handler : this.createWindow,
            scope: this
        }
    },
    createWindow : function(){
        var desktop = this.app.getDesktop();
        CidadesGridWindow = desktop.getWindow('cidades-win');
        if(!CidadesGridWindow){
        	CidadesGridWindow = desktop.createWindow({
                id: 'cidades-win',
                title:'Consultar Cidades',
                width:500,
                height:400,
                iconCls: 'cidades',
                shim:false,
                animCollapse:false,
                constrainHeader:true,
                layout: 'hbox',
				layoutConfig:{
					align: 'stretch'
				},
                items: CidadesListingEditorGrid = new Ext.grid.EditorGridPanel({
                    id: 'CidadesListingEditorGrid',
                    stripeRows:true,
					flex: 1,
                    clicksToEdit:2,
                    viewConfig: {
                		autoFill: true,
                        forceFit:true
                    },
                    autoExpandColumn: 'cidades-cidadeCol',
                    loadMask: true,
                    selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
                    store: CidadesDataStore = new Ext.data.Store({
                        id: 'CidadesDataStore',
                        remoteSort: true,
						listeners:{
							//exception:DevHouseDesktop.desktop.erroHTTP
						},
                        proxy: new Ext.data.HttpProxy({
                        	url: 'cidades/cidadesgrid',
                            method: 'POST'
                        }),
                        baseParams:{
	                    	start: 0,          
	                        limit: 12
                        },
                        reader: new Ext.data.JsonReader({
                        	root: 'rows',
                        	totalProperty: 'results',
                        	id: 'CidadesDataStoreReader'
                        },[ 
                           	{name: "idcidades", type: "int", mapping: "idcidades"},
                    		{name: "cidade", type: "string", mapping:"cidade"},
							{name: "capitulo", type: "string", mapping:"capitulo"},
                    		{name: "imagem", type: "string", mapping: "imagem"},
							{name: "desc", type: "string", mapping: "desc"},
							{name:'responsaveis', type: 'auto'}
                        ]),
                        sortInfo:{field: 'cidade', direction: "ASC"}
                    }),
                    cm: CidadesColumnModel = new Ext.grid.ColumnModel(
                		[{
                		    header: 'Editar',
                		    readOnly: true,
                		    dataIndex: 'idcidades',
                		    width: 40,
                		    sortable: false,
							renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
	            			      return '<a href="javascript: editaCidade(' + rowIndex + ')"><img src="images/cidades-edit.png" ext:qwidth="150" ext:qtitle="Editar" ext:qtip="Clique para editar o registro" /></a>';
	            			  }
                		  },{
                		    header: 'Cidade',
                		    dataIndex: 'cidade',
                		    id: 'cidades-cidadeCol',
                		    sortable: true,
                		    width: 170,
                		    editor: new Ext.form.TextField({
                		        allowBlank: false,
                		        maxLengthText: "Máximo de 100 caracteres",
                		        maxLength: 100,
                		        maskRe: /([a-zA-Z'\.áéíóúÁÉÍÓÚÇçàÀãÃâÂêÊôÔüÜñÑ\s]+)$/
                		      })
                		  },{
                		    header: 'Capítulo',
                		    dataIndex: 'capitulo',
                		    sortable: true,
                		    id: 'capituloCol',
                		    width: 70,
                		    editor: new Ext.form.TextField({
                		      allowBlank: false,
                		      maxLength: 50
                		      })
						 },{
                		    header: 'Imagem',
                		    dataIndex: 'imagem',
                		    sortable: true,
                		    id: 'imagemCol',
							readOnly: true,
                		    width: 150
						},{
                		    header: 'Resp.',
                		    dataIndex: 'responsaveis',
                		    sortable: false,
                		    id: 'responsaveisCol',
							align: 'center',
							readOnly: true,
                		    width: 40,
							renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
								  	var tip = '<img style="cursor:pointer" src="images/group.png" ext:qtitle="Responsáveis" ext:qwidth="200" ext:qtip="<br style=\'font-size:4px\' />';
									if(store.data.items[rowIndex].data.responsaveis.length == 0) tip += 'Sem Registros';
									for (var i = 0; i < store.data.items[rowIndex].data.responsaveis.length; i++){
										tip += '<b>' + store.data.items[rowIndex].data.responsaveis[i].atributo + ':</b> ';
										tip += store.data.items[rowIndex].data.responsaveis[i].nome + '<br />';
									}
								  	tip += '" />';
									return String.format(tip);
	            			  }
                		  }]
                		),
                    tbar: [{
                        text: 'Incluir',
                        tooltip: 'Inclui um novo registro',
                        iconCls:'add',
                        id: "cidades-create-win-shortcut",
                        handler: function(){
	                    	var module = DevHouseDesktop.getModule("cidades-create-win");
	                    	if(module){
	                    		if(!JanelaCidadesCreateWindow){
	                    			module.createWindow();
	                    		}
	                    		else{
	                    			JanelaCidadesCreateWindow.close();
	                    			module.createWindow();
	                    		}
	                    	}
						}
                     },
					 new Ext.Button({
				       	text: 'Excluir',
						tooltip: 'Remove os registros selecionados',
						iconCls:'remove',
						align:"right",
				       	handler : HttpHelpers.excluirRegistro.createDelegate(this, [{grid: 'CidadesListingEditorGrid', url: 'cidades/removeCidades', campoid:'idcidades'}], true),
				       	scope : this
				    })
					 , '-', 
					 	'Busca:',
						new Ext.app.SearchField({
			                width:200,
							hideMode: 'offsets',
							store: CidadesDataStore,
							paramName: 'query'
			            })
                     ,'->',
						{
							text: 'Imprimir',
						    tooltip: 'Imprimir',
					        handler: function(){
								window.open('cidades/cidadesGridPrint')
							}, 
					        iconCls:'print'
						}
                     ],
                     bbar: new Ext.PagingToolbar({
                         store: CidadesDataStore,
                         displayInfo: true,
                         pageSize: 12,
                         animate: true,
                         plugins: new Ext.ux.plugins.ProgressPagingToolbar()
                     })
                 })
            });
        }
        CidadesGridWindow.show();
        CidadesDataStore.load();
        CidadesListingEditorGrid.on('afteredit', salvaCidadeGrid);
        CidadesGridWindow.on('show',function(){
			Ext.select('div.x-progress-text-back').setStyle('margin-top', '1px');
        });
    }
});


function editaCidade(rowIndex){
	var module = DevHouseDesktop.getModule("cidades-create-win");
	if(module){
		if(!JanelaCidadesCreateWindow){
			module.createWindow();
		}
		else{
			JanelaCidadesCreateWindow.close();
			module.createWindow();
		}
	}
	JanelaCidadesCreateWindow.addListener('show', function(){
		Ext.getCmp('idcidadesField').setValue(CidadesDataStore.data.items[rowIndex].data.idcidades);
		Ext.getCmp('cidadeField').setValue(CidadesDataStore.data.items[rowIndex].data.cidade);
		Ext.getCmp('capituloField').setValue(CidadesDataStore.data.items[rowIndex].data.capitulo);
		Ext.getCmp('descCidadeField').setValue(CidadesDataStore.data.items[rowIndex].data.desc);
		
		
		for (var i = 0; i < CidadesDataStore.data.items[rowIndex].data.responsaveis.length; i++) {
			Ext.getCmp('responsaveis-' + CidadesDataStore.data.items[rowIndex].data.responsaveis[i].idatributospessoais + '-Field').setValue(CidadesDataStore.data.items[rowIndex].data.responsaveis[i].idpessoas, true);
		}
	}, this);
}

function salvaCidadeGrid(oGrid_event){
	DevHouseDesktop.desktop.salvaGrid({
		url: 'cidades/salvaCidadeGrid',
		params: {
			idcidades: oGrid_event.record.data.idcidades,
			cidade: oGrid_event.record.data.cidade,
			capitulo: oGrid_event.record.data.capitulo,
			imagem: oGrid_event.record.data.imagem
		}
	}, oGrid_event.grid.store);
}

var ArrayResponsaveis = [];

function populateResponsaveis(){
	ArrayResponsaveis = [];
	for (i=0; i<AtributosPessoaisStore.data.length;i++){
		if ((AtributosPessoaisStore.data.items[i].data.aplicacao == 2) || (AtributosPessoaisStore.data.items[i].data.aplicacao == 3)) {
			ArrayResponsaveis.push({
				id: 'responsaveis-' + AtributosPessoaisStore.data.items[i].data.idatributospessoais + '-Field',
				hiddenName: 'responsaveis[' + AtributosPessoaisStore.data.items[i].data.idatributospessoais + ']',
				name: 'pessoas',
				fieldLabel: AtributosPessoaisStore.data.items[i].data.atributo,
				xtype: 'comboPessoas',
				allowBlank: true,
				width : 200				
			});
		}
	}
}




DevHouseDesktop.CidadesCreateWindow = Ext.extend(Ext.app.Module, {
    id:'cidades-create-win',
    init : function(){
        this.launcher = {
            text: 'Cadastro de Cidades',
            iconCls:'cidades',
            handler : this.createWindow,
            scope: this
        }
    },
    createWindow : function(){
		populateResponsaveis();
        var desktop = this.app.getDesktop();
        JanelaCidadesCreateWindow = desktop.getWindow('cidades-create-win');
        if(!JanelaCidadesCreateWindow){
        	JanelaCidadesCreateWindow = desktop.createWindow({
            	id: 'CidadesCreateWindow',
            	title: 'Cadastro de Cidades',
				iconCls: 'cidades',
            	closable:true,
            	width: 610,
            	height: 486,
            	plain:true,
            	layout: 'fit',
                items: CidadesCreateForm = new Ext.FormPanel({
                	url: 'cidades/salvaCidade',
					fileUpload: true,
                	bodyStyle:'padding:0px',
                	monitorValid:true,
                	frame:true,
                	width: 600,
                	items: [{
						xtype: 'tabpanel',
						deferredRender:false,
       					border: false,
						frame:true,
						activeTab: 0,
						items:[{
							bodyStyle: {padding: '5px'},
				            title: 'Informações Básicas',
				            layout: 'column',
							frame:true,
							defaults: {
				                columnWidth: 0.5
				            },
							items: [{
	                			layout: 'form',
								labelAlign: 'top',
	                			border:false,
	                			items:[{
									id: 'idcidadesField',
                					name: 'idcidades',
                					allowBlank: true,
                					xtype: 'hidden',
                					inputType: 'hidden'
								},{
									id: 'cidadeField',
                					name: 'cidade',
                					fieldLabel: 'Cidade',
                					xtype: 'textfield',
                					inputType: 'text',
                					allowBlank: false,
                				    maxLength: 100,
                				    anchor : '92%',
                				    maskRe: /([a-zA-Z\.'áéíóúÁÉÍÓÚÇçàÀãÃâÂêÊôÔüÜñÑ\s]+)$/
								},{
									id: 'capituloField',
                					name: 'capitulo',
                					fieldLabel: 'Capítulo',
                					xtype: 'textfield',
                					inputType: 'text',
                					allowBlank: true,
                				    maxLength: 50,
                				    anchor : '92%'
								}]
							},{
								layout: 'form',
								labelAlign: 'top',
	                			border:false,
	                			items: [{
									id: 'imagemField',
                					name: 'imagem',               					
                				    anchor : '100%',
									xtype: 'fileuploadfield',
						            emptyText: 'Selecione Uma Imagem',
									allowBlank: true,
						            fieldLabel: 'Imagem',
						            buttonText: '',
						            buttonCfg: {
						                iconCls: 'upload-icon'
						            }
								}]
							},{
	                			columnWidth:1.0,
	                			layout: 'form',
								labelAlign: 'top',
	                			border:false,
	                			items: [{
									xtype: 'editorDevHouse',
									id: 'descCidadeField',
									name: "desc",
									allowBlank: true,
									fieldLabel: 'Descrição',
									height: 230,
									anchor: '100%'
								}]
							}]
						},{
							bodyStyle: {padding: '5px'},
				            title: 'Responsáveis',
				            layout: 'form',
							frame:true,
							items: ArrayResponsaveis
						}]
                	}],
                	buttons: [{
                			id: "botaoSalvar",
                			text: 'Salvar',
							iconCls:'salvar',
                			formBind: true,
                			handler: function(){
                				CidadesCreateForm.getForm().submit({
		                            method:'POST', 
		     						waitMsg: 'Gravando Dados Aguarde...',
									waitTitle: 'Aguarde',

		    						success:function(form, action){
			                        	if(Ext.getCmp('fechajanelaField').checked) JanelaCidadesCreateWindow.close();
										else{
											if (Ext.getCmp('idcidadesField').getValue() == "") {
												Ext.getCmp('idcidadesField').setValue('');
												Ext.getCmp('cidadeField').setValue('');
												Ext.getCmp('capituloField').setValue('');
												Ext.getCmp('descCidadeField').setValue('');
												
												for (i = 0; i < AtributosPessoaisStore.data.length; i++) {
													if ((AtributosPessoaisStore.data.items[i].data.aplicacao == 2) || (AtributosPessoaisStore.data.items[i].data.aplicacao == 3)) {
														Ext.getCmp('responsaveis-' + AtributosPessoaisStore.data.items[i].data.idatributospessoais + '-Field').setValue('');
													}
												}
												
												Ext.getCmp('cidadeField').clearInvalid();
											}
										}
			            				if(CidadesGridWindow){
			            					if(CidadesGridWindow.isVisible()) CidadesDataStore.reload();
											DevHouseDesktop.desktop.showNotification({title:'Concluido',iconCls:'alerta',html: 'Dados gravados com sucesso!'});
			            				}
		    						}, 
		    						failure: function(form, action){
										Ext.Msg.hide();
		    		                    if (action.failureType === Ext.form.Action.CONNECT_FAILURE) {
											Ext.MessageBox.show({
									            title: 'Erro!',
												width: 360,
									            msg: 'Status: '+action.response.status+'<br />'+ action.response.statusText,
									            buttons: Ext.MessageBox.OK,
									            icon: Ext.MessageBox.ERROR
									        });
		    		                    }
		    		                    else{
											Ext.MessageBox.show({
									            title: 'Inválido!',
												width: 360,
									            msg: action.result.errormsg,
									            buttons: Ext.MessageBox.OK,
									            icon: Ext.MessageBox.ERROR
									        });
		    		                    }
		    		                }
		                        });
		                    }
                		},{
                			text: 'Cancelar',
							iconCls:'cancelar',
                			handler: function(){
								JanelaCidadesCreateWindow.close();
							}
                		},
						new Ext.form.Label({
							text:'Fecha Janela'
						}),
						new Ext.form.Checkbox({
							id: 'fechajanelaField',
							checked: true,
							name: 'fechajanela'
						})
                	]
                })
            });
        }
        JanelaCidadesCreateWindow.show();
    }
});