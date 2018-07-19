/**
 * @author Leonardo
 */

var AccessController = function(){
 	/*
 	 * action: hide: esconde o componente
 	 *      or disable: desabilita o componente
 	 */
 	var action = "disable";
	var store = new Ext.data.Store({
		//autoLoad:true,
		listeners:{
			exception:HttpHelpers.failHandler
		},
        proxy: new Ext.data.HttpProxy({
        	url: 'pessoas/accessControl',
            method: 'POST'
        }),
        reader: new Ext.data.JsonReader({
        	root: 'rows',
        	totalProperty: 'results'
        },[ 
			{name: "permissao", type: "string", mapping: "permissao"}
        ])
    });
	
	var checkPermission = function(modulo){
		var x = store;
		for(var i = 0; i<store.data.items.length; i++){
			if((store.data.items[i].data.permissao == modulo)|| (store.data.items[i].data.permissao == 'administrador')){
				return true;
			}
		}
		return false;
	}
	
 	return{
 		applyPermission: function(args){
			action = args.action;
			var access = checkPermission(args.modulo);
			
			if(!access){
	 			for (i = 0; i < args.components.length; i++) {
					var el = Ext.getCmp(args.components[i]);
					switch (action) {
						case 'hide':
							el.hide();
							break;
						case 'disable':
							el.disable();
							break;
					}
				}
			}
 			
 		},
		
		applyGridEditorPermission: function(args){
			var access = checkPermission(args.modulo);
			
			if(!access){
	 			for (i = 0; i < args.columnModel.config.length; i++) {
					args.columnModel.config[i].editable = false;
				}
			}
 			
 		},
		
		setUrl: function(url){
			store.proxy.setUrl(url, true);
			//store.reload();
		},
		
		init: function(){
			store.load();
		}
 	}
 }();