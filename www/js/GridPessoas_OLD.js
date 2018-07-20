/**
* @author Leonardo
*/
DevHouseDesktop.GridPessoas = Ext.extend(Ext.app.Module, {
    id:'id-modulo-grid-pessoas',
    init : function(){
        this.launcher = {
            text: Ext.names.GridPessoasTitle,
            iconCls:'pessoas',
            handler : this.createWindow,
            scope: this
        }
    },
	
	// Abre janela de edição ---------------------------------------------------------------------------------------------------------------------------------------------
	editaPessoa: function (rowIndex){
		var module = DevHouseDesktop.getModule("pessoas-create-win");
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
	},

	// Salva Alterações Grid---------------------------------------------------------------------------------------------------------------------------------------------
	salvaPessoaGrid: function (oGrid_event){
		HttpHelpers.salvaGrid({
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
	},
	
	// DATA STORE ATRIBUTOS PESSOAIS---------------------------------------------------------------------------------------------------------------------------------------------
	storeAtributosPessoais: new Ext.data.Store({
	    id: 'AtributosPessoaisStore',
	    remoteSort: true,
		autoLoad: true,
		listeners:{
			exception:HttpHelpers.failHandler
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
	}),
	
	// FUNÇÃO PARA POPULAR RADIO BUTTONS GROUP DA PESQUISA-------------------------------------------------------------------------------------------------------------------------
	ArrayAtributosPessoaisRadios: [],
	
	populateRadioAtributosPessoais: function(){
		this.ArrayAtributosPessoaisRadios = [];
		for (i=0; i<this.storeAtributosPessoais.data.length;i++){
			if ((this.storeAtributosPessoais.data.items[i].data.aplicacao == 1) || (this.storeAtributosPessoais.data.items[i].data.aplicacao == 3)) {
				this.ArrayAtributosPessoaisRadios.push({
					boxLabel: this.storeAtributosPessoais.data.items[i].data.atributo,
					name: 'idatributospessoais',
					inputValue: this.storeAtributosPessoais.data.items[i].data.idatributospessoais
				});
			}
		}
	},
	

	// Abre Janela-------------------------------------------------------------------------------------------------------------------------------------------------------
    createWindow : function(){
		
		this.populateRadioAtributosPessoais();

		// DATA STORE-------------------------------------------------------------------------------------------------------------------------------------------------------
		this.dataStore = new Ext.data.Store({
			autoLoad: true,
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
				exception:HttpHelpers.failHandler,
				load: function(){
					for (var i = 0; i < this.data.length; i++) {
						new Ext.ToolTip({        
					        title: this.data.items[i].data.nome,
					        target: 'id-pessoas-desc-tip-' + i,
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
				totalProperty: 'results'
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
		});

		
		// COLUMN MODEL-------------------------------------------------------------------------------------------------------------------------------------------------------
		this.gridColumnModel = new Ext.grid.ColumnModel(
			[{
				header: Ext.names.Editar,
				readOnly: true,
				dataIndex: 'idpessoas',
				width: 40,
				sortable: false,
				renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
					return '<a href="javascript: DevHouseDesktop.GridPessoas.prototype.editaPessoa(' + rowIndex + ')"><img src="images/user_edit.png" ext:qtitle="' + Ext.names.Editar + '" ext:qwidth="150" ext:qtip="' + Ext.names.EditarTip +'" /></a>';
				}
			},{
				header: Ext.names.PessoasNomeField,
				dataIndex: 'nome',
				id: 'id-col-pessoas-nome',
				sortable: true,
				width: 170,
				renderer:  function(data, cell, record, rowIndex, columnIndex, store) {						
					return '<div style="cursor:pointer" id="id-pessoas-desc-tip-' + rowIndex + '"><img src="images/user_comment.png" align="left" />&nbsp;' + data + '</div>';
				},
				editor: new Ext.form.TextField({
					allowBlank: false,
					maxLengthText: "Máximo de 255 caracteres",
					maxLength: 255,
					maskRe: /([a-zA-Z'\.áéíóúÁÉÍÓÚÇçàÀãÃâÂêÊôÔüÜñÑ\s]+)$/
				})
			},{
				header: Ext.names.PessoasEmailField,
				dataIndex: 'email',
				sortable: true,
				id: 'id-col-pessoas-email',
				width: 150,
				editor: new Ext.form.TextField({
					allowBlank: false,
					maxLength: 255,
					maskRe: Ext.form.VTypes.emailMask
				})
			},{
				header: Ext.names.PessoasTelefoneField,
				dataIndex: 'telefone',
				sortable: true,
				width: 80,
				readOnly: false,
				editor: new Ext.ux.campoTelefone({
					allowBlank: true,
					maxLength: 16,
					maskRe: /[0-9]/
				})
			},{
				header: Ext.names.PessoasCelularField,
				dataIndex: 'celular',
				sortable: true,
				width: 80,
				readOnly: false,
				editor: new Ext.ux.campoCelular({
					allowBlank: true,
					maxLength: 16,
					maskRe: /[0-9]/
				})
			},{
				header: Ext.names.PessoasCidadeField,
				dataIndex: 'idcidades',
				sortable: true,
				width: 80,
				readOnly: false,
				renderer: Ext.util.Format.comboRenderer(comboCidades), 
				editor: comboCidades
			},{
				header: Ext.names.PessoasPreletorField,
				dataIndex: 'participacoes',
				id: 'id-col-pessoas-preletor',
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
				header: Ext.names.PessoasMestreField,
				dataIndex: 'participacoes',
				id: 'id-col-pessoas-mestre',
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
				header: Ext.names.PessoasMusicoField,
				dataIndex: 'participacoes',
				id: 'id-col-pessoas-musico',
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
				header: Ext.names.Pessoas5MinField,
				dataIndex: 'participacoes',
				id: 'id-col-pessoas-5Min',
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
				header: Ext.names.PessoasAcessoField,
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
						data: [[0, Ext.names.Nao], [1, Ext.names.Sim]]
					}),
					valueField: 'acesso',
					displayField: 'desc'
				})
			}]
		);
		
		// EDITOR GRID-------------------------------------------------------------------------------------------------------------------------------------------------------
		var grid = new Ext.grid.EditorGridPanel({
			id: 'id-grid-pessoas',
			stripeRows:true,
			loadMask: true,
			flex: 1,
			clicksToEdit:2,
			autoExpandColumn: 'id-col-pessoas-nome',
			selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
			viewConfig: {
				autoFill: true,
			    forceFit:true
			},
			listeners:{
				render: function(){
					AccessController.applyPermission({action:'hide',components:['id-btn-incluir-pessoas','id-btn-excluir-pessoas'], modulo:'pessoas'});
					AccessController.applyGridEditorPermission({modulo:'pessoas', columnModel: this.getColumnModel()});
				},
				afteredit: this.salvaPessoaGrid
			},
			store: this.dataStore,
			cm: this.gridColumnModel,
			tbar: [{
			    text: Ext.names.Incluir,
			    tooltip: Ext.names.IncluirTip,
			    iconCls:'add',
			    id: "id-btn-incluir-pessoas",
			    handler: function(){
			    	var module = DevHouseDesktop.getModule("id-modulo-form-pessoas");
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
			   	text: Ext.names.Excluir,
				tooltip: Ext.names.ExcluirTip,
				id: "id-btn-excluir-pessoas",
				iconCls:'remove',
				align:"right",
			   	handler : HttpHelpers.excluirRegistro.createDelegate(this, [{grid: 'id-grid-pessoas', url: 'pessoas/removePessoas', campoid:'idpessoas'}], true),
			   	scope : this
			 })
			 , '-', 
			 	Ext.names.Pesquisar,
				{
					xtype: 'searchfield',
			        width:240,
					id:'buscafield',
					hideMode: 'offsets',
					store: this.dataStore,
					paramName: 'query'
				}
			 ,'-',
				 {
				 	text: Ext.names.ParticipacoesEmReunioes,
					tooltip: Ext.names.ParticipacoesEmReunioesTip,
					iconCls:'user-chart',
			        enableToggle: true,
					pressed: false,
			        toggleHandler: function onItemToggle(item, pressed){
						if(pressed){
							grid.getColumnModel().setHidden(6, false);
							grid.getColumnModel().setHidden(7, false);
							grid.getColumnModel().setHidden(8, false);
							grid.getColumnModel().setHidden(9, false);
						}
						else{
							grid.getColumnModel().setHidden(6, true);
							grid.getColumnModel().setHidden(7, true);
							grid.getColumnModel().setHidden(8, true);
							grid.getColumnModel().setHidden(9, true);
						}
				    }
			},'->',
				{
					text: Ext.names.Imprimir,
				    tooltip: Ext.names.ImprimirTip,
			        handler: function(){
						window.open('pessoas/pessoasGridPrint')
					}, 
			        iconCls:'print'
				}
			 ],
			 bbar: new Ext.PagingToolbar({
			     store: this.dataStore,
			     displayInfo: true,
			     pageSize: 15,
			     animate: true,
			     plugins: new Ext.ux.plugins.ProgressPagingToolbar()
			 })
		});
		
		
		// PAINEL FILTROS-------------------------------------------------------------------------------------------------------------------------------------------------------
		var painelFiltros = {
			title: Ext.names.FiltrosDePesquisa,
			id:'id-panel-filtros-pessoas',
			region: 'north',
			frame:true,
			forceLayout:true,
			height: 150,
			minSize: 75,
			maxSize: 270,
			cmargins: '0 0 5 0',
			items:[{
				xtype:'form',
				id:'id-form-filtro-pessoas',
				layout:'form',
				monitorValid:true,
				labelWidth:70,
				items:[{
					name: 'nome',
					fieldLabel: Ext.names.PessoasNomeField,
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
			        items: this.ArrayAtributosPessoaisRadios
				}],
				buttons:[{
					text: Ext.names.Pesquisar,
					iconCls:'busca',
					style:'margin-top:-5px;',
					formBind: true,
					scope: this,
					handler:function(botao){
						this.dataStore.baseParams['query'] = Ext.getCmp('id-form-filtro-pessoas').getForm().getValues()['nome'];
						this.dataStore.baseParams['idatributospessoais'] = Ext.getCmp('id-form-filtro-pessoas').getForm().getValues()['idatributospessoais'];
				        this.dataStore.reload();
						this.dataStore.baseParams['idatributospessoais'] = "";
					}
				}]
			}]
		};
		
		// CONFIGURAÇÕES DA JANELA-------------------------------------------------------------------------------------------------------------------------------------------------------
		//populateRadioAtributosPessoais();
        var desktop = this.app.getDesktop();
        GridPessoasWindow = desktop.getWindow('id-window-grid-pessoas');
        if(!GridPessoasWindow){
        	GridPessoasWindow = desktop.createWindow({
                id: 'id-window-grid-pessoas',
                title:Ext.names.GridPessoasTitle,
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
                items:[
					painelFiltros,
				{
				    region: 'center',
					collapsible: false,
					xtype:'container',
				    cmargins: '5 0 0 0',
					layout: 'hbox',
					layoutConfig:{
						align: 'stretch',
						pack  : 'start'
					},
					items:grid
				}],
				listeners:{
					show: function(){
						Ext.getCmp('id-panel-filtros-pessoas').expand();
						Ext.select('div.x-progress-text-back').setStyle('margin-top', '1px');
						var task = new Ext.util.DelayedTask(function(){
						    Ext.getCmp('id-panel-filtros-pessoas').collapse();
						});
						task.delay(500);
						var task2 = new Ext.util.DelayedTask(function(){
							var x = document.getElementById('id-panel-filtros-pessoas-xcollapsed');
							x.innerHTML = '<div class="x-collapsed-title"><img src="images/application_form_magnify.png" align="left" /> Filtros de Pesquisa</div>' + x.innerHTML;
						});
						task2.delay(1000);
					},
					close: function(){
						comboCidades = new Ext.ux.comboCidades();
					}
				}
            });
        }
		GridPessoasWindow.show();
	}
});