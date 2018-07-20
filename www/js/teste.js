/**
 * @author Leonardo
 */

Ext.namespace("DevHouseDesktop.GridTeste");
DevHouseDesktop.GridTeste.gridTesteConfig = {
	storeConfig: {
		id: 'id-datastore-grid-pessoas',
		sortInfo: {
			field: 'nome',
			direction: "ASC"
		}
	},
	readerFields:[
	   	{name: "id", type: "int", mapping: "id"},
		{name: "empresa", type: "string", mapping:"empresa"},
		{name: "valor", type: "string", mapping: "valor"},
		{name: "variacao", type: "string", mapping: "variacao"},
		{name: "percentual", type: "string", mapping: "percentual"},
		{name: "data", type: "string", mapping: "data"}
	],
	
	columnModelConfig:[{
		header: Ext.names.Editar,
		readOnly: true,
		dataIndex: 'id',
		width: 40,
		sortable: false,
		renderer:  function(data, cell, record, rowIndex, columnIndex, store) {
			return '<img style="cursor:pointer" src="images/user_edit.png" ext:qtitle="' + Ext.names.Editar + '" ext:qwidth="150" ext:qtip="' + Ext.names.EditarTip +'" />';
		}
	},{
		header: "Empresa",
		id:'id-col-teste-empresa',
		dataIndex: 'empresa',
		sortable: true,
		width: 170
	},{
		header: "Valor",
		dataIndex: 'valor',
		sortable: true,
		width: 80
	},{
		header: "Variacao",
		dataIndex: 'variacao',
		sortable: true,
		width: 80
	},{
		header: "%",
		dataIndex: 'percentual',
		sortable: true,
		width: 80
	},{
		header: "Data",
		dataIndex: 'data',
		sortable: true,
		width: 80
	}],
	gridConfig:{
		getUrl:'teste/testeGrid',
		putUrl: 'teste/salvaTesteGrid',
		deleteUrl: 'teste/removeTeste',
		formModule: 'id-modulo-form-teste',
		formModuleWindow:'id-window-form-teste',
		flex: 1,
		id: 'id-grid-teste',
		autoExpandColumn: 'id-col-teste-empresa',
		listeners:{
			render: function(){
				AccessController.applyPermission({action:'hide',components:['id-btn-incluir-teste','id-btn-excluir-teste'], modulo:'pessoas'});
				AccessController.applyGridEditorPermission({modulo:'pessoas', columnModel: this.getColumnModel()});
			}
		}
	},
	tbarConfig: [{
		posicao: 0,
		aplicar: true,
		id: "id-btn-incluir-teste",
		grid:'id-grid-teste'
	},{
		posicao: 1,
		aplicar: true,
		id: "id-btn-excluir-teste"
	}]
}


DevHouseDesktop.ModuloGridTeste = Ext.extend(Ext.app.Module, {
    id:'id-modulo-grid-teste',
	windowId:'id-window-grid-teste',
    init : function(){
        this.launcher = {
            text: Ext.names.GridPessoasTitle,
            iconCls:'pessoas',
            handler : this.createWindow,
            scope: this
        }
    },
	
	createWindow : function(){
		var desktop = this.app.getDesktop();
		GridTesteWindow = desktop.getWindow(this.windowId);
		if (!GridTesteWindow) {
			GridTesteWindow = desktop.createWindow({
				id: this.windowId,
				title: Ext.names.GridPessoasTitle,
				width: 740,
				height: 480,
				iconCls: 'pessoas',
				shim: false,
				 layout: 'hbox',
				layoutConfig:{
					align: 'stretch'
				},
				items: new ClassesBase.Grids.GridEditorBasico(DevHouseDesktop.GridTeste.gridTesteConfig),
				listeners:{
					show: function(){
						Ext.select('div.x-progress-text-back').setStyle('margin-top', '1px');
					},
					close: function(){
						delete GridTesteWindow;
					}
				}
			});
		}
		GridTesteWindow.show();
	}
});