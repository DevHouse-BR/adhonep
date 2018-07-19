/**
 * @author Leonardo
 */

var LocaisGridWindow;
var JanelaLocaisCreateWindow;

DevHouseDesktop.LocaisWindow = Ext.extend(Ext.app.Module, {
    id:'locais-win',
    init : function(){
        this.launcher = {
            text: 'Consultar Locais',
            iconCls:'locais',
            handler : this.createWindow,
            scope: this
        }
    },
    createWindow : function(){
        var desktop = this.app.getDesktop();
        LocaisGridWindow = desktop.getWindow('locais-win');
        if(!LocaisGridWindow){
        	LocaisGridWindow = desktop.createWindow({
                id: 'locais-win',
                title:'Consultar Locais',
                width:740,
                height:490,
                iconCls: 'locais',
                shim:false,
                animCollapse:false,
                constrainHeader:true,
                layout: 'hbox',
				layoutConfig:{
					align: 'stretch'
				},
                items: LocaisListingEditorGrid = new Ext.grid.EditorGridPanel({
                    id: 'LocaisListingEditorGrid',
                    stripeRows:true,
					flex: 1,
                    clicksToEdit:2,
                    viewConfig: {
                		autoFill: true,
                        forceFit:true,
						enableRowBody:true,
						mostraEndereco: true,
						getRowClass: function(record, rowIndex, rp, ds){
					        if(this.mostraEndereco){
					            rp.body = '<a href="javascript: mostraLocal(' + rowIndex + ')"><img style="margin-left:5px;" align="left" src="images/locais-maps.png" ext:qwidth="166" ext:qtitle="Google Maps" ext:qtip="Clique para ver o mapa do local" /></a><div style="padding:2px 10px 2px 57px;"><i>'+record.data.endereco+' - '+ record.data.bairro + '</i></div>';
					            return 'x-grid3-row-expanded';
					        }
					        return 'x-grid3-row-collapsed';
					    }
                    },
                    autoExpandColumn: 'localCol',
                    loadMask: true,
                    selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
                    store: LocaisDataStore = new Ext.data.Store({
                        id: 'LocaisDataStore',
                        remoteSort: true,
						listeners:{
							//exception:DevHouseDesktop.desktop.erroHTTP
						},
                        proxy: new Ext.data.HttpProxy({
                        	url: 'locais/locaisgrid',
                            method: 'POST'
                        }),
                        baseParams:{
	                    	start: 0,          
	                        limit: 9
                        },
                        reader: new Ext.data.JsonReader({
                        	root: 'rows',
                        	totalProperty: 'results',
                        	id: 'LocaisDataStoreReader'
                        },[ 
                           	{name: "idlocais", type: "int", mapping: "idlocais"},
                    		{name: "local", type: "string", mapping:"local"},
                    		{name: "endereco", type: "string", mapping: "endereco"},
							{name: "bairro", type: "string", mapping: "bairro"},
							{name: "idcidades", type: "int", mapping: "idcidades"},
							{name: "cidade", type: "string", mapping: "cidade"},
                    		{name: "telefone", type: "string", mapping: "telefone"},
							{name: "idpessoas", type: "int", mapping: "idpessoas"},                 		
                    		{name: "contato", type: "string", mapping: "contato"},
							{name: "desc", type: "string", mapping: "desc"}
                        ]),
                        sortInfo:{field: 'local', direction: "ASC"}
                    }),
                    cm: LocaisColumnModel = new Ext.grid.ColumnModel(
                		[{
                		    header: 'Editar',
                		    readOnly: true,
                		    dataIndex: 'idlocais',
							id: 'idlocaisCol',
                		    width: 34,
                		    sortable: false,
							renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
	            			      return '<a href="javascript: editaLocal(' + rowIndex + ')"><img src="images/locais-edit.png" ext:qwidth="200" ext:qtitle="Editar" ext:qtip="Clique para editar o registro" /></a>';
	            			  }
                		  },{
                		    header: 'Local',
                		    dataIndex: 'local',
                		    id: 'localCol',
                		    sortable: true,
                		    width: 170,
                		    editor: new Ext.form.TextField({
                		        allowBlank: false,
                		        maxLengthText: "Máximo de 255 caracteres",
                		        maxLength: 255,
                		        maskRe: /([a-zA-Z0-9'\.\-,áéíóúÁÉÍÓÚÇçàÀãÃâÂêÊôÔüÜñÑ\s]+)$/
                		      })
                		  },{
                		    header: 'Telefone',
                		    dataIndex: 'telefone',
							id: 'telefoneCol',
                		    sortable: true,
                		    width: 70,
                		    readOnly: false,
                		    editor: new Ext.ux.campoTelefone({
                		        allowBlank: true,
                		        maxLength: 16,
                		        maxLengthText: "Máximo de 16 caracteres",
                		        maskRe: /[0-9]/
                		        })
                		  },{
                		    header: "Cidade",
                		    dataIndex: 'idcidades',
                		    sortable: true,
                		    width: 70,
                		    readOnly: false,
							renderer: Ext.util.Format.comboRenderer(comboCidades2), 
							editor: comboCidades2
                		  },{
							header: "Contato",
							dataIndex: 'idpessoas',
							sortable: true,
							width: 120,
							readOnly: false,
							renderer: Ext.util.Format.comboRenderer(comboPessoas), 
							editor: comboPessoas
                		  }]
                		),
                    tbar: [{
                        text: 'Incluir',
                        tooltip: 'Inclui um novo registro',
                        iconCls:'add',
                        id: "locais-create-win-shortcut",
                        handler: function(){
	                    	var module = DevHouseDesktop.getModule("locais-create-win");
	                    	if(module){
	                    		if(!JanelaLocaisCreateWindow){
	                    			module.createWindow();
	                    		}
	                    		else{
	                    			JanelaLocaisCreateWindow.close();
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
				       	handler : HttpHelpers.excluirRegistro.createDelegate(this, [{grid: 'LocaisListingEditorGrid', url: 'locais/removeLocais', campoid:'idlocais'}], true),
				       	scope : this
				     })
					 , '-', 
					 	'Busca:',
						new Ext.app.SearchField({
			                width:240,
							hideMode: 'offsets',
							store: LocaisDataStore,
							paramName: 'query'
			            })
                     ,'->',
						{
							text: 'Imprimir',
						    tooltip: 'Imprimir',
					        handler: function(){
								window.open('locais/locaisGridPrint')
							}, 
					        iconCls:'print'
						}
                     ],
                     bbar: new Ext.PagingToolbar({
                         store: LocaisDataStore,
                         displayInfo: true,
                         pageSize: 9,
                         animate: true,
                         plugins: new Ext.ux.plugins.ProgressPagingToolbar()
                     })
                 })
            });
        }
        LocaisGridWindow.show();
		LocaisGridWindow.on('close', function(){
			comboCidades2 = new Ext.ux.comboCidades();
			comboPessoas = new Ext.ux.comboPessoas();
		});
        LocaisDataStore.load();
        LocaisListingEditorGrid.on('afteredit', salvaLocalGrid);
        LocaisGridWindow.on('show',function(){
			Ext.select('div.x-progress-text-back').setStyle('margin-top', '1px');
        });
    }
});

function editaLocal(rowIndex){
	var module = DevHouseDesktop.getModule("locais-create-win");
	if(module){
		if(!JanelaLocaisCreateWindow){
			module.createWindow();
		}
		else{
			JanelaLocaisCreateWindow.close();
			module.createWindow();
		}
	}
	JanelaLocaisCreateWindow.addListener('show', function(){
		Ext.getCmp('idlocaisField').setValue(LocaisDataStore.data.items[rowIndex].data.idlocais);
		Ext.getCmp('localField').setValue(LocaisDataStore.data.items[rowIndex].data.local);
		Ext.getCmp('telefoneField').setValue(LocaisDataStore.data.items[rowIndex].data.telefone);
		Ext.getCmp('enderecoField').setValue(LocaisDataStore.data.items[rowIndex].data.endereco);
		Ext.getCmp('bairroField').setValue(LocaisDataStore.data.items[rowIndex].data.bairro);
		Ext.getCmp('idcidadesField').setValue(LocaisDataStore.data.items[rowIndex].data.idcidades);
		Ext.getCmp('idpessoasField').setValue(LocaisDataStore.data.items[rowIndex].data.idpessoas);
		Ext.getCmp('enderecoField').setValue(LocaisDataStore.data.items[rowIndex].data.endereco);
		Ext.getCmp('descLocalField').setValue(LocaisDataStore.data.items[rowIndex].data.desc);
	}, this);
}

function mostraLocal(rowIndex){
	mapwin = DevHouseDesktop.desktop.createWindow({
        layout: 'fit',
        title: 'Mapa: ' + LocaisDataStore.data.items[rowIndex].data.local,
		iconCls: 'locais',
        width:400,
        height:400,
        x: 40,
        y: 60,
        items: {
            xtype: 'gmappanel',
            region: 'center',
            zoomLevel: 14,
            gmapType: 'map',
            mapConfOpts: ['enableScrollWheelZoom','enableDoubleClickZoom','enableDragging'],
            mapControls: ['GSmallMapControl','GMapTypeControl','NonExistantControl'],
            setCenter: {
				geoCodeAddr: LocaisDataStore.data.items[rowIndex].data.endereco + ', ' + LocaisDataStore.data.items[rowIndex].data.cidade + ', BR',
                marker: {title: LocaisDataStore.data.items[rowIndex].data.local}
            }
        }
    });

	mapwin.show();
}


function salvaLocalGrid(oGrid_event){
	DevHouseDesktop.desktop.salvaGrid({
		url: 'locais/salvaLocalGrid',
		params: {
			idlocais: oGrid_event.record.data.idlocais,
			local: oGrid_event.record.data.local,
			bairro: oGrid_event.record.data.bairro,
			idcidades: oGrid_event.record.data.idcidades,
			telefone: oGrid_event.record.data.telefone,
			idpessoas: oGrid_event.record.data.idpessoas
		}
	}, oGrid_event.grid.store);
}


DevHouseDesktop.LocaisCreateWindow = Ext.extend(Ext.app.Module, {
    id:'locais-create-win',
    init : function(){
        this.launcher = {
            text: 'Cadastro de Locais',
            iconCls:'locais',
            handler : this.createWindow,
            scope: this
        }
    },
    createWindow : function(){
        var desktop = this.app.getDesktop();
        JanelaLocaisCreateWindow = desktop.getWindow('locais-create-win');
        if(!JanelaLocaisCreateWindow){
        	JanelaLocaisCreateWindow = desktop.createWindow({
            	id: 'LocaisCreateWindow',
            	title: 'Cadastro de Locais',
				iconCls: 'locais',
            	closable:true,
            	width: 610,
            	height: 494,
            	plain:true,
            	layout: 'fit',
                items: LocaisCreateForm = new Ext.FormPanel({
					labelAlign: 'top',
                	url: 'locais/salvaLocal',
                	bodyStyle:'padding:5px',
                	monitorValid:true,
                	frame:true,
                	width: 600,
                	items: [{
                		layout:'column',
                		border:false,
                		items:[{
                			columnWidth:0.5,
                			layout: 'form',
                			border:false,
                			items:[{
                					id: 'idlocaisField',
                					name: 'idlocais',
                					allowBlank: true,
                					xtype: 'hidden',
                					inputType: 'hidden'
                				},{
                					id: 'localField',
                					name: 'local',
                					fieldLabel: 'Local',
                					xtype: 'textfield',
                					inputType: 'text',
                					allowBlank: false,
                				    maxLength: 255,
                				    anchor : '92%',
                				    maskRe: /([a-zA-Z0-9'\.\-,áéíóúÁÉÍÓÚÇçàÀãÃâÂêÊôÔüÜñÑ\s]+)$/
                				},{
                					id: 'idpessoasField',
                					hiddenName: 'idpessoas',
									name: 'pessoas',
                					fieldLabel: 'Contato',
                					xtype: 'comboPessoas',
                					allowBlank: false,
									anchor : '92%'
                				}]
                		},{
                			columnWidth:0.5,
                			layout: 'form',
                			border:false,
                			items: [{
                					id: 'telefoneField',
                					name: 'telefone',
                					fieldLabel: 'Telefone',
                					xtype: 'campoTelefone',
                					inputType: 'text',
                					allowBlank: true,
                				    maxLength: 16,
                				    anchor : '93%',
                				    maskRe: /[0-9]/
                				},{
                					id: 'idcidadesField',
                					hiddenName: 'idcidades',
									name: 'cidades',
                					fieldLabel: 'Cidade',
                					xtype: 'comboCidades',
                					allowBlank: false,
                				    anchor : '93%'
                			}]
                		},{
                			columnWidth:1.0,
                			layout: 'form',
                			border:false,
                			items: [{
                				id: 'enderecoField',
                				name: 'endereco',
                				fieldLabel: 'Endereço',
                				xtype: 'textarea',
                				inputType: 'textarea',
                				allowBlank: true,
                			    maxLength: 255,
                			    maxLengthText: "Este campo comporta até 255 caracteres.",
								msgTarget: 'under',
                			    anchor : '97%'
                			}]
                		},{
                	    	columnWidth:0.5,
                			layout: 'form',
                			border:false,
                			items: [{
                					id: 'bairroField',
                					name: 'bairro',
                					fieldLabel: 'Bairro',
                					xtype: 'textfield',
                					inputType: 'text',
                					allowBlank: false,
                				    maxLength: 255,
                				    anchor : '92%',
                				    maskRe: /([a-zA-Z0-9\-\.áéíóúÁÉÍÓÚÇçàÀãÃâÂêÊôÔüÜñÑ\s]+)$/
                			}]
                		},{
                			columnWidth:1.0,
                			layout: 'form',
                			border:false,
                			items: [{
								xtype: 'editorDevHouse',
								id: 'descLocalField',
								name: "desc",
								fieldLabel: 'Descrição',
								height: 150,
								anchor: '100%'
							}]
                		}]
                	}],
                	buttons: [{
                			id: "botaoSalvar",
                			text: 'Salvar',
							iconCls:'salvar',
                			formBind: true,
                			handler: function(){
                				LocaisCreateForm.getForm().submit({
		                            method:'POST', 
		     						waitMsg: 'Gravando Dados Aguarde...',
									waitTitle: 'Aguarde',
		    						success:function(){
			                        	if(Ext.getCmp('fechajanelaField').checked) JanelaLocaisCreateWindow.close();
										else{
											if (Ext.getCmp('idlocaisField').getValue() == "") {
												Ext.getCmp('idlocaisField').setValue('');
												Ext.getCmp('localField').setValue('');
												Ext.getCmp('telefoneField').setValue('');
												Ext.getCmp('enderecoField').setValue('');
												Ext.getCmp('bairroField').setValue('');
												Ext.getCmp('idcidadesField').setValue('');
												Ext.getCmp('idpessoasField').setValue('');
												Ext.getCmp('idcidadesField').setValue('');
												Ext.getCmp('enderecoField').setValue('');
												Ext.getCmp('enderecoField').setValue('');
												Ext.getCmp('descLocalField').setValue('');
												
												Ext.getCmp('localField').clearInvalid();
												Ext.getCmp('idcidadesField').clearInvalid();
												Ext.getCmp('idpessoasField').clearInvalid();
											}
										}
			            				if(LocaisGridWindow){
			            					if(LocaisGridWindow.isVisible()) LocaisDataStore.reload();
											DevHouseDesktop.desktop.showNotification({title:'Concluido',iconCls:'alerta',html: 'Dados gravados com sucesso!'});
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
                				JanelaLocaisCreateWindow.close();
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
        JanelaLocaisCreateWindow.show();
		JanelaLocaisCreateWindow.on('close', function(){
			comboCidades2 = new Ext.ux.comboCidades();
			comboPessoas = new Ext.ux.comboPessoas();
		});
    }
});