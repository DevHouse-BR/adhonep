/**
* @author Leonardo
*/

var IdeiasGridWindow;
var JanelaIdeiasCreateWindow;


var expander = new Ext.ux.grid.RowExpander({
    tpl : new Ext.Template(
        '<p><b>Idéia:</b> {ideia}</p>',
        '<p><b>Descrição:</b> {desc}</p>'
    )
});

DevHouseDesktop.IdeiasWindow = Ext.extend(Ext.app.Module, {
    id:'ideias-win',
    init : function(){
        this.launcher = {
            text: 'Consultar Idéias',
            iconCls:'ideias',
            handler : this.createWindow,
            scope: this
        }
    },
    createWindow : function(){
        var desktop = this.app.getDesktop();
        IdeiasGridWindow = desktop.getWindow('ideias-win');
        if(!IdeiasGridWindow){
        	IdeiasGridWindow = desktop.createWindow({
                id: 'ideias-win',
                title:'Consultar Idéias',
                width:760,
                height:480,
                iconCls: 'ideias',
                shim:false,
                animCollapse:false,
                constrainHeader:true,
                layout: 'hbox',
				layoutConfig:{
					align: 'stretch'
				},
                items: IdeiasListingEditorGrid = new Ext.grid.EditorGridPanel({
                    id: 'IdeiasListingEditorGrid',
                    stripeRows:true,
					flex: 1,
                    clicksToEdit:2,
                    viewConfig: {
                		autoFill: true,
                        forceFit:true
                    },
                    autoExpandColumn: 'ideiaCol',
                    loadMask: true,
					plugins: expander,
                    selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
                    store: IdeiasDataStore = new Ext.data.Store({
                        id: 'IdeiasDataStore',
                        remoteSort: true,
						listeners:{
							//exception:DevHouseDesktop.desktop.erroHTTP
						},
                        proxy: new Ext.data.HttpProxy({
                        	url: 'ideias/ideiasGrid',
                            method: 'POST'
                        }),
                        baseParams:{
	                    	start: 0,          
	                        limit: 15
                        },
                        reader: new Ext.data.JsonReader({
                        	root: 'rows',
                        	totalProperty: 'results',
                        	id: 'IdeiasDataStoreReader'
                        },[ 
                           	{name: "idideias", type: "int", mapping: "idideias"},
                    		{name: "ideia", type: "string", mapping:"ideia"},
                    		{name: "ondeusar", type: "string", mapping: "ondeusar"},
                    		{name: "autor", type: "string", mapping: "autor"},
							{name: "desc", type: "string", mapping: "desc"}
                        ]),
                        sortInfo:{field: 'ideia', direction: "ASC"}
                    }),
                    cm: IdeiasColumnModel = new Ext.grid.ColumnModel(
                		[
						expander,
						{
                		    header: 'Editar',
                		    readOnly: true,
                		    dataIndex: 'idideias',
                		    width: 40,
                		    sortable: false,
							renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
	            			      return '<a href="javascript: editaIdeia(' + rowIndex + ')"><img src="images/ideias-edit.png" ext:qwidth="150" ext:qtitle="Editar" ext:qtip="Clique para editar o registro" /></a>';
	            			  }
                		  },{
                		    header: 'Idéia',
                		    dataIndex: 'ideia',
                		    id: 'ideiaCol',
                		    sortable: true,
                		    width: 120,
                		    editor: new Ext.form.TextField({
                		        allowBlank: false,
                		        maxLengthText: "Máximo de 255 caracteres",
                		        maxLength: 255
                		      })
                		  },{
                		    header: 'Onde Usar?',
                		    dataIndex: 'ondeusar',
                		    sortable: true,
                		    id: 'ondeusarCol',
                		    width: 150,
                		    readOnly: true
                		  },{
                			  header: "Autor",
							  dataIndex: 'autor',
							  sortable: true,
							  width: 120,
							  readOnly: false,
							  editor: new Ext.form.TextField({
                		        allowBlank: false,
                		        maxLengthText: "Máximo de 255 caracteres",
                		        maxLength: 255,
                		        maskRe: /([a-zA-Z'\.áéíóúÁÉÍÓÚÇçàÀãÃâÂêÊôÔüÜñÑ\s]+)$/
                		      })
                		  }]
                		),
                    tbar: [{
                        text: 'Incluir',
                        tooltip: 'Inclui um novo registro',
                        iconCls:'add',
                        id: "btnAdicionar",
                        handler: function(){
	                    	var module = DevHouseDesktop.getModule("ideias-create-win");
	                    	if(module){
	                    		if(!JanelaIdeiasCreateWindow){
	                    			module.createWindow();
	                    		}
	                    		else{
	                    			JanelaIdeiasCreateWindow.close();
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
				       	handler : HttpHelpers.excluirRegistro.createDelegate(this, [{grid: 'IdeiasListingEditorGrid', url: 'ideias/removeIdeias', campoid:'idideias'}], true),
				       	scope : this
				     })
					 , '-', 
					 	'Busca:',
						new Ext.app.SearchField({
			                width:240,
							hideMode: 'offsets',
							store: IdeiasDataStore,
							paramName: 'query'
			            })
                     ,'->',
						{
							text: 'Imprimir',
						    tooltip: 'Imprimir',
					        handler: function(){
								window.open('ideias/ideiasGridPrint')
							}, 
					        iconCls:'print'
						}
                     ],
                     bbar: new Ext.PagingToolbar({
                         store: IdeiasDataStore,
                         displayInfo: true,
                         pageSize: 15,
                         animate: true,
                         plugins: new Ext.ux.plugins.ProgressPagingToolbar()
                     })
                 })
            });
        }
        IdeiasDataStore.load();
        IdeiasListingEditorGrid.on('afteredit', salvaIdeiaGrid);
        IdeiasGridWindow.on('show',function(){
			Ext.select('div.x-progress-text-back').setStyle('margin-top', '1px');
        });
		IdeiasGridWindow.show();
    }
});

function editaIdeia(rowIndex){
	var module = DevHouseDesktop.getModule("ideias-create-win");
	if(module){
		if(!JanelaIdeiasCreateWindow){
			module.createWindow();
		}
		else{
			JanelaIdeiasCreateWindow.close();
			module.createWindow();
		}
	}
	JanelaIdeiasCreateWindow.addListener('show', function(){
		Ext.getCmp('idideiasField').setValue(IdeiasDataStore.data.items[rowIndex].data.idideias);
		Ext.getCmp('ideiaField').setValue(IdeiasDataStore.data.items[rowIndex].data.ideia);
		Ext.getCmp('ondeusarField').setValue(IdeiasDataStore.data.items[rowIndex].data.ondeusar);
		Ext.getCmp('autorField').setValue(IdeiasDataStore.data.items[rowIndex].data.autor);
		Ext.getCmp('descField').setValue(IdeiasDataStore.data.items[rowIndex].data.desc);
	}, this);
}

function salvaIdeiaGrid(oGrid_event){
	DevHouseDesktop.desktop.salvaGrid({
		url: 'ideias/salvaIdeiaGrid',
		params: {
			idideias: oGrid_event.record.data.idideias,
			ideia: oGrid_event.record.data.ideia,
			autor: oGrid_event.record.data.autor
		}
	}, oGrid_event.grid.store);
}


DevHouseDesktop.IdeiasCreateWindow = Ext.extend(Ext.app.Module, {
    id:'ideias-create-win',
    init : function(){
        this.launcher = {
            text: 'Cadastro de Ideias',
            iconCls:'ideias',
            handler : this.createWindow,
            scope: this
        }
    },
    createWindow : function(){
        var desktop = this.app.getDesktop();
        JanelaIdeiasCreateWindow = desktop.getWindow('ideias-create-win');
        if(!JanelaIdeiasCreateWindow){
        	JanelaIdeiasCreateWindow = desktop.createWindow({
            	id: 'IdeiasCreateWindow',
            	title: 'Cadastro de Ideias',
				iconCls: 'ideias',
            	closable:true,
            	width: 450,
            	height: 400,
            	plain:true,
            	layout: 'fit',
                items: IdeiasCreateForm = new Ext.FormPanel({
                	url: 'ideias/salvaIdeia',
					labelWidth:100,
                	monitorValid:true,
					bodyStyle:'padding:5px',
                	frame:true,
                	items: [{
						id: 'idideiasField',
	    					name: 'idideias',
	    					allowBlank: true,
	    					xtype: 'hidden',
	    					inputType: 'hidden'
	    				},{
	    					id: 'ideiaField',
	    					name: 'ideia',
	    					fieldLabel: 'Idéia',
	    					xtype: 'textfield',
	    					inputType: 'text',
	    					allowBlank: false,
	    				    maxLength: 255,
	    				    anchor : '-20'
						},{
							columnWidth: 0.5,
							layout: 'form',
							border: false,
							items: [
								new Ext.form.ComboBox({
									id: 'ondeusarField',
									name: 'ondeusar',
									fieldLabel: 'Onde Usar',
									anchor : '-20',
									typeAhead: false,
									editable: false,
								    triggerAction: 'all',
								    lazyRender:true,
									allowBlank: false,
								    mode: 'remote',
									loadingText: 'Procurando...',
									emptyText:'Selecione',
									listWidth:260,
									minChars:3,
									valueField: 'valor',
								    displayField: 'valor',
									store: new Ext.data.Store({
									    id: 0,
										remoteSort: true,
										autoLoad : true, 
									    proxy: new Ext.data.HttpProxy({
									    	url: 'ajustes/getAjuste',
									        method: 'POST'
									    }),
										baseParams:{
											ajuste: 'Onde Usar Idéias'
										},
									    reader: new Ext.data.JsonReader({
									    	root: 'rows',
									    	totalProperty: 'results'
									    },[ 
											{name: "valor", type: "string", mapping:"valor"}
									    ])
									})
								})
							]
						
						},{
							id: 'autorField',
	    					name: 'autor',
	    					fieldLabel: 'Autor',
	    					xtype: 'textfield',
	    					inputType: 'text',
	    					allowBlank: false,
	    				    maxLength: 255,
	    				    anchor : '-20',
	    				    maskRe: /([a-zA-Z\.'áéíóúÁÉÍÓÚÇçàÀãÃâÂêÊôÔüÜñÑ\s]+)$/
						},{
                			columnWidth:1.0,
                			layout: 'form',
							labelAlign: 'top',
                			border:false,
                			items: [{
								xtype: 'editorDevHouse',
								id: 'descField',
								name: "desc",
								allowBlank: true,
								fieldLabel: 'Descrição',
								height: 200,
								anchor: '100%'
							}]
                	}],
                	buttons: [{
                			id: "botaoSalvar",
                			text: 'Salvar',
							iconCls:'salvar',
                			formBind: true,
                			handler: function(){
                				IdeiasCreateForm.getForm().submit({
		                            method:'POST', 
		     						waitMsg: 'Gravando Dados Aguarde...',
									waitTitle: 'Aguarde',
		    						success:function(){
										if(Ext.getCmp('fechajanelaField').checked) JanelaIdeiasCreateWindow.close();
										else{
											if (Ext.getCmp('idideiasField').getValue() == "") {
												Ext.getCmp('idideiasField').setValue('');
												Ext.getCmp('ideiaField').setValue('');
												Ext.getCmp('ondeusarField').setValue('');
												Ext.getCmp('autorField').setValue('');
												Ext.getCmp('descField').setValue('');
												
												Ext.getCmp('ideiaField').clearInvalid();
												Ext.getCmp('ondeusarField').clearInvalid();
												Ext.getCmp('autorField').clearInvalid();
												Ext.getCmp('descField').clearInvalid('');
											}	
										}
			            				if(IdeiasGridWindow){
			            					if(IdeiasGridWindow.isVisible()) IdeiasDataStore.reload();
			            					DesktopHelpers.showNotification({title:'Concluido',iconCls:'alerta',html: 'Dados gravados com sucesso!'});
			            				}
		    						}, 
		    						failure: function(form, action){
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
                				JanelaIdeiasCreateWindow.close();
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
        JanelaIdeiasCreateWindow.show();
    }
});





