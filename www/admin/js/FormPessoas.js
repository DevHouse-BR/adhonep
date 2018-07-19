/**
 * @author Leonardo
 */
Ext.namespace("DevHouseDesktop.FormPessoas");

DevHouseDesktop.FormPessoas.checkBoxGroupAtributosPessoais = {
	id:'id-field-pessoas-atributospessoais',
	xtype: 'checkboxgroup',
    fieldLabel: Ext.names.FormPessoasAtributosFieldLabel,
    columns: 4,
    vertical: false,
	items:[{}]
}

DevHouseDesktop.FormPessoas.checkBoxGroupPermissoes = {
	xtype: 'checkboxgroup',
	id: 'id-field-pessoas-permissoes',
	fieldLabel: Ext.names.FormPessoasPermissoesFieldLabel,
	vertical: true,
	columns: 2,
	items: [{}]
}

DevHouseDesktop.FormPessoas.formPessoasConfig = {
	formConfig:{
		id:'id-form-pessoas',
		url: 'pessoas/salvaPessoa',
		carregaRegistro:false,
		loadUrl:'pessoas/getPessoa/',
		windowId:'id-window-form-pessoas',
		reader:new Ext.data.JsonReader({
			root: 'rows',
			fields:[
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
				{name:'id-field-pessoas-atributospessoais', type: 'auto'},
				{name:'id-field-pessoas-permissoes', type: 'auto'},
				{name:'participacoes', type: 'auto'},
				{name: "desc", type: "string", mapping: "desc"}
			]
		}),
		listeners:{
			beforerender: function(painel){
				var checkboxgroup = Ext.getCmp('id-field-pessoas-atributospessoais');
				var store = DevHouseDesktop.Stores.storeAtributosPessoais;
				checkboxgroup.items = [];
				for (i=0; i<store.data.length;i++){
					if ((store.data.items[i].data.aplicacao == 1) || (store.data.items[i].data.aplicacao == 3)) {
						checkboxgroup.items.push({
							boxLabel: store.data.items[i].data.atributo,
							name: 'idatributospessoais[' + store.data.items[i].data.idatributospessoais + ']',
							inputValue: store.data.items[i].data.idatributospessoais
						});
					}
				}
				var checkboxgroup = Ext.getCmp('id-field-pessoas-permissoes');
				var store = DevHouseDesktop.Stores.storePermissoes;
				checkboxgroup.items = [];
				for (i=0; i<store.data.length;i++){
					for (i=0; i<store.data.length;i++){
						checkboxgroup.items.push({
							boxLabel: store.data.items[i].data.permissao,
							name: 'idpermissoes['+store.data.items[i].data.idpermissoes+']',
							inputValue: store.data.items[i].data.idpermissoes
						});
					}
				}
			}
		}
	},

	formItems: [{
		xtype: 'tabpanel',
		deferredRender:false,
		border: false,
		frame:true,
		activeTab: 0,
		items:[{
			bodyStyle: {padding: '5px'},
	        title: Ext.names.PessoasFormInformacoesPessoais,
			layout: 'column',
			frame:true,
	        defaults: {
	            columnWidth: 0.5
	        },
	        items: [{
				layout: 'form',
				border:false,
				items:[{
					name: 'idpessoas',
					allowBlank: true,
					xtype: 'hidden',
					inputType: 'hidden'
				},{
					name: 'nome',
					fieldLabel: 'Nome',
					xtype: 'textfield',
					inputType: 'text',
					allowBlank: false,
				    maxLength: 255,
				    anchor : '92%',
				    maskRe: /([a-zA-Z\.'áéíóúÁÉÍÓÚÇçàÀãÃâÂêÊôÔüÜñÑ\s]+)$/
				},{
					name: 'telefone',
					fieldLabel: 'Telefone',
					xtype: 'campoTelefone',
					inputType: 'text',
					allowBlank: true,
				    maxLength: 16,
				    anchor : '92%',
				    maskRe: /[0-9]/
				},{
					name: 'senha',
					id:'id-field-pessoas-senha',
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
					name: 'email',
					id:'id-field-pessoas-email',
					fieldLabel: 'Email',
					xtype: 'textfield',
					inputType: 'text',
					allowBlank: false,
				    maxLength: 255,
				    anchor : '93%',
				    maskRe: Ext.form.VTypes.emailMask
				},{
					name: 'celular',
					fieldLabel: 'Celular',
					xtype: 'campoCelular',
					inputType: 'text',
					allowBlank: true,
				    maxLength: 16,
				    anchor : '93%',
				    maskRe: /[0-9]/
				},{
					name: 'confirmaSenha',
					id:'id-field-pessoas-confirmasenha',
					fieldLabel: 'Confirmação da Senha',
					xtype: 'textfield',
					inputType: 'password',
					initialPasswordField: 'id-field-pessoas-senha',
					allowBlank: true,
				    maxLength: 16,
				    anchor : '93%'
				}]
			},{
				columnWidth:1.0,
				layout: 'form',
				border:false,
				items: [{
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
				name: "desc",
				height: 350,
				anchor: '100%'
			}]
		},{
			bodyStyle: {padding: '5px'},
	        title: 'Atributos Pessoais',
	        layout: 'form',
			frame:true,
	        items: DevHouseDesktop.FormPessoas.checkBoxGroupAtributosPessoais
		},{
			bodyStyle: {padding: '5px'},
	        title: 'Permissões',
	        layout: 'form',
			frame:true,
	        items: DevHouseDesktop.FormPessoas.checkBoxGroupPermissoes
		}]
	}]
}

