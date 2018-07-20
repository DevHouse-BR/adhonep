/**
 * @author Leonardo
 */

var AtributosPessoaisGridWindow;
var JanelaAtributosPessoaisCreateWindow;

DevHouseDesktop.AtributosPessoaisWindow = Ext.extend(Ext.app.Module, {
    id:'atributospessoais-win',
    init : function(){
        this.launcher = {
            text: 'Consultar Atributos Pessoais',
            iconCls:'atributosPessoais',
            handler : this.createWindow,
            scope: this
        }
    },
    createWindow : function(){
        var desktop = this.app.getDesktop();
        AtributosPessoaisGridWindow = desktop.getWindow('atributospessoais-win');
        if(!AtributosPessoaisGridWindow){
        	AtributosPessoaisGridWindow = desktop.createWindow({
                id: 'atributospessoais-win',
                title:'Consultar Atributos Pessoais',
                width:500,
                height:400,
                iconCls: 'atributospessoais',
                shim:false,
                animCollapse:false,
                constrainHeader:true,
                layout: 'hbox',
				layoutConfig:{
					align: 'stretch'
				},
                items: AtributosPessoaisListingEditorGrid = new Ext.grid.EditorGridPanel({
                    id: 'AtributosPessoaisListingEditorGrid',
                    stripeRows:true,
					flex: 1,
                    clicksToEdit:2,
                    viewConfig: {
                		autoFill: true,
                        forceFit:true
                    },
                    autoExpandColumn: 'atributospessoais-atributosCol',
                    loadMask: true,
                    selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
                    store: AtributosPessoaisDataStore = new Ext.data.Store({
                        id: 'AtributosPessoaisDataStore',
                        remoteSort: true,
						listeners:{
							//exception:DevHouseDesktop.desktop.erroHTTP
						},
                        proxy: new Ext.data.HttpProxy({
                        	url: 'atributospessoais/atributospessoaisGrid',
                            method: 'POST'
                        }),
                        baseParams:{
	                    	start: 0,          
	                        limit: 15
                        },
                        reader: new Ext.data.JsonReader({
                        	root: 'rows',
                        	totalProperty: 'results',
                        	id: 'AtributosPessoaisDataStoreReader'
                        },[ 
                           	{name: "idatributospessoais", type: "int", mapping: "idatributospessoais"},
                    		{name: "atributo", type: "string", mapping:"atributo"},
							{name: "aplicacao", type: "int", mapping:"aplicacao"}
                        ]),
                        sortInfo:{field: 'atributo', direction: "ASC"}
                    }),
                    cm: AtributosPessoaisColumnModel = new Ext.grid.ColumnModel(
                		[{
                		    header: 'Editar',
                		    readOnly: true,
                		    dataIndex: 'idatributospessoais',
                		    width: 50,
                		    sortable: false,
							renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
	            			      return '<a href="javascript: editaAtributo(' + rowIndex + ')"><img src="images/atributos_pessoais-edit.png" ext:qwidth="150" ext:qtitle="Editar" ext:qtip="Clique para editar o registro" /></a>';
	            			  }
                		  },{
                		    header: 'Atributo',
                		    dataIndex: 'atributo',
                		    id: 'atributospessoais-atributosCol',
                		    sortable: true,
                		    width: 370,
                		    editor: new Ext.form.TextField({
                		        allowBlank: false,
                		        maxLengthText: "Máximo de 100 caracteres",
                		        maxLength: 100,
                		        maskRe: /([a-zA-Z'\.áéíóúÁÉÍÓÚÇçàÀãÃâÂêÊôÔüÜñÑ\s]+)$/
                		      })
						  },{
                		    header: 'Aplicação',
                		    dataIndex: 'aplicacao',
                		    id: 'atributospessoais-aplicacaoCol',
							sortable: true,
							width: 150,
							readOnly: false,
							renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
								switch(data) {
								      case 1:
								          return "Somente Pessoas";
										  break;
								      case 2:
								    	  return "Somente Cidades";
										  break;
									  case 3:
								    	  return "Pessoas e Cidades";
										  break;
								}               
							},
							editor: comboAplicacao = new Ext.form.ComboBox({
							    typeAhead: true,
							    triggerAction: 'all',
							    lazyRender:true,
							    mode: 'local',
							    store: new Ext.data.ArrayStore({
							        id: 0,
							        fields: [
							            'aplicacao',
							            'desc'
							        ],
							        data: [[1, 'Somente Pessoas'], [2, 'Somente Cidades'], [3, 'Pessoas e Cidades']]
							    }),
							    valueField: 'aplicacao',
							    displayField: 'desc'
							})
                		  }]
                		),
                    tbar: [{
                        text: 'Incluir',
                        tooltip: 'Inclui um novo registro',
                        iconCls:'add',
                        id: "atributospessoais-create-win-shortcut",
                        handler: function(){
	                    	var module = DevHouseDesktop.getModule("atributospessoais-create-win");
	                    	if(module){
	                    		if(!JanelaAtributosPessoaisCreateWindow){
	                    			module.createWindow();
	                    		}
	                    		else{
	                    			JanelaAtributosPessoaisCreateWindow.close();
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
				       	handler : HttpHelpers.excluirRegistro.createDelegate(this, [{grid: 'AtributosPessoaisListingEditorGrid', url: 'atributospessoais/removeAtributos', campoid:'idatributospessoais'}], true),
				       	scope : this
				    })
					 , '-', 
					 	'Busca:',
						new Ext.app.SearchField({
			                width:150,
							hideMode: 'offsets',
							store: AtributosPessoaisDataStore,
							paramName: 'query'
			            })
                     ,'->',
						{
							text: 'Imprimir',
						    tooltip: 'Imprimir',
					        handler: function(){
								window.open('atributospessoais/atributospessoaisGridPrint')
							}, 
					        iconCls:'print'
						}
                     ],
                     bbar: new Ext.PagingToolbar({
                         store: AtributosPessoaisDataStore,
                         displayInfo: true,
                         pageSize: 15,
                         animate: true,
                         plugins: new Ext.ux.plugins.ProgressPagingToolbar()
                     })
                 })
            });
        }
        AtributosPessoaisGridWindow.show();
        AtributosPessoaisDataStore.load();
        AtributosPessoaisListingEditorGrid.on('afteredit', salvaAtributoGrid);
        AtributosPessoaisGridWindow.on('show',function(){
			Ext.select('div.x-progress-text-back').setStyle('margin-top', '1px');
        });
    }
});

function editaAtributo(rowIndex){
	var module = DevHouseDesktop.getModule("atributospessoais-create-win");
	if(module){
		if(!JanelaAtributosPessoaisCreateWindow){
			module.createWindow();
		}
		else{
			JanelaAtributosPessoaisCreateWindow.close();
			module.createWindow();
		}
	}
	JanelaAtributosPessoaisCreateWindow.addListener('show', function(){
		Ext.getCmp('idatributospessoaisField').setValue(AtributosPessoaisDataStore.data.items[rowIndex].data.idatributospessoais);
		Ext.getCmp('atributoField').setValue(AtributosPessoaisDataStore.data.items[rowIndex].data.atributo);
		Ext.getCmp('aplicacaoField').setValue(AtributosPessoaisDataStore.data.items[rowIndex].data.aplicacao);
	}, this);
}



function salvaAtributoGrid(oGrid_event){
	DevHouseDesktop.desktop.salvaGrid({
		url: 'atributosPessoais/salvaAtributoGrid',
		params: {
			idatributospessoais: oGrid_event.record.data.idatributospessoais,
			atributo: oGrid_event.record.data.atributo,
			aplicacao: oGrid_event.record.data.aplicacao
		}
	}, oGrid_event.grid.store);
}

DevHouseDesktop.AtributosPessoaisCreateWindow = Ext.extend(Ext.app.Module, {
    id:'atributospessoais-create-win',
    init : function(){
        this.launcher = {
            text: 'Cadastro de Atributos Pessoais',
            iconCls:'atributospessoais',
            handler : this.createWindow,
            scope: this
        }
    },
    createWindow : function(){
        var desktop = this.app.getDesktop();
        JanelaAtributosPessoaisCreateWindow = desktop.getWindow('atributospessoais-create-win');
        if(!JanelaAtributosPessoaisCreateWindow){
        	JanelaAtributosPessoaisCreateWindow = desktop.createWindow({
            	id: 'AtributosPessoaisCreateWindow',
            	title: 'Cadastro de Atributos Pessoais',
				iconCls: 'atributospessoais',
            	closable:true,
            	width: 290,
            	height: 150,
            	plain:true,
            	layout: 'fit',
                items: AtributosPessoaisCreateForm = new Ext.FormPanel({
                	url: 'atributospessoais/salvaAtributo',
                	bodyStyle:'padding:5px',
                	monitorValid:true,
                	frame:true,
                	width: 250,
					labelWidth:60,
                	items:[{
    					id: 'idatributospessoaisField',
    					name: 'idatributospessoais',
    					allowBlank: true,
    					xtype: 'hidden',
    					inputType: 'hidden'
    				},{
    					id: 'atributoField',
    					name: 'atributo',
    					fieldLabel: 'Atributo',
    					xtype: 'textfield',
    					inputType: 'text',
    					allowBlank: false,
    				    maxLength: 100,
    				    anchor : '-20',
    				    maskRe: /([a-zA-Z\.'áéíóúÁÉÍÓÚÇçàÀãÃâÂêÊôÔüÜñÑ\s]+)$/
					},{
						columnWidth: 1.0,
						layout: 'form',
						border: false,
						items: [
							new Ext.form.ComboBox({
							    typeAhead: true,
								allowBlank: false,
								editable: false,
								fieldLabel: 'Aplicação',
								emptyText:'Selecione',
								id: 'aplicacaoField',
								hiddenName: 'aplicacao',
								listWidth:170,
								anchor : '-20',
							    triggerAction: 'all',
							    lazyRender:true,
							    mode: 'local',
							    store: new Ext.data.ArrayStore({
							        id: 0,
							        fields: [
							            'aplicacao',
							            'desc'
							        ],
							        data: [[1, 'Somente Pessoas'], [2, 'Somente Cidades'], [3, 'Pessoas e Cidades']]
							    }),
							    valueField: 'aplicacao',
							    displayField: 'desc'
							})
						]
					}],
                	buttons: [{
                			id: "botaoSalvar",
                			text: 'Salvar',
							iconCls:'salvar',
                			formBind: true,
                			handler: function(){
                				AtributosPessoaisCreateForm.getForm().submit({
		                            method:'POST', 
		     						waitMsg: 'Gravando Dados Aguarde...',
									waitTitle: 'Aguarde',

		    						success:function(form, action){
			                        	if(Ext.getCmp('fechajanelaField').checked) JanelaAtributosPessoaisCreateWindow.close();
										else{
											if (Ext.getCmp('idatributospessoaisField').getValue() == "") {
												Ext.getCmp('idatributospessoaisField').setValue('');
												Ext.getCmp('atributoField').setValue('');
												
												Ext.getCmp('atributoField').clearInvalid();
											}
										}
			            				if(AtributosPessoaisGridWindow){
			            					if(AtributosPessoaisGridWindow.isVisible()) AtributosPessoaisDataStore.reload();										
			            					DesktopHelpers.showNotification({title:'Concluido',iconCls:'alerta',html:'Dados gravados com sucesso!'});
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
								JanelaAtributosPessoaisCreateWindow.close();
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
        JanelaAtributosPessoaisCreateWindow.show();
    }
});