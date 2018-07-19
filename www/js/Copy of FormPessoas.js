/**
* @author Leonardo
*/

var PessoasGridWindow;
var JanelaPessoasCreateWindow;

var ArrayAtributosPessoais = [];
var ArrayAtributosPessoaisRadios = [];

var AtributosPessoaisStore = new Ext.data.Store({
    id: 'AtributosPessoaisStore',
    remoteSort: true,
	autoLoad: true,
	listeners:{
		//exception:MyDesktop.desktop.erroHTTP
	},
    proxy: new Ext.data.HttpProxy({
    	url: 'atributospessoais/atributospessoaisCheckBoxGroup',
        method: 'POST'
    }),
    reader: new Ext.data.JsonReader({
    	root: 'rows',
    	totalProperty: 'results',
    	id: 'AtributosPessoaisStoreReader'
    },[ 
       	{name: "idatributospessoais", type: "int", mapping: "idatributospessoais"},
		{name: "atributo", type: "string", mapping:"atributo"},
		{name: "aplicacao", type: "int", mapping:"aplicacao"}
    ]),
    sortInfo:{field: 'atributo', direction: "ASC"}
});


var ArrayPermissoes = [];

var PermissoesStore = new Ext.data.Store({
    id: 'PermissoesStore',
    remoteSort: true,
	autoLoad: true,
	listeners:{
		//exception:MyDesktop.desktop.erroHTTP
	},
    proxy: new Ext.data.HttpProxy({
    	url: 'permissoes/permissoesCheckBoxGroup',
        method: 'POST'
    }),
    reader: new Ext.data.JsonReader({
    	root: 'rows',
    	totalProperty: 'results',
    	id: 'PermissoesStoreStoreReader'
    },[ 
       	{name: "idpermissoes", type: "int", mapping: "idpermissoes"},
		{name: "permissao", type: "string", mapping:"permissao"}
    ]),
    sortInfo:{field: 'permissao', direction: "ASC"}
});

function populateCheckboxAtributosPessoais(){
	ArrayAtributosPessoais = [];
	for (i=0; i<AtributosPessoaisStore.data.length;i++){
		if ((AtributosPessoaisStore.data.items[i].data.aplicacao == 1) || (AtributosPessoaisStore.data.items[i].data.aplicacao == 3)) {
			ArrayAtributosPessoais.push({
				boxLabel: AtributosPessoaisStore.data.items[i].data.atributo,
				name: 'idatributospessoais[' + AtributosPessoaisStore.data.items[i].data.idatributospessoais + ']',
				inputValue: AtributosPessoaisStore.data.items[i].data.idatributospessoais
			});
		}
	}
}

function populateRadioAtributosPessoais(){
	ArrayAtributosPessoaisRadios = [];
	for (i=0; i<AtributosPessoaisStore.data.length;i++){
		if ((AtributosPessoaisStore.data.items[i].data.aplicacao == 1) || (AtributosPessoaisStore.data.items[i].data.aplicacao == 3)) {
			ArrayAtributosPessoaisRadios.push({
				boxLabel: AtributosPessoaisStore.data.items[i].data.atributo,
				//name: 'idatributospessoais[' + AtributosPessoaisStore.data.items[i].data.idatributospessoais + ']',
				name: 'idatributospessoais',
				inputValue: AtributosPessoaisStore.data.items[i].data.idatributospessoais
			});
		}
	}
}


function populateCheckboxPermissoes(){
	ArrayPermissoes = [];
	for (i=0; i<PermissoesStore.data.length;i++){
		ArrayPermissoes.push({
			boxLabel: PermissoesStore.data.items[i].data.permissao,
			name: 'idpermissoes['+PermissoesStore.data.items[i].data.idpermissoes+']',
			inputValue: PermissoesStore.data.items[i].data.idpermissoes
		});
	}
}


MyDesktop.PessoasWindow = Ext.extend(Ext.app.Module, {
    id:'pessoas-win',
    init : function(){
        this.launcher = {
            text: 'Consultar Pessoas',
            iconCls:'pessoas',
            handler : this.createWindow,
            scope: this
        }
    },
    createWindow : function(){
		populateRadioAtributosPessoais();
        var desktop = this.app.getDesktop();
        PessoasGridWindow = desktop.getWindow('pessoas-win');
        if(!PessoasGridWindow){
        	PessoasGridWindow = desktop.createWindow({
                id: 'pessoas-win',
                title:'Consultar Pessoas',
                width:740,
                height:480,
                iconCls: 'pessoas',
                shim:false,
                animCollapse:false,
                constrainHeader:true,
				layout:'border',
				defaults: {
				    collapsible: true,
				    split: true
				},
                items:[{
					title: 'Filtros',
					id:'filtros',
				    region: 'north',
					frame:true,
					forceLayout:true,
				    height: 150,
				    minSize: 75,
				    maxSize: 250,
				    cmargins: '0 0 5 0',
					items:[{
						xtype:'form',
						id:'formfiltros',
						layout:'form',
						monitorValid:true,
						labelWidth:70,
						items:[{
							id: 'nomeField-busca',
        					name: 'nome',
        					fieldLabel: 'Nome',
        					xtype: 'textfield',
        					inputType: 'text',
        					allowBlank: true,
        				    maxLength: 255,
        				    anchor : '50%',
        				    maskRe: /([a-zA-Z\.'áéíóúÁÉÍÓÚÇçàÀãÃâÂêÊôÔüÜñÑ\s]+)$/
						},{
							xtype: 'radiogroup',
				            columns: 4,
				            vertical: false,
							allowBlank: false,
				            items: ArrayAtributosPessoaisRadios
						}],
						buttons:[{
							id: "botaopesquisar",
                			text: 'Pesquisar',
							iconCls:'busca',
                			formBind: true,
							handler:function(botao){
								PessoasDataStore.baseParams['query'] = Ext.getCmp('formfiltros').getForm().getValues()['nome'];
								PessoasDataStore.baseParams['idatributospessoais'] = Ext.getCmp('formfiltros').getForm().getValues()['idatributospessoais'];
						        PessoasDataStore.reload();
								PessoasDataStore.baseParams['idatributospessoais'] = "";
							}
						}]
					}]
				},{
					id:'dadostabela',
				    region: 'center',
					collapsible: false,
					xtype:'container',
				    cmargins: '5 0 0 0',
					layout: 'hbox',
					layoutConfig:{
						align: 'stretch',
						pack  : 'start'
					},
					items:PessoasListingEditorGrid = new Ext.grid.EditorGridPanel({
	                    id: 'PessoasListingEditorGrid',
	                    stripeRows:true,
						flex: 1,
	                    clicksToEdit:2,
	                    viewConfig: {
	                		autoFill: true,
	                        forceFit:true
	                    },
						listeners:{
							render: function(){
								AccessController.applyPermission({action:'disable',components:['btnAdicionar'], modulo:'pessoas'});
							}
						},
	                    autoExpandColumn: 'nomeCol',
	                    loadMask: true,
	                    selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
	                    store: PessoasDataStore = new Ext.data.Store({
	                        id: 'PessoasDataStore',
	                        remoteSort: true,
	                        proxy: new Ext.data.HttpProxy({
	                        	url: 'pessoas/pessoasGrid',
	                            method: 'POST'
	                        }),
	                        baseParams:{
		                    	start: 0,          
		                        limit: 15
	                        },
							listeners:{
								exception:MyDesktop.desktop.erroHTTP,
								load: function(){
									for (var i = 0; i < PessoasDataStore.data.length; i++) {
										new Ext.ToolTip({        
									        title: this.data.items[i].data.nome,
									        target: 'pessoatip-' + i,
									        anchor: 'left',
									        html: '<br style=\'font-size:4px\' /><table><tr><td style="font-size:11px">' + this.data.items[i].data.desc +'</td></tr></table>',
									        width: 415,
									        autoHide: true,
											trackMouse:true
									    });
									}
								}
							},
	                        reader: new Ext.data.JsonReader({
	                        	root: 'rows',
	                        	totalProperty: 'results',
	                        	id: 'PessoasDataStoreReader'
	                        },[ 
	                           	{name: "idpessoas", type: "int", mapping: "idpessoas"},
	                    		{name: "nome", type: "string", mapping:"nome"},
	                    		{name: "email", type: "string", mapping: "email"},
	                    		{name: "telefone", type: "string", mapping: "telefone"},
	                    		{name: "celular", type: "string", mapping: "celular"},
	                    		{name: "idcidades", type: "string", mapping: "idcidades"},
								{name: "cidade", type: "string", mapping: "cidade"},
	                    		{name: "acesso", type: "int", mapping: "acesso"},
								{name: "bairro", type: "string", mapping: "bairro"},
								{name: "endereco", type: "string", mapping: "endereco"},
								{name:'atributos', type: 'auto'},
								{name:'permissoes', type: 'auto'},
								{name:'participacoes', type: 'auto'},
								{name: "desc", type: "string", mapping: "desc"}
	                        ]),
	                        sortInfo:{field: 'nome', direction: "ASC"}
	                    }),
	                    cm: PessoasColumnModel = new Ext.grid.ColumnModel(
	                		[{
	                		    header: 'Editar',
	                		    readOnly: true,
	                		    dataIndex: 'idpessoas',
	                		    width: 40,
	                		    sortable: false,
								renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
		            			      return '<a href="javascript: editaUsuario(' + rowIndex + ')"><img src="images/user_edit.png" ext:qtitle="Editar" ext:qwidth="150" ext:qtip="Clique para editar o registro" /></a>';
		            			  }
	                		  },{
	                		    header: 'Nome',
	                		    dataIndex: 'nome',
	                		    id: 'nomeCol',
	                		    sortable: true,
	                		    width: 170,
								renderer:  function(data, cell, record, rowIndex, columnIndex, store) {							
										return '<div style="cursor:pointer" id="pessoatip-' + rowIndex + '"><img src="images/user_comment.png" align="left" />&nbsp;' + data + '</div>';
		            			},
	                		    editor: new Ext.form.TextField({
	                		        allowBlank: false,
	                		        maxLengthText: "Máximo de 255 caracteres",
	                		        maxLength: 255,
	                		        maskRe: /([a-zA-Z'\.áéíóúÁÉÍÓÚÇçàÀãÃâÂêÊôÔüÜñÑ\s]+)$/
	                		      })
	                		  },{
	                		    header: 'Email',
	                		    dataIndex: 'email',
	                		    sortable: true,
	                		    id: 'emailCol',
	                		    width: 150,
	                		    editor: new Ext.form.TextField({
	                		      allowBlank: false,
	                		      maxLength: 255,
	                		      maxLengthText: "Máximo de 255 caracteres",
	                		      maskRe: Ext.form.VTypes.emailMask
	                		      })
	                		  },{
	                		    header: 'Telefone',
	                		    dataIndex: 'telefone',
	                		    sortable: true,
	                		    width: 80,
	                		    readOnly: false,
	                		    editor: new Ext.ux.campoTelefone({
	                		        allowBlank: true,
	                		        maxLength: 16,
	                		        maxLengthText: "Máximo de 16 caracteres",
	                		        maskRe: /[0-9]/
	                		        })
	                		  },{
	                		    header: "Celular",
	                		    dataIndex: 'celular',
	                		    sortable: true,
	                		    width: 80,
	                		    readOnly: false,
	                		    editor: new Ext.ux.campoCelular({
	                		      allowBlank: true,
	                		      maxLength: 16,
	                		      maxLengthText: "Máximo de 16 caracteres",
	                		      maskRe: /[0-9]/
	                		      })
	                		  },{
	                			  header: "Cidade",
								  dataIndex: 'idcidades',
								  sortable: true,
								  width: 80,
								  readOnly: false,
								  renderer: Ext.util.Format.comboRenderer(comboCidades), 
								  editor: comboCidades
							  },{
		                		  header: 'Preletor',
		                		  dataIndex: 'participacoes',
								  id: 'preletorCol',
								  align:'right',
		                		  sortable: false,
								  hidden: true,
		                		  width: 90,
		                		  readOnly: true,
								  renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
			            				for (i = 0; i < data.length; i++) {
											if(data[i].tipo == "1"){
												return data[i].qtd + 'x';
											}
										}
			            			}
							},{
		                		  header: 'Mestre',
		                		  dataIndex: 'participacoes',
								  id: 'mestreCol',
								  align:'right',
		                		  sortable: false,
								  hidden: true,
		                		  width: 90,
		                		  readOnly: true,
								  renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
			            				for (i = 0; i < data.length; i++) {
											if(data[i].tipo == "2"){
												return data[i].qtd + 'x';
											}
										}
			            			}
							},{
		                		  header: 'Músico',
		                		  dataIndex: 'participacoes',
								  id: 'musicoCol',
								  align:'right',
		                		  sortable: false,
								  hidden: true,
		                		  width: 90,
		                		  readOnly: true,
								  renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
			            				for (i = 0; i < data.length; i++) {
											if(data[i].tipo == "3"){
												return data[i].qtd + 'x';
											}
										}
			            			}
							},{
		                		  header: '5 Min.',
		                		  dataIndex: 'participacoes',
								  id: '5minCol',
								  align:'right',
		                		  sortable: false,
								  hidden: true,
		                		  width: 90,
		                		  readOnly: true,
								  renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
			            				for (i = 0; i < data.length; i++) {
											if(data[i].tipo == "4"){
												return data[i].qtd + 'x';
											}
										}
			            			}
	                		  },{
	                			  header: 'Acesso',
	                			  dataIndex: 'acesso',
	                			  sortable: true,
	                			  width: 50,
	                			  readOnly: false,
	                			  renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
	                			      switch(data) {
	                			          case 0:
	                			              cell.css = "redcell";
	                			              return "&nbsp;";
	                			          case 1:
	                			        	  cell.css = "greencell";
	                			        	  return "&nbsp;";
	                			      }                            
	                			  },
	                			  editor: comboAcesso = new Ext.form.ComboBox({
	                				    typeAhead: true,
	                				    triggerAction: 'all',
	                				    lazyRender:true,
	                				    mode: 'local',
	                				    store: new Ext.data.ArrayStore({
	                				        id: 0,
	                				        fields: [
	                				            'acesso',
	                				            'desc'
	                				        ],
	                				        data: [[0, 'Não'], [1, 'Sim']]
	                				    }),
	                				    valueField: 'acesso',
	                				    displayField: 'desc'
	                				})
	                		  }]
	                		),
	                    tbar: [{
	                        text: 'Incluir',
	                        tooltip: 'Inclui um novo registro',
	                        iconCls:'add',
	                        id: "btnAdicionar",
	                        handler: function(){
		                    	var module = MyDesktop.getModule("pessoas-create-win");
		                    	if(module){
		                    		if(!JanelaPessoasCreateWindow){
		                    			module.createWindow();
		                    		}
		                    		else{
		                    			JanelaPessoasCreateWindow.close();
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
					       	handler : MyDesktop.desktop.excluirRegistro.createDelegate(this, [{grid: 'PessoasListingEditorGrid', url: 'pessoas/removePessoas', campoid:'idpessoas'}], true),
					       	scope : this
					     })
						 , '-', 
						 	'Busca:',
							{
								xtype: 'searchfield',
				                width:240,
								id:'buscafield',
								hideMode: 'offsets',
								store: PessoasDataStore,
								paramName: 'query'
							}
						 ,'-',
							 {
							 	text: 'Participações em Reuniões',
								tooltip: 'Precione para exibir as colunas de participações em reuniões',
								iconCls:'user-chart',
						        enableToggle: true,
						        toggleHandler: function onItemToggle(item, pressed){
										if(pressed){
											PessoasListingEditorGrid.getColumnModel().setHidden(6, false);
											PessoasListingEditorGrid.getColumnModel().setHidden(7, false);
											PessoasListingEditorGrid.getColumnModel().setHidden(8, false);
											PessoasListingEditorGrid.getColumnModel().setHidden(9, false);
										}
										else{
											PessoasListingEditorGrid.getColumnModel().setHidden(6, true);
											PessoasListingEditorGrid.getColumnModel().setHidden(7, true);
											PessoasListingEditorGrid.getColumnModel().setHidden(8, true);
											PessoasListingEditorGrid.getColumnModel().setHidden(9, true);
										}
								    }
								,
						        pressed: false
							 }
	                     ,'->',
							{
								text: 'Imprimir',
							    tooltip: 'Imprimir',
						        handler: function(){
									window.open('pessoas/pessoasGridPrint')
								}, 
						        iconCls:'print'
							}
	                     ],
	                     bbar: new Ext.PagingToolbar({
	                         store: PessoasDataStore,
	                         displayInfo: true,
	                         pageSize: 15,
	                         animate: true,
	                         plugins: new Ext.ux.plugins.ProgressPagingToolbar()
	                     })
	                 })
				}]
            });
        }
		PessoasGridWindow.on('close', function(){
			comboCidades = new Ext.ux.comboCidades();
		});
        PessoasDataStore.load();
       // PessoasListingEditorGrid.on('afteredit', salvaPessoaGrid);
        PessoasGridWindow.on('show',function(){
			Ext.getCmp('filtros').expand();
			Ext.select('div.x-progress-text-back').setStyle('margin-top', '1px');
			var task = new Ext.util.DelayedTask(function(){
			    Ext.getCmp('filtros').collapse();
			});
			task.delay(500);
			var task2 = new Ext.util.DelayedTask(function(){
				var x = document.getElementById('filtros-xcollapsed');
				x.innerHTML = '<div class="x-collapsed-title"><img src="images/application_form_magnify.png" align="left" /> Filtros de Pesquisa</div>' + x.innerHTML;
			});
			task2.delay(1000);
        });
		PessoasGridWindow.show();
    }
});

function editaUsuario(rowIndex){
	var module = MyDesktop.getModule("pessoas-create-win");
	if(module){
		if(!JanelaPessoasCreateWindow){
			module.createWindow();
		}
		else{
			JanelaPessoasCreateWindow.close();
			module.createWindow();
		}
	}
	JanelaPessoasCreateWindow.addListener('show', function(){
		Ext.getCmp('idpessoasField').setValue(PessoasDataStore.data.items[rowIndex].data.idpessoas);
		Ext.getCmp('nomeField').setValue(PessoasDataStore.data.items[rowIndex].data.nome);
		Ext.getCmp('emailField').setValue(PessoasDataStore.data.items[rowIndex].data.email);
		Ext.getCmp('telefoneField').setValue(PessoasDataStore.data.items[rowIndex].data.telefone);
		Ext.getCmp('celularField').setValue(PessoasDataStore.data.items[rowIndex].data.celular);
		Ext.getCmp('enderecoField').setValue(PessoasDataStore.data.items[rowIndex].data.endereco);
		Ext.getCmp('bairroField').setValue(PessoasDataStore.data.items[rowIndex].data.bairro);
		Ext.getCmp('idcidadesField').setValue(PessoasDataStore.data.items[rowIndex].data.idcidades);
		Ext.getCmp('acessoField').setValue(PessoasDataStore.data.items[rowIndex].data.acesso);
		Ext.getCmp('enderecoField').setValue(PessoasDataStore.data.items[rowIndex].data.endereco);
		Ext.getCmp('descField').setValue(PessoasDataStore.data.items[rowIndex].data.desc);
		
		for (var i in PessoasDataStore.data.items[rowIndex].data.atributos){
			Ext.getCmp('atributospessoaisField').setValue('idatributospessoais['+PessoasDataStore.data.items[rowIndex].data.atributos[i].idatributospessoais+']', true);
		}
		
		for (var i in PessoasDataStore.data.items[rowIndex].data.permissoes){
			Ext.getCmp('permissoesField').setValue('idpermissoes['+PessoasDataStore.data.items[rowIndex].data.permissoes[i].idpermissoes+']', true);
		}

	}, this);
}

function salvaPessoaGrid(oGrid_event){
	MyDesktop.desktop.salvaGrid({
		url: 'pessoas/salvaPessoaGrid',
		params: {
			idpessoas: oGrid_event.record.data.idpessoas,
			nome: oGrid_event.record.data.nome,
			email: oGrid_event.record.data.email,
			telefone: oGrid_event.record.data.telefone,
			celular: oGrid_event.record.data.celular,
			idcidades: oGrid_event.record.data.idcidades,
			acesso: oGrid_event.record.data.acesso
		}
	}, oGrid_event.grid.store);
}


MyDesktop.PessoasCreateWindow = Ext.extend(Ext.app.Module, {
    id:'pessoas-create-win',
    init : function(){
        this.launcher = {
            text: 'Cadastro de Pessoas',
            iconCls:'pessoas',
            handler : this.createWindow,
            scope: this
        }
    },
    createWindow : function(){
		populateCheckboxAtributosPessoais();
		populateCheckboxPermissoes();
        var desktop = this.app.getDesktop();
        JanelaPessoasCreateWindow = desktop.getWindow('pessoas-create-win');
        if(!JanelaPessoasCreateWindow){
        	JanelaPessoasCreateWindow = desktop.createWindow({
            	id: 'PessoasCreateWindow',
            	title: 'Cadastro de Pessoas',
				iconCls: 'pessoas',
            	closable:true,
            	width: 610,
            	height: 550,
            	plain:true,
            	layout: 'fit',
                items: PessoasCreateForm = new Ext.FormPanel({
					labelAlign: 'top',
                	url: 'pessoas/salvaPessoa',
                	bodyStyle:'padding:0px',
					layout:'fit',
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
				            title: 'Informações Pessoais',
				            layout: 'column',
							frame:true,
				            defaults: {
				                columnWidth: 0.5
				            },
				            items: [{
	                			layout: 'form',
	                			border:false,
	                			items:[{
                					id: 'idpessoasField',
                					name: 'idpessoas',
                					allowBlank: true,
                					xtype: 'hidden',
                					inputType: 'hidden'
                				},{
                					id: 'nomeField',
                					name: 'nome',
                					fieldLabel: 'Nome',
                					xtype: 'textfield',
                					inputType: 'text',
                					allowBlank: false,
                				    maxLength: 255,
                				    anchor : '92%',
                				    maskRe: /([a-zA-Z\.'áéíóúÁÉÍÓÚÇçàÀãÃâÂêÊôÔüÜñÑ\s]+)$/
                				},{
                					id: 'telefoneField',
                					name: 'telefone',
                					fieldLabel: 'Telefone',
                					xtype: 'campoTelefone',
                					inputType: 'text',
                					allowBlank: true,
                				    maxLength: 16,
                				    anchor : '92%',
                				    maskRe: /[0-9]/
                				},{
                					id: 'senhaField',
                					name: 'senha',
                					fieldLabel: 'Senha',
                					xtype: 'textfield',
                					inputType: 'password',
                					allowBlank: true,
                				    maxLength: 16,
                				    anchor : '92%'
                				}]
							},{
				              	layout: 'form',
	                			border:false,
	                			items: [{
                					id: 'emailField',
                					name: 'email',
                					fieldLabel: 'Email',
                					xtype: 'textfield',
                					inputType: 'text',
                					allowBlank: false,
                				    maxLength: 255,
                				    anchor : '93%',
                				    maskRe: Ext.form.VTypes.emailMask
                				},{
                					id: 'celularField',
                					name: 'celular',
                					fieldLabel: 'Celular',
                					xtype: 'campoCelular',
                					inputType: 'text',
                					allowBlank: true,
                				    maxLength: 16,
                				    anchor : '93%',
                				    maskRe: /[0-9]/
                				},{
                					id: 'confirmaSenhaField',
                					name: 'confirmaSenha',
                					fieldLabel: 'Confirmação da Senha',
                					xtype: 'textfield',
                					inputType: 'password',
                					initialPasswordField: 'senhaField',
                					allowBlank: true,
                				    maxLength: 16,
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
	                	    	columnWidth:0.5,
	                			layout: 'form',
	                			border:false,
	                			items: [{
									id: 'idcidadesField',
                					hiddenName: 'idcidades',
									name: 'cidades',
                					fieldLabel: 'Cidade',
                					xtype: 'comboCidades',
                					allowBlank: false,
                				    anchor : '93%'
								}]
							},{
	                	    	columnWidth:0.5,
	                			layout: 'form',
								labelAlign: 'left',
								labelWidth: 106,
								bodyStyle: 'padding-top:20px',
	                			border:false,
	                			items: [{
                					id: 'acessoField',
                					name: 'acesso',
                					xtype: 'checkbox',
									fieldLabel: 'Acesso ao Sistema',
                					inputType: 'checkbox',
                					checked: true
	                			}]
							}]
						},{
							bodyStyle: {padding: '5px'},
				            title: 'Descrição',
				            layout: 'form',
							labelAlign: 'left',
							labelWidth: 1,
							frame:true,
				            items: [{
								xtype: 'editorDevHouse',
								id: 'descField',
								name: "desc",
								height: 350,
								anchor: '100%'
							}]
						},{
							bodyStyle: {padding: '5px'},
				            title: 'Atributos Pessoais',
				            layout: 'form',
							frame:true,
				            items: [{
					            xtype: 'checkboxgroup',
								id: 'atributospessoaisField',
					            fieldLabel: 'Selecione um ou mais atributos',
					            columns: 4,
					            vertical: false,
					            items: ArrayAtributosPessoais
							}]
						},{
							bodyStyle: {padding: '5px'},
				            title: 'Permissões',
				            layout: 'form',
							frame:true,
				            items: [{
					            xtype: 'checkboxgroup',
								id: 'permissoesField',
					            fieldLabel: 'Selecione uma ou mais permissões de Escrita',
					            vertical: true,
								columns: 2,
					            items: ArrayPermissoes
							}]
						}]
                	}],
                	buttons: [{
                			id: "botaoSalvar",
                			text: 'Salvar',
							iconCls:'salvar',
                			formBind: true,
                			handler: function(){
                				PessoasCreateForm.getForm().submit({
		                            method:'POST', 
		     						waitMsg: 'Gravando Dados Aguarde...',
									waitTitle: 'Aguarde',
		    						success:function(){
										if(Ext.getCmp('fechajanelaField').checked) JanelaPessoasCreateWindow.close();
										else{
											if (Ext.getCmp('idpessoasField').getValue() == "") {
												Ext.getCmp('idpessoasField').setValue('');
												Ext.getCmp('nomeField').setValue('');
												Ext.getCmp('emailField').setValue('');
												Ext.getCmp('telefoneField').setValue('');
												Ext.getCmp('celularField').setValue('');
												Ext.getCmp('enderecoField').setValue('');
												Ext.getCmp('bairroField').setValue('');
												Ext.getCmp('idcidadesField').setValue('');
												Ext.getCmp('acessoField').setValue('');
												Ext.getCmp('enderecoField').setValue('');
												Ext.getCmp('descField').setValue('');
												Ext.getCmp('senhaField').setValue('');
												Ext.getCmp('confirmaSenhaField').setValue('');
												
												for (var i in AtributosPessoaisStore.data.items) {
													if (i != 'remove') 
														Ext.getCmp('atributospessoaisField').setValue('idatributospessoais[' + AtributosPessoaisStore.data.items[i].data.idatributospessoais + ']', false);
												}
												for (var i in PermissoesStore.data.items) {
													if (i != 'remove') 
														Ext.getCmp('permissoesField').setValue('idpermissoes[' + PermissoesStore.data.items[i].data.idpermissoes + ']', false);
												}
												
												Ext.getCmp('nomeField').clearInvalid();
												Ext.getCmp('emailField').clearInvalid();
												Ext.getCmp('bairroField').clearInvalid();
												Ext.getCmp('idcidadesField').clearInvalid();
											}
											
										}
			            				if(PessoasGridWindow){
			            					if(PessoasGridWindow.isVisible()) PessoasDataStore.reload();
											MyDesktop.desktop.showNotification({title:'Concluido',iconCls:'alerta',html: 'Dados gravados com sucesso!'});
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
                				JanelaPessoasCreateWindow.close();
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
        JanelaPessoasCreateWindow.show();
    }
});





