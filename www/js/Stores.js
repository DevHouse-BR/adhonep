/**
 * @author Leonardo
 */

Ext.namespace('DevHouseDesktop.Stores');

DevHouseDesktop.Stores.storeAtributosPessoais = new Ext.data.Store({
    remoteSort: true,
	listeners:{
		exception:HttpHelpers.failHandler
	},
    proxy: new Ext.data.HttpProxy({
    	url: 'atributospessoais/atributospessoaisCheckBoxGroup',
        method: 'POST'
    }),
    reader: new Ext.data.JsonReader({
    	root: 'rows',
    	totalProperty: 'results'
    },[
       	{name: "idatributospessoais", type: "int", mapping: "idatributospessoais"},
		{name: "atributo", type: "string", mapping:"atributo"},
		{name: "aplicacao", type: "int", mapping:"aplicacao"}
    ]),
    sortInfo:{field: 'atributo', direction: "ASC"}
});

DevHouseDesktop.Stores.storePermissoes = new Ext.data.Store({
    id: 'PermissoesStore',
    remoteSort: true,
	listeners:{
		exception:HttpHelpers.failHandler
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