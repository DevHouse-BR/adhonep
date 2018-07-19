/**
* @author Leonardo
*/

var AgendaGridWindow;
var JanelaAgendaCreateWindow;

DevHouseDesktop.AgendaWindow = Ext.extend(Ext.app.Module, {
    id:'agenda-win',
    init : function(){
        this.launcher = {
            text: 'Consultar Agenda',
            iconCls:'agenda',
            handler : this.createWindow,
            scope: this
        }
    },
    createWindow : function(){
        var desktop = this.app.getDesktop();
        AgendaGridWindow = desktop.getWindow('agenda-win');
        if(!AgendaGridWindow){
        	AgendaGridWindow = desktop.createWindow({
                id: 'agenda-win',
                title:'Consultar Agenda',
                width:950,
                height:500,
                iconCls: 'agenda',
                shim:false,
                animCollapse:false,
                constrainHeader:true,
                layout: 'hbox',
				layoutConfig:{
					align: 'stretch'
				},
                items: AgendaListingEditorGrid = new Ext.grid.EditorGridPanel({
                    id: 'AgendaListingEditorGrid',
                    stripeRows:true,
					flex: 1,
                    clicksToEdit:2,
                    viewConfig: {
                		autoFill: true,
                        forceFit:true
                    },
                    autoExpandColumn: 'localCol',
                    loadMask: true,
                    selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
                    store: AgendaDataStore = new Ext.data.Store({
                        id: 'AgendaDataStore',
                        remoteSort: true,
						listeners:{
							//exception:DevHouseDesktop.desktop.erroHTTP
						},
                        proxy: new Ext.data.HttpProxy({
                        	url: 'agenda/agendaGrid',
                            method: 'POST'
                        }),
                        baseParams:{
	                    	start: 0,          
	                        limit: 15
                        },
                        reader: new Ext.data.JsonReader({
                        	root: 'rows',
                        	totalProperty: 'results',
                        	id: 'AgendaDataStoreReader'
                        },[ 
                           	{name: "idagenda", type: "int", mapping: "idagenda"},
                    		{name: "datahora", type: "date", mapping: "datahora", dateFormat: "Y-m-d H:i:s"},
                    		{name: "novos", type: "string", mapping: "novos"},
                    		{name: "total", type: "string", mapping: "total"},
                    		{name: "desc", type: "string", mapping: "desc"},
                    		{name: "site", type: "string", mapping: "site"},
							{name: "idlocais", type: "string", mapping: "idlocais"},
							{name: "statuslocal", type: "string", mapping: "statuslocal"},
							{name: "local", type: "string", mapping: "local"},
							{name: "editor", type: "string", mapping: "editor"},
							{name:'encarregados', type: 'auto'}
                        ]),
                        sortInfo:{field: 'datahora', direction: "DESC"}
                    }),
                    cm: AgendaColumnModel = new Ext.grid.ColumnModel(
                		[{
                		    header: 'Editar',
                		    readOnly: true,
                		    dataIndex: 'idagenda',
                		    width: 40,
                		    sortable: false,
							renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
	            			      return '<a href="javascript: editaAgenda(' + rowIndex + ')"><img src="images/agenda-edit.png" ext:qtitle="Editar" ext:qwidth="150" ext:qtip="Clique para editar o registro" /></a>';
	            			  }
                		  },{
                		    header: 'Data',
                		    dataIndex: 'datahora',
                		    id: 'datahoraCol',
                		    sortable: true,
                		    width: 130,
							readOnly: true,
							renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
	            				return data.format("d/m/Y H:i \\h\\s");
	            			}
                		  },{
                		    header: 'Local',
                		    dataIndex: 'local',
                		    sortable: true,
                		    id: 'localCol',
                		    width: 150,
							readOnly: true,
							renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
								var color = 'black';
								switch(record.data.statuslocal){
									case 'vermelho':
										color = '#cc0000';
										break;
									case 'amarelo':
										color = '#cccc00';
										break;
									case 'verde':
										color = '#009900';
										break;
								}
	            				return '<span style="color:'+color+';">'+data+'</span>';
	            			}
						  },{
                		    header: 'Preletor',
                		    dataIndex: 'encarregados',
							id: 'preletorCol',
                		    sortable: false,
                		    width: 140,
                		    readOnly: true,
							renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
	            				for (i = 0; i < data.length; i++) {
									if(data[i].tipoencarregado == "1"){
										var color = 'black';
										switch(data[i].status){
											case 'vermelho':
												color = '#cc0000';
												break;
											case 'amarelo':
												color = '#cccc00';
												break;
											case 'verde':
												color = '#009900';
												break;
										}
										return '<span style="color:'+color+';">'+data[i].encarregado+'</span>';
									}
								}
	            			}
						  },{
                		    header: 'Mestre',
                		    dataIndex: 'encarregados',
							id: 'mestreCol',
                		    sortable: false,
                		    width: 140,
                		    readOnly: true,
							renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
	            				for (i = 0; i < data.length; i++) {
									if(data[i].tipoencarregado == "2"){
										var color = 'black';
										switch(data[i].status){
											case 'vermelho':
												color = '#cc0000';
												break;
											case 'amarelo':
												color = '#cccc00';
												break;
											case 'verde':
												color = '#009900';
												break;
										}
										return '<span style="color:'+color+';">'+data[i].encarregado+'</span>';
									}
								}
	            			}
						  },{
                		    header: 'Músico',
                		    dataIndex: 'encarregados',
							id: 'musicoCol',
                		    sortable: false,
                		    width: 140,
                		    readOnly: true,
							renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
	            				for (i = 0; i < data.length; i++) {
									if(data[i].tipoencarregado == "3"){
										var color = 'black';
										switch(data[i].status){
											case 'vermelho':
												color = '#cc0000';
												break;
											case 'amarelo':
												color = '#cccc00';
												break;
											case 'verde':
												color = '#009900';
												break;
										}
										return '<span style="color:'+color+';">'+data[i].encarregado+'</span>';
									}
								}
	            			}
						  },{
                		    header: '5 Min.',
                		    dataIndex: 'encarregados',
							id: '5minCol',
                		    sortable: false,
                		    width: 140,
                		    readOnly: true,
							renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
	            				for (i = 0; i < data.length; i++) {
									if(data[i].tipoencarregado == "4"){
										var color = 'black';
										switch(data[i].status){
											case 'vermelho':
												color = '#cc0000';
												break;
											case 'amarelo':
												color = '#cccc00';
												break;
											case 'verde':
												color = '#009900';
												break;
										}
										return '<span style="color:'+color+';">'+data[i].encarregado+'</span>';
									}
								}
	            			}
                		  },{
                		    header: 'Novos',
                		    dataIndex: 'novos',
							 id: 'novosCol',
                		    sortable: true,
                		    width: 50,
                		    readOnly: false,
							editor: new Ext.form.TextField({
                		        allowBlank: true,
                		        maxLength: 8,
                		        maxLengthText: "Máximo de 8 caracteres",
                		        maskRe: /[0-9]/
                		        })
                		  },{
                		    header: "Total",
                		    dataIndex: 'total',
							id: 'totalCol',
                		    sortable: true,
                		    width: 50,
                		    readOnly: false,
							editor: new Ext.form.TextField({
                		        allowBlank: true,
                		        maxLength: 8,
                		        maxLengthText: "Máximo de 8 caracteres",
                		        maskRe: /[0-9]/
                		        })
                		  },{
                			  header: "Editor",
							  dataIndex: 'editor',
							  id: 'editorCol',
							  sortable: true,
							  width: 100,
							  readOnly: true
                		  }]
                		),
                    tbar: [{
                        text: 'Incluir',
                        tooltip: 'Inclui um novo registro',
                        iconCls:'add',
                        id: "agenda-create-win-shortcut",
                        handler: function(){
	                    	var module = DevHouseDesktop.getModule("agenda-create-win");
	                    	if(module){
	                    		if(!JanelaAgendaCreateWindow){
	                    			module.createWindow();
	                    		}
	                    		else{
	                    			JanelaAgendaCreateWindow.close();
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
				       	handler : HttpHelpers.excluirRegistro.createDelegate(this, [{grid: 'AgendaListingEditorGrid', url: 'agenda/removeAgenda', campoid: 'idagenda'}], true),
				       	scope : this
				    })
					 , '-', 
					 	'Busca:',
						{
							xtype:'datesearch',
							width:200,
							onTrigger2Click: function(){
								this.validate();
								var d = "";
								if(this.isValid()){
									d = this.getValue();
									if(d != "") d = d.format('Y-m-d');
								}
								AgendaDataStore.load({params:{query:d}});
							}
						}
                     ,'->',
						{
							text: 'Imprimir',
						    tooltip: 'Imprimir',
					        handler: function(){
								window.open('agenda/agendaGridPrint');
							}, 
					        iconCls:'print'
						}
                     ],
                     bbar: new Ext.PagingToolbar({
					 	 id:'barraPaginacao',
                         store: AgendaDataStore,
                         displayInfo: true,
                         pageSize: 15,
                         animate: true,
						 layout: 'toolbar',
						 items:[
							 '-',
							 '<img src="images/vermelho.gif" align="left" />&nbsp;A Confirmar',
							 '-',
							 '<img src="images/amarelo.gif" align="left" />&nbsp;Agendado',
							 '-',
							 '<img src="images/verde.gif" align="left" />&nbsp;Confirmado'
						 ],
                         plugins: new Ext.ux.plugins.ProgressPagingToolbar()
                     })
                 })
            });
        }
        AgendaGridWindow.show();
        AgendaDataStore.load();
        AgendaListingEditorGrid.on('afteredit', salvaAgendaGrid);
        AgendaGridWindow.on('show',function(){
			Ext.select('div.x-progress-text-back').setStyle('margin-top', '1px');
        });
    }
});


function editaAgenda(rowIndex){
	var module = DevHouseDesktop.getModule("agenda-create-win");
	if(module){
		if(!JanelaAgendaCreateWindow){
			module.createWindow();
		}
		else{
			JanelaAgendaCreateWindow.close();
			module.createWindow();
		}
	}

	JanelaAgendaCreateWindow.addListener('show', function(){
		Ext.getCmp('idagendaField').setValue(AgendaDataStore.data.items[rowIndex].data.idagenda);
		Ext.getCmp('dataField').setValue(AgendaDataStore.data.items[rowIndex].data.datahora);
		Ext.getCmp('horaField').setValue(AgendaDataStore.data.items[rowIndex].data.datahora);
		Ext.getCmp('novosField').setValue(AgendaDataStore.data.items[rowIndex].data.novos);
		Ext.getCmp('totalField').setValue(AgendaDataStore.data.items[rowIndex].data.total);
		Ext.getCmp('idlocaisField').setValue(AgendaDataStore.data.items[rowIndex].data.idlocais);
		Ext.getCmp('siteField').setValue(AgendaDataStore.data.items[rowIndex].data.site);
		Ext.getCmp('descField').setValue(AgendaDataStore.data.items[rowIndex].data.desc);
		
		Ext.getCmp('statusLocalField').setValue(AgendaDataStore.data.items[rowIndex].data.statuslocal);
		
		var tip = "";
		
		Ext.getCmp('botaoStatusLocal').setIconClass(AgendaDataStore.data.items[rowIndex].data.statuslocal);
		switch(AgendaDataStore.data.items[rowIndex].data.statuslocal) {
			case 'vermelho':
				tip = 'A Confirmar';
				break;
			case 'amarelo':
				tip = 'Agendado';
				break;
			case 'verde':
				tip = 'Confirmado';
				break;
			default:
				tip = "";
		}
		Ext.getCmp('botaoStatusLocal').setTooltip(tip);
		
		for (var i=0; i<AgendaDataStore.data.items[rowIndex].data.encarregados.length; i++){
			var botao = "";
			var tip = "";
			var campo = "";
			var campoStatus = "";
			
			switch(AgendaDataStore.data.items[rowIndex].data.encarregados[i].tipoencarregado) {
				case '1':
					botao = 'botaoStatusPreletor';
					campoStatus = 'statusPreletorField';
					campo = 'preletorField';
					break;
				case '2':
					botao = 'botaoStatusMestre';
					campoStatus = 'statusMestreField';
					campo = 'mestreField';
					break;
				case '3':
					botao = 'botaoStatusMusico';
					campoStatus = 'statusMusicoField';
					campo = 'musicoField';
					break;
				case '4':
					botao = 'botaoStatuscincoMin';
					campoStatus = 'statuscincoMinField';
					campo = 'cincoMinField';
					break;
			}
			switch(AgendaDataStore.data.items[rowIndex].data.encarregados[i].status) {
				case 'vermelho':
					tip = 'A Confirmar';
					break;
				case 'amarelo':
					tip = 'Agendado';
					break;
				case 'verde':
					tip = 'Confirmado';
					break;
				default:
					tip = "";
			}
			Ext.getCmp(campo).setValue(AgendaDataStore.data.items[rowIndex].data.encarregados[i].idencarregado);
			Ext.getCmp(campoStatus).setValue(AgendaDataStore.data.items[rowIndex].data.encarregados[i].status);
			Ext.getCmp(botao).setIconClass(AgendaDataStore.data.items[rowIndex].data.encarregados[i].status);
			Ext.getCmp(botao).setTooltip(tip);
		}
	}, this);
}

function salvaAgendaGrid(oGrid_event){
	DevHouseDesktop.desktop.salvaGrid({
		url: 'agenda/salvaAgendaGrid',
		params: {
			idagenda: oGrid_event.record.data.idagenda,
			novos: oGrid_event.record.data.novos,
			total: oGrid_event.record.data.total
		}
	}, oGrid_event.grid.store);
}

DevHouseDesktop.AgendaCreateWindow = Ext.extend(Ext.app.Module, {
    id:'agenda-create-win',
    init : function(){
        this.launcher = {
            text: 'Cadastro de Agenda',
            iconCls:'agenda',
            handler : this.createWindow,
            scope: this
        }
    },
    createWindow : function(){
        var desktop = this.app.getDesktop();
        JanelaAgendaCreateWindow = desktop.getWindow('agenda-create-win');
        if(!JanelaAgendaCreateWindow){
        	JanelaAgendaCreateWindow = desktop.createWindow({
            	id: 'AgendaCreateWindow',
            	title: 'Cadastro de Agenda',
				iconCls: 'agenda',
            	closable:true,
            	width: 610,
            	height: 380,
            	plain:true,
            	layout: 'fit',
                items: AgendaCreateForm = new Ext.FormPanel({
                	url: 'agenda/salvaAgenda',
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
				            title: 'Informações Gerais',
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
                					id: 'idagendaField',
                					name: 'idagenda',
                					allowBlank: true,
                					xtype: 'hidden',
                					inputType: 'hidden'
                				},{
									id: 'statusLocalField',
                					name: 'statusLocal',
									value: 'vermelho',
                					allowBlank: true,
                					xtype: 'hidden',
                					inputType: 'hidden'
								},{
									id: 'statusPreletorField',
                					name: 'statusPreletor',
									value: 'vermelho',
                					allowBlank: true,
                					xtype: 'hidden',
                					inputType: 'hidden'
								},{
									id: 'statusMestreField',
                					name: 'statusMestre',
									value: 'vermelho',
                					allowBlank: true,
                					xtype: 'hidden',
                					inputType: 'hidden'
								},{
									id: 'statusMusicoField',
                					name: 'statusMusico',
									value: 'vermelho',
                					allowBlank: true,
                					xtype: 'hidden',
                					inputType: 'hidden'
								},{
									id: 'statuscincoMinField',
                					name: 'status5min',
									value: 'vermelho',
                					allowBlank: true,
                					xtype: 'hidden',
                					inputType: 'hidden'
                				},{
                					id: 'dataField',
                					name: 'data',
                					fieldLabel: 'Data',
                					xtype: 'datefield',
                					allowBlank: false,
                				    anchor : '92%'
                				},{
                					id: 'horaField',
                					name: 'hora',
                					fieldLabel: 'Horário',
                					xtype: 'timefield',
									format:'H:i',
                					allowBlank: false,
                				    anchor : '92%'
								},{
		                	    	xtype:'panel',
									layout: 'column',
		                			border:true,
									anchor : '92%',
									items:[{
										columnWidth:0.87,
										layout: 'form',
										labelAlign: 'top',
										labelWidth: 106,
										items: [{
		                					id: 'idlocaisField',
		                					name: 'locail',
											hiddenName: 'idlocais',
		                					fieldLabel: 'Local',
		                					xtype: 'comboLocais',
											msgTarget: 'qtip',
		                					allowBlank: false,
		                				    anchor : '100%'
			                			}]
									},{
										columnWidth:0.13,
										layout: 'form',
										labelAlign: 'top',
										labelWidth: 106,
										items: [{
											fieldLabel: '&nbsp;',
											id:'botaoStatusLocal',
											labelSeparator: '',
											iconCls:'vermelho',
											tooltip: 'A Confirmar',
		                					xtype: 'button',
											width:16,
											menu:[{
												text:'A Confirmar',
												iconCls: 'vermelho',
												handler : mudaStatusBotao.createDelegate(this, [{botaoDestino: 'botaoStatusLocal', statusField:'statusLocalField'}], true)
											},{
												text:'Agendado',
												iconCls: 'amarelo',
												handler : mudaStatusBotao.createDelegate(this, [{botaoDestino: 'botaoStatusLocal', statusField:'statusLocalField'}], true)
											},{
												text:'Confirmado',
												iconCls: 'verde',
												handler : mudaStatusBotao.createDelegate(this, [{botaoDestino: 'botaoStatusLocal', statusField:'statusLocalField'}], true)
											}]
			                			}]
									}]
								},{
									id: 'novosField',
                					name: 'novos',
                					fieldLabel: 'Novos',
                					xtype: 'textfield',
									allowBlank: true,
	                		        maxLength: 8,
	                		        maxLengthText: "Máximo de 8 caracteres",
	                		        maskRe: /[0-9]/,
									anchor : '92%'
								},{
									id: 'totalField',
                					name: 'total',
                					fieldLabel: 'Total',
                					xtype: 'textfield',
									allowBlank: true,
	                		        maxLength: 8,
	                		        maxLengthText: "Máximo de 8 caracteres",
	                		        maskRe: /[0-9]/,
									anchor : '92%'
                				}]
							},{
				              	layout: 'form',
								labelAlign: 'top',
								border:false,
	                			items: [{
		                	    	xtype:'panel',
									layout: 'column',
		                			border:true,
									anchor : '92%',
									items:[{
										columnWidth:0.87,
										layout: 'form',
										labelAlign: 'top',
										labelWidth: 106,
										items: [{
		                					id: 'preletorField',
		                					name: 'nomepreletor',
											hiddenName: 'preletor',
		                					fieldLabel: 'Preletor',
		                					xtype: 'comboPessoas',
											msgTarget: 'qtip',
		                					allowBlank: false,
		                				    anchor : '100%'
			                			}]
									},{
										columnWidth:0.13,
										layout: 'form',
										labelAlign: 'top',
										labelWidth: 106,
										items: [{
											fieldLabel: '&nbsp;',
											id:'botaoStatusPreletor',
											labelSeparator: '',
											iconCls:'vermelho',
											tooltip: 'A Confirmar',
		                					xtype: 'button',
											width:16,
											menu:[{
												text:'A Confirmar',
												iconCls: 'vermelho',
												handler : mudaStatusBotao.createDelegate(this, [{botaoDestino: 'botaoStatusPreletor', statusField:'statusPreletorField'}], true)
											},{
												text:'Agendado',
												iconCls: 'amarelo',
												handler : mudaStatusBotao.createDelegate(this, [{botaoDestino: 'botaoStatusPreletor', statusField:'statusPreletorField'}], true)
											},{
												text:'Confirmado',
												iconCls: 'verde',
												handler : mudaStatusBotao.createDelegate(this, [{botaoDestino: 'botaoStatusPreletor', statusField:'statusPreletorField'}], true)
											}]
			                			}]
									}]
                				},{
									xtype:'panel',
									layout: 'column',
		                			border:true,
									anchor : '92%',
									items:[{
										columnWidth:0.87,
										layout: 'form',
										labelAlign: 'top',
										labelWidth: 106,
										items: [{
		                					id: 'mestreField',
		                					name: 'nomemestre',
											hiddenName: 'mestre',
		                					fieldLabel: 'Mestre',
											msgTarget: 'qtip',
		                					xtype: 'comboPessoas',
		                					allowBlank: false,
		                				    anchor : '100%'
			                			}]
									},{
										columnWidth:0.13,
										layout: 'form',
										labelAlign: 'top',
										labelWidth: 106,
										items: [{
											fieldLabel: '&nbsp;',
											id:'botaoStatusMestre',
											labelSeparator: '',
											iconCls:'vermelho',
											tooltip: 'A Confirmar',
		                					xtype: 'button',
											width:16,
											menu:[{
												text:'A Confirmar',
												iconCls: 'vermelho',
												handler : mudaStatusBotao.createDelegate(this, [{botaoDestino: 'botaoStatusMestre', statusField:'statusMestreField'}], true)
											},{
												text:'Agendado',
												iconCls: 'amarelo',
												handler : mudaStatusBotao.createDelegate(this, [{botaoDestino: 'botaoStatusMestre', statusField:'statusMestreField'}], true)
											},{
												text:'Confirmado',
												iconCls: 'verde',
												handler : mudaStatusBotao.createDelegate(this, [{botaoDestino: 'botaoStatusMestre', statusField:'statusMestreField'}], true)
											}]
			                			}]
									}]
								},{
									xtype:'panel',
									layout: 'column',
		                			border:true,
									anchor : '92%',
									items:[{
										columnWidth:0.87,
										layout: 'form',
										labelAlign: 'top',
										labelWidth: 106,
										items: [{
		                					id: 'musicoField',
		                					name: 'nomemusico',
											hiddenName: 'musico',
		                					fieldLabel: 'Músico',
		                					xtype: 'comboPessoas',
											msgTarget: 'qtip',
		                					allowBlank: false,
		                				    anchor : '100%'
			                			}]
									},{
										columnWidth:0.13,
										layout: 'form',
										labelAlign: 'top',
										labelWidth: 106,
										items: [{
											fieldLabel: '&nbsp;',
											id:'botaoStatusMusico',
											labelSeparator: '',
											iconCls:'vermelho',
											tooltip: 'A Confirmar',
		                					xtype: 'button',
											width:16,
											menu:[{
												text:'A Confirmar',
												iconCls: 'vermelho',
												handler : mudaStatusBotao.createDelegate(this, [{botaoDestino: 'botaoStatusMusico', statusField:'statusMusicoField'}], true)
											},{
												text:'Agendado',
												iconCls: 'amarelo',
												handler : mudaStatusBotao.createDelegate(this, [{botaoDestino: 'botaoStatusMusico', statusField:'statusMusicoField'}], true)
											},{
												text:'Confirmado',
												iconCls: 'verde',
												handler : mudaStatusBotao.createDelegate(this, [{botaoDestino: 'botaoStatusMusico', statusField:'statusMusicoField'}], true)
											}]
			                			}]
									}]
								},{
									xtype:'panel',
									layout: 'column',
		                			border:true,
									anchor : '92%',
									items:[{
										columnWidth:0.87,
										layout: 'form',
										labelAlign: 'top',
										labelWidth: 106,
										items: [{
		                					id: 'cincoMinField',
		                					name: 'nome5min',
											hiddenName: '5min',
		                					fieldLabel: '5 Minutos',
		                					xtype: 'comboPessoas',
											msgTarget: 'qtip',
		                					allowBlank: false,
		                				    anchor : '100%'
			                			}]
									},{
										columnWidth:0.13,
										layout: 'form',
										labelAlign: 'top',
										labelWidth: 106,
										items: [{
											fieldLabel: '&nbsp;',
											id:'botaoStatuscincoMin',
											labelSeparator: '',
											iconCls:'vermelho',
											tooltip: 'A Confirmar',
		                					xtype: 'button',
											width:16,
											menu:[{
												text:'A Confirmar',
												iconCls: 'vermelho',
												handler : mudaStatusBotao.createDelegate(this, [{botaoDestino: 'botaoStatuscincoMin', statusField:'statuscincoMinField'}], true)
											},{
												text:'Agendado',
												iconCls: 'amarelo',
												handler : mudaStatusBotao.createDelegate(this, [{botaoDestino: 'botaoStatuscincoMin', statusField:'statuscincoMinField'}], true)
											},{
												text:'Confirmado',
												iconCls: 'verde',
												handler : mudaStatusBotao.createDelegate(this, [{botaoDestino: 'botaoStatuscincoMin', statusField:'statuscincoMinField'}], true)
											}]
			                			}]
									}]
								},{
		                	    	xtype:'panel',
									layout: 'column',
		                			border:true,
									items:[{
										columnWidth:1.0,
										layout: 'form',
										labelAlign: 'left',
										labelWidth: 106,
										items: [{
		                					id: 'siteField',
		                					name: 'site',
		                					xtype: 'checkbox',
											fieldLabel: 'Site',
		                					inputType: 'checkbox',
		                					checked: true
			                			}]
									}]
                				}]
							}]
						},{
							bodyStyle: {padding: '5px'},
				            title: 'Comentários',
				            layout: 'form',
							labelAlign: 'left',
							labelWidth: 1,
							frame:true,
				            items: [{
								xtype: 'editorDevHouse',
								id: 'descField',
								name: "desc",
								height: 220,
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
                				AgendaCreateForm.getForm().submit({
		                            method:'POST', 
		     						waitMsg: 'Gravando Dados Aguarde...',
									waitTitle: 'Aguarde',
		    						success:function(){
										if(Ext.getCmp('fechajanelaField').checked) JanelaAgendaCreateWindow.close();
										else{
											if (Ext.getCmp('idagendaField').getValue() == "") {
												Ext.getCmp('idagendaField').setValue('');
												Ext.getCmp('dataField').setValue('');
												Ext.getCmp('horaField').setValue('');
												Ext.getCmp('novosField').setValue('');
												Ext.getCmp('totalField').setValue('');
												Ext.getCmp('idlocaisField').setValue('');
												Ext.getCmp('siteField').setValue('');
												Ext.getCmp('descField').setValue('');
												Ext.getCmp('preletorField').setValue('');
												Ext.getCmp('mestreField').setValue('');
												Ext.getCmp('musicoField').setValue('');
												Ext.getCmp('cincoMinField').setValue('');
												
												Ext.getCmp('statusLocalField').setValue('vermelho');
												Ext.getCmp('statusPreletorField').setValue('vermelho');
												Ext.getCmp('statusMestreField').setValue('vermelho');
												Ext.getCmp('statusPreletorField').setValue('vermelho');
												Ext.getCmp('statusMusicoField').setValue('vermelho');
												Ext.getCmp('statuscincoMinField').setValue('vermelho');
												
												Ext.getCmp('botaoStatusLocal').setIconClass('vermelho');
												Ext.getCmp('botaoStatusPreletor').setIconClass('vermelho');
												Ext.getCmp('botaoStatusMestre').setIconClass('vermelho');
												Ext.getCmp('botaoStatusMusico').setIconClass('vermelho');
												Ext.getCmp('botaoStatuscincoMin').setIconClass('vermelho');
												
												Ext.getCmp('botaoStatusLocal').setTooltip('A Combinar');
												Ext.getCmp('botaoStatusPreletor').setTooltip('A Combinar');
												Ext.getCmp('botaoStatusMestre').setTooltip('A Combinar');
												Ext.getCmp('botaoStatusMusico').setTooltip('A Combinar');
												Ext.getCmp('botaoStatuscincoMin').setTooltip('A Combinar');
												
												Ext.getCmp('idagendaField').clearInvalid('');
												Ext.getCmp('dataField').clearInvalid('');
												Ext.getCmp('horaField').clearInvalid('');
												Ext.getCmp('idlocaisField').clearInvalid('');
												Ext.getCmp('preletorField').clearInvalid('');
												Ext.getCmp('mestreField').clearInvalid('');
												Ext.getCmp('musicoField').clearInvalid('');
												Ext.getCmp('cincoMinField').clearInvalid('');
											}
										}
			            				if(AgendaGridWindow){
			            					if(AgendaGridWindow.isVisible()) AgendaDataStore.reload();
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
                				JanelaAgendaCreateWindow.close();
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
        JanelaAgendaCreateWindow.show();
    }
});


function mudaStatusBotao(botao, evento, opcoes){
	var botaoDestino = Ext.getCmp(opcoes.botaoDestino);
	var statusField = Ext.getCmp(opcoes.statusField);
	botaoDestino.setIconClass(botao.iconCls);
	botaoDestino.setTooltip(botao.text);
	statusField.setValue(botao.iconCls);
}
