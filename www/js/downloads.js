/**
* @author Leonardo
*/

var DownloadsGridWindow;
var JanelaDownloadsCreateWindow;


DevHouseDesktop.DownloadsWindow = Ext.extend(Ext.app.Module, {
    id:'downloads-win',
    init : function(){
        this.launcher = {
            text: 'Consultar Downloads',
            iconCls:'downloads',
            handler : this.createWindow,
            scope: this
        }
    },
    createWindow : function(){
        var desktop = this.app.getDesktop();
        DownloadsGridWindow = desktop.getWindow('downloads-win');
        if(!DownloadsGridWindow){
        	DownloadsGridWindow = desktop.createWindow({
                id: 'downloads-win',
                title:'Consultar Downloads',
                width:760,
                height:480,
                iconCls: 'downloads',
                shim:false,
                animCollapse:false,
                constrainHeader:true,
                layout: 'hbox',
				layoutConfig:{
					align: 'stretch'
				},
                items: DownloadsListingEditorGrid = new Ext.grid.EditorGridPanel({
                    id: 'DownloadsListingEditorGrid',
                    stripeRows:true,
					flex: 1,
                    clicksToEdit:2,
                    viewConfig: {
                		autoFill: true,
                        forceFit:true
                    },
                    autoExpandColumn: 'arquivoCol',
                    loadMask: true,
                    selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
                    store: DownloadsDataStore = new Ext.data.Store({
                        id: 'DownloadsDataStore',
                        remoteSort: true,
						listeners:{
							//exception:DevHouseDesktop.desktop.erroHTTP
						},
                        proxy: new Ext.data.HttpProxy({
                        	url: 'downloads/downloadsGrid',
                            method: 'POST'
                        }),
                        baseParams:{
	                    	start: 0,          
	                        limit: 15
                        },
                        reader: new Ext.data.JsonReader({
                        	root: 'rows',
                        	totalProperty: 'results',
                        	id: 'DownloadsDataStoreReader'
                        },[ 
                           	{name: "iddownloads", type: "int", mapping: "iddownloads"},
                    		{name: "arquivo", type: "string", mapping:"arquivo"},
                    		{name: "caminho", type: "string", mapping: "caminho"},
                    		{name: "uploader", type: "int", mapping: "uploader"},
                    		{name: "autor", type: "string", mapping: "autor"},
                    		{name: "nomeUploader", type: "string", mapping: "nomeUploader"},
							{name: "qtddownloads", type: "int", mapping: "qtddownloads"}
                        ]),
                        sortInfo:{field: 'arquivo', direction: "ASC"}
                    }),
                    cm: DownloadsColumnModel = new Ext.grid.ColumnModel(
                		[{
                		    header: 'Editar',
                		    readOnly: true,
                		    dataIndex: 'iddownloads',
                		    width: 40,
                		    sortable: false,
							renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
	            			      return '<a href="javascript: editaDownload(' + rowIndex + ')"><img src="images/download_edit.png" ext:qwidth="150" ext:qtitle="Editar" ext:qtip="Clique para editar o registro" /></a>';
	            			  }
                		  },{
                		    header: 'Arquivo',
                		    dataIndex: 'arquivo',
                		    id: 'arquivoCol',
                		    sortable: true,
                		    width: 120,
                		    editor: new Ext.form.TextField({
                		        allowBlank: false,
                		        maxLengthText: "Máximo de 255 caracteres",
                		        maxLength: 255
                		      })
                		  },{
                		    header: 'Caminho',
                		    dataIndex: 'caminho',
                		    sortable: true,
                		    id: 'caminhoCol',
                		    width: 150,
                		    readOnly: true,
							renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
	            			      return '<a target="_blank" href="downloads/downloadNow/' + record.data.iddownloads + '"><img align="left" src="images/download-now.png" ext:qwidth="156" ext:qtitle="Download" ext:qtip="Clique para fazer o download" /></a>&nbsp;' + data;
	            			  }
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
						  },{
                		    header: 'Uploader',
                		    dataIndex: 'nomeUploader',
                		    sortable: true,
							readOnly: true,
                		    id: 'caminhoCol',
                		    width: 150
						},{
                		    header: 'Quantidade',
                		    dataIndex: 'qtddownloads',
                		    sortable: true,
							readOnly: true,
							align: 'right',
                		    id: 'qtdCol',
                		    width: 60
                		  }]
                		),
                    tbar: [{
                        text: 'Incluir',
                        tooltip: 'Inclui um novo registro',
                        iconCls:'add',
                        id: "downloads-create-win-shortcut",
                        handler: function(){
	                    	var module = DevHouseDesktop.getModule("downloads-create-win");
	                    	if(module){
	                    		if(!JanelaDownloadsCreateWindow){
	                    			module.createWindow();
	                    		}
	                    		else{
	                    			JanelaDownloadsCreateWindow.close();
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
				       	handler : HttpHelpers.excluirRegistro.createDelegate(this, [{grid: 'DownloadsListingEditorGrid', url: 'downloads/removeDownloads', campoid:'iddownloads'}], true),
				       	scope : this
				     })
					 , '-', 
					 	'Busca:',
						new Ext.app.SearchField({
			                width:240,
							hideMode: 'offsets',
							store: DownloadsDataStore,
							paramName: 'query'
			            })
					, '-',
					{
						text: 'Estatísticas',
						iconCls: 'pizza',
						tooltip: 'Exibe Estatísticas de Download',
						handler:function(){
							var estWin = DevHouseDesktop.desktop.createWindow({
						        layout: 'fit',
						        title: 'Estatísticas de Download',
								iconCls: 'pizza',
						        width:400,
						        height:300,
						        x: 40,
						        y: 60,
						        items: {
									xtype: 'piechart',
									title: 'Os 5 Arquivos mais baixados',
						            store: new Ext.data.Store({
										autoLoad:true,
										listeners:{
											//exception:DevHouseDesktop.desktop.erroHTTP
										},
				                        proxy: new Ext.data.HttpProxy({
				                        	url: 'downloads/downloadsGrid',
				                            method: 'POST'
				                        }),
				                        baseParams:{
					                    	start: 0,          
					                        limit: 5,
				                        },
				                        reader: new Ext.data.JsonReader({
				                        	root: 'rows',
				                        	totalProperty: 'results',
				                        },[ 
				                    		{name: "arquivo", type: "string", mapping:"arquivo"},
											{name: "qtddownloads", type: "int", mapping: "qtddownloads"}
				                        ]),
				                        sortInfo:{field: 'qtddownloads', direction: "DESC"}
				                    }),
						            dataField: 'qtddownloads',
						            categoryField: 'arquivo',
						            extraStyle:
						            {
						                legend:
						                {
						                    display: 'right',
						                    padding: 5,
						                    font:
						                    {
						                        family: 'Tahoma',
						                        size: 13
						                    }
						                }
						            }
						        }

						    });
							estWin.show();
						}
					}
                     ,'->',
						{
							text: 'Imprimir',
						    tooltip: 'Imprimir',
					        handler: function(){
								window.open('downloads/downloadsGridPrint')
							}, 
					        iconCls:'print'
						}
                     ],
                     bbar: new Ext.PagingToolbar({
                         store: DownloadsDataStore,
                         displayInfo: true,
                         pageSize: 15,
                         animate: true,
                         plugins: new Ext.ux.plugins.ProgressPagingToolbar()
                     })
                 })
            });
        }
        DownloadsGridWindow.show();
        DownloadsDataStore.load();
        DownloadsListingEditorGrid.on('afteredit', salvaDownloadGrid);
        DownloadsGridWindow.on('show',function(){
			Ext.select('div.x-progress-text-back').setStyle('margin-top', '1px');
        });
    }
});

function editaDownload(rowIndex){
	var module = DevHouseDesktop.getModule("downloads-create-win");
	if(module){
		if(!JanelaDownloadsCreateWindow){
			module.createWindow();
		}
		else{
			JanelaDownloadsCreateWindow.close();
			module.createWindow();
		}
	}
	JanelaDownloadsCreateWindow.addListener('show', function(){
		Ext.getCmp('iddownloadsField').setValue(DownloadsDataStore.data.items[rowIndex].data.iddownloads);
		Ext.getCmp('arquivoField').setValue(DownloadsDataStore.data.items[rowIndex].data.arquivo);
		Ext.getCmp('autorField').setValue(DownloadsDataStore.data.items[rowIndex].data.autor);
	}, this);
}


function salvaDownloadGrid(oGrid_event){
	DevHouseDesktop.desktop.salvaGrid({
		url: 'downloads/salvaDownloadGrid',
		params: {
			iddownloads: oGrid_event.record.data.iddownloads,
			arquivo: oGrid_event.record.data.arquivo,
			caminho: oGrid_event.record.data.caminho,
			autor: oGrid_event.record.data.autor
		}
	}, oGrid_event.grid.store);
}


DevHouseDesktop.DownloadsCreateWindow = Ext.extend(Ext.app.Module, {
    id:'downloads-create-win',
    init : function(){
        this.launcher = {
            text: 'Cadastro de Downloads',
            iconCls:'downloads',
            handler : this.createWindow,
            scope: this
        }
    },
    createWindow : function(){
        var desktop = this.app.getDesktop();
        JanelaDownloadsCreateWindow = desktop.getWindow('downloads-create-win');
        if(!JanelaDownloadsCreateWindow){
        	JanelaDownloadsCreateWindow = desktop.createWindow({
            	id: 'DownloadsCreateWindow',
            	title: 'Cadastro de Downloads',
				iconCls: 'downloads',
            	closable:true,
            	width: 350,
            	height: 170,
            	plain:true,
            	layout: 'fit',
                items: DownloadsCreateForm = new Ext.FormPanel({
                	url: 'downloads/salvaDownload',
					labelWidth:60,
					fileUpload: true,
                	monitorValid:true,
					bodyStyle:'padding:5px',
                	frame:true,
                	items: [{
						id: 'iddownloadsField',
	    					name: 'iddownloads',
	    					allowBlank: true,
	    					xtype: 'hidden',
	    					inputType: 'hidden'
	    				},{
	    					id: 'arquivoField',
	    					name: 'arquivo',
	    					fieldLabel: 'Nome',
	    					xtype: 'textfield',
	    					inputType: 'text',
	    					allowBlank: false,
	    				    maxLength: 255,
	    				    anchor : '-20'
						},{
							columnWidth:0.5,
                			layout: 'form',
                			border:false,
                			items: [{
            					id: 'caminhoField',
		    					name: 'caminho',               					
		    				    anchor: '-20',
								xtype: 'fileuploadfield',
					            emptyText: 'Selecione Um Arquivo',
								allowBlank: true,
					            fieldLabel: 'Arquivo',
					            buttonText: 'Procurar'
                			}]
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
                	}],
                	buttons: [{
                			id: "botaoSalvar",
                			text: 'Salvar',
							iconCls:'salvar',
                			formBind: true,
                			handler: function(){
                				DownloadsCreateForm.getForm().submit({
		                            method:'POST', 
		     						waitMsg: 'Gravando Dados Aguarde...',
									waitTitle: 'Aguarde',
		    						success:function(){
										if(Ext.getCmp('fechajanelaField').checked) JanelaDownloadsCreateWindow.close();
										else{
											if (Ext.getCmp('iddownloadsField').getValue() == "") {
												Ext.getCmp('iddownloadsField').setValue('');
												Ext.getCmp('arquivoField').setValue('');
												Ext.getCmp('caminhoField').setValue('');
												Ext.getCmp('autorField').setValue('');
												
												Ext.getCmp('arquivoField').clearInvalid();
												Ext.getCmp('caminhoField').clearInvalid();
												Ext.getCmp('autorField').clearInvalid();
											}
										}
			            				if(DownloadsGridWindow){
			            					if(DownloadsGridWindow.isVisible()) DownloadsDataStore.reload();
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
                				JanelaDownloadsCreateWindow.close();
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
        JanelaDownloadsCreateWindow.show();
    }
});





