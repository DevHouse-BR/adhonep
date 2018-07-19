/**
 * @author Leonardo
 */
Ext.namespace("DevHouseDesktop.GridPessoas");

DevHouseDesktop.GridPessoas.radioGroupFiltro = {
	xtype: 'radiogroup',
	id:'id-painel-filtros-radiogroupfiltro',
	columns: 4,
	vertical: false,
	allowBlank: false,
	items:[{}]
}

DevHouseDesktop.GridPessoas.painelFiltros = {
	title: Ext.names.FiltrosDePesquisa,
	id:'id-painel-filtros-pessoas',
	region: 'north',
	frame:true,
	forceLayout:true,
	height: 150,
	minSize: 75,
	maxSize: 270,
	cmargins: '0 0 5 0',
	listeners:{
		beforerender: function(painel){
			var radiogroup = Ext.getCmp('id-painel-filtros-radiogroupfiltro');
			var store = DevHouseDesktop.Stores.storeAtributosPessoais;
			radiogroup.items = [];
			for (i=0; i<store.data.length;i++){
				if ((store.data.items[i].data.aplicacao == 1) || (store.data.items[i].data.aplicacao == 3)) {
					radiogroup.items.push({
						boxLabel: store.data.items[i].data.atributo,
						name: 'idatributospessoais',
						inputValue: store.data.items[i].data.idatributospessoais
					});
				}
			}
		}
	},
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
		},
		DevHouseDesktop.GridPessoas.radioGroupFiltro
		],
		buttons:[{
			text: Ext.names.Pesquisar,
			iconCls:'busca',
			style:'margin-top:-5px;',
			formBind: true,
			scope: this,
			handler:function(botao){
				var dataStore = Ext.StoreMgr.get('id-datastore-grid-pessoas');
				dataStore.baseParams['query'] = Ext.getCmp('id-form-filtro-pessoas').getForm().getValues()['nome'];
				dataStore.baseParams['idatributospessoais'] = Ext.getCmp('id-form-filtro-pessoas').getForm().getValues()['idatributospessoais'];
		        dataStore.reload();
				dataStore.baseParams['idatributospessoais'] = "";
			}
		}]
	}]
}


DevHouseDesktop.GridPessoas.gridPessoasConfig = {
	
	storeConfig:{
		id:'id-datastore-grid-pessoas',
		sortInfo:{field: 'nome', direction: "ASC"},
		listeners:{
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
		}
	},
	
	readerFields:[
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
	],
	
	columnModelConfig:[{
			header: Ext.names.Editar,
			readOnly: true,
			dataIndex: 'idpessoas',
			width: 40,
			sortable: false,
			renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
				return '<img style="cursor:pointer" src="images/user_edit.png" ext:qtitle="' + Ext.names.Editar + '" ext:qwidth="150" ext:qtip="' + Ext.names.EditarTip +'" />';
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
			id: 'id-col-pessoas-cidades',
			dataIndex: 'idcidades',
			sortable: true,
			width: 80,
			readOnly: false,
			renderer: Ext.util.Format.comboRenderer(comboCidades), 
			//editor: comboCidades
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
						cell.css = "naoverificado";
						return "&nbsp;";
					case 1:
						cell.css = "verificado";
						return "&nbsp;";
				}                            
			},
			editor: comboAcesso = new Ext.form.ComboBox({
				editable:false,
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
	}],
	
	gridConfig:{
		getUrl:'pessoas/pessoasGrid',
		putUrl: 'pessoas/salvaPessoaGrid',
		deleteUrl: 'pessoas/removePessoas',
		formModule: 'id-modulo-form-pessoas',
		formModuleWindow:'id-window-form-pessoas',
		//relativePath: ''
		flex: 1,
		id: 'id-grid-pessoas',
		autoExpandColumn: 'id-col-pessoas-nome',
		listeners:{
			render: function(){
				AccessController.applyPermission({action:'hide',components:['id-btn-incluir-pessoas','id-btn-excluir-pessoas'], modulo:'pessoas'});
				AccessController.applyGridEditorPermission({modulo:'pessoas', columnModel: this.getColumnModel()});
			}
		}
	},
	
	tbarConfig: [{
		posicao: 0,
		aplicar: true,
		id: "id-btn-incluir-pessoas",
		grid:'id-grid-pessoas'
	},{
		posicao: 1,
		aplicar: true,
		id: "id-btn-excluir-pessoas"
		//handler : HttpHelpers.excluirRegistro.createDelegate(this, [{grid: 'id-grid-pessoas', url: 'pessoas/removePessoas', campoid:'idpessoas'}], true)
	},{
		posicao: 2,
		text: Ext.names.ParticipacoesEmReunioes,
		tooltip: Ext.names.ParticipacoesEmReunioesTip,
		iconCls: 'user-chart',
		enableToggle: true,
		pressed: false,
		toggleHandler: function onItemToggle(item, pressed){
			var grid = Ext.getCmp('id-grid-pessoas');
			if (pressed) {
				grid.getColumnModel().setHidden(6, false);
				grid.getColumnModel().setHidden(7, false);
				grid.getColumnModel().setHidden(8, false);
				grid.getColumnModel().setHidden(9, false);
			}
			else {
				grid.getColumnModel().setHidden(6, true);
				grid.getColumnModel().setHidden(7, true);
				grid.getColumnModel().setHidden(8, true);
				grid.getColumnModel().setHidden(9, true);
			}
		}
	},{
		posicao: 7,
		aplicar: true,
		handler: function(){
			window.open('pessoas/pessoasGridPrint')
		}
	}]
}