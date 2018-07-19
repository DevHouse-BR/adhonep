/**
 * @author Leonardo
 */

var HttpHelpers = function(){
	
	var executaExcluirRegistro = function(btn, input, objeto, parametros){
		var grid = Ext.getCmp(parametros.grid);
		if(btn=='yes'){
			var selections = grid.selModel.getSelections();
			var itens = [];
			for(i = 0; i< grid.selModel.getCount(); i++){
				itens.push(selections[i].json[parametros.campoid]);
			}
			var encoded_array = Ext.encode(itens);
			Ext.Ajax.request({
				waitMsg: 'Aguarde...',
				url: parametros.url, 
				params: { 
					ids:  encoded_array
				}, 
				success: function(response){
					var contentType = response.getResponseHeader('Content-Type');
					if(contentType != "application/json"){
						showMessageBox({msg: "<b>O servidor retornou erro:</b><br /><br />" + response.responseText});
					}
					else{
						var result = Ext.decode(response.responseText);
						if(result.success){
							if(Number(result.qtd) == 1) 
								MyDesktop.desktop.showNotification({title:'Concluido',iconCls:'alerta',html: 'O resgistro foi removido com sucesso!'});
							else
								MyDesktop.desktop.showNotification({title:'Concluido',iconCls:'alerta',html: result.qtd + ' resgistros foram removidos!'});
							grid.store.reload();
						}
						else{
							showMessageBox({msg: result.errormsg});
						}	
					}
				},
				failure: function(response){
					showMessageBox({msg: 'Não foi possível obter conexão com o servidor. Tente mais tarde.'});
				}
			});
		}  
	}
	
	var showMessageBox = function(config){
		var defaults = ({
			title: 'Erro',
			msg: 'Erro ao processar informações no servidor.',
			buttons: Ext.MessageBox.OK,
            icon: Ext.MessageBox.ERROR
		});
		Ext.MessageBox.show(Ext.apply(defaults, config));
	}
	
	return{
		erroHTTP: function(DataProxy, type, action, options, response){
			var titulo = Ext.names.Erro;
			var mensagem = Ext.names.ErroHTTP;
	
			if (response.status == 'communication failure') {
				mensagem = Ext.names.ErroHTTPComunication;
			}
			else if (response.status == '404') {
				mensagem = Ext.names.ErroHTTP404;
			}
			else if (response.status == '200') {
				mensagem = Ext.names.ErroHTTPNotJSON + response.responseText;
			}
			showMessageBox({title:titulo, msg: mensagem});
		},
		
		
		excluirRegistro: function(btn, event, parametros){
			var grid = Ext.getCmp(parametros.grid);
	
			if(grid.selModel.getCount() == 1)	{
				Ext.MessageBox.confirm('Confirmação','Deseja remover o resgistro selecionado?', executaExcluirRegistro.createDelegate(this, parametros, true));
			}
			else if(grid.selModel.getCount() > 1){
				Ext.MessageBox.confirm('Confirmação','Deseja remover os resgistros selecionados?', executaExcluirRegistro.createDelegate(this, parametros, true));
			} 
			else {
				showMessageBox({title:'Aten&ccedil;&atilde;o!', msg: 'Nenhum registro selecionado', icon: Ext.MessageBox.WARNING});
			}
		},
		
		salvaGrid: function(config, store){
			Ext.Ajax.request(Ext.apply({
				waitMsg: 'Aguarde...',
				url: 'grid/urlPadrao',
				params: {
					parametro: "Parametro padrão"
				},
				success: function(response){
						var contentType = response.getResponseHeader('Content-Type');
						if(contentType != "application/json"){
							showMessageBox({msg: "<b>O servidor retornou erro:</b><br /><br />" + response.responseText});
						}
						else{
							var result = Ext.decode(response.responseText);
							if(result.success){
								MyDesktop.desktop.showNotification({title:'Concluido',iconCls:'alerta',html: 'Alterações gravadas com sucesso!'});
								store.commitChanges();
							}
							else{
								showMessageBox({msg: result.errormsg});
							}	
						}
					},
					failure: function(response){
						showMessageBox({msg: 'Não foi possível obter conexão com o servidor. Tente mais tarde.'});
					}
			}, config));
		},
		
		formFailure:function(form, action){
			if (action.failureType === Ext.form.Action.CONNECT_FAILURE) {
				showMessageBox({msg: "<b>Erro de comunicação com o Servidor:</b><br /><br />" + 'Status '+action.response.status+': '+ action.response.statusText});
            }
			if((action.failureType === Ext.form.Action.SERVER_INVALID)||(action.failureType === Ext.form.Action.LOAD_FAILURE)){
				var contentType = action.response.getResponseHeader('Content-Type');
				if (contentType != "application/json") {
					showMessageBox({msg: "<b>O servidor retornou erro:</b><br /><br />" + action.response.responseText});
				}
				else{
					obj = Ext.decode(action.response.responseText);
					showMessageBox({msg: obj.errors.errormsg});
				}
		    }
		},
		
		
		failHandler: function(){
			alert(HttpHelpers.failHandler.arguments.length);
			
			switch(HttpHelpers.failHandler.arguments.length) {
				case 2:
					var form = HttpHelpers.failHandler.arguments[0];
					var action = HttpHelpers.failHandler.arguments[1];

					if (action.failureType === Ext.form.Action.CONNECT_FAILURE) {
						showMessageBox({msg: "<b>Erro de comunicação com o Servidor:</b><br /><br />" + 'Status '+action.response.status+': '+ action.response.statusText});
		            }
					else{
						var contentType = action.response.getResponseHeader('Content-Type');
						if (contentType != "application/json") {
							showMessageBox({msg: "<b>O servidor retornou erro:</b><br /><br />" + action.response.responseText});
						}
						else{
							obj = Ext.decode(action.response.responseText);
							showMessageBox({msg: obj.errors.errormsg});
						}
				    }
					break;
				case 5:
					var DataProxy = HttpHelpers.failHandler.arguments[0];
					var type = HttpHelpers.failHandler.arguments[1];
					var action = HttpHelpers.failHandler.arguments[2];
					var options = HttpHelpers.failHandler.arguments[3];
					var response = HttpHelpers.failHandler.arguments[4];
					var titulo = Ext.names.Erro;
					var mensagem = Ext.names.ErroHTTP;
			
					if (response.status == 'communication failure') {
						mensagem = Ext.names.ErroHTTPComunication;
					}
					else if (response.status == '404') {
						mensagem = Ext.names.ErroHTTP404;
					}
					else if (response.status == '200') {
						mensagem = Ext.names.ErroHTTPNotJSON + response.responseText;
					}
					showMessageBox({title:titulo, msg: mensagem});
					break;
				default:
					showMessageBox({msg: 'Não foi possível obter conexão com o servidor. Tente mais tarde.'});
					break;
			}

			
			/* EVENTO FAILURE DO EXT.AJAX.REQUEST
			 * 
			 * failure: function(response){
						showMessageBox({msg: 'Não foi possível obter conexão com o servidor. Tente mais tarde.'});
					}
			 */
			
			
			/* EVENTO  DO FORM ACTION
			 * 
			 * 
			 * formFailure:function(form, action){
				if (action.failureType === Ext.form.Action.CONNECT_FAILURE) {
					showMessageBox({msg: "<b>Erro de comunicação com o Servidor:</b><br /><br />" + 'Status '+action.response.status+': '+ action.response.statusText});
	            }
				if((action.failureType === Ext.form.Action.SERVER_INVALID)||(action.failureType === Ext.form.Action.LOAD_FAILURE)){
					var contentType = action.response.getResponseHeader('Content-Type');
					if (contentType != "application/json") {
						showMessageBox({msg: "<b>O servidor retornou erro:</b><br /><br />" + action.response.responseText});
					}
					else{
						obj = Ext.decode(action.response.responseText);
						showMessageBox({msg: obj.errors.errormsg});
					}
			    }
			}
			 */
			
			
			/* EVENTO EXCEPTION DO HTTPPROXY DO DATA.STORE
			 * 
			 * erroHTTP: function(DataProxy, type, action, options, response){
				var titulo = Ext.names.Erro;
				var mensagem = Ext.names.ErroHTTP;
		
				if (response.status == 'communication failure') {
					mensagem = Ext.names.ErroHTTPComunication;
				}
				else if (response.status == '404') {
					mensagem = Ext.names.ErroHTTP404;
				}
				else if (response.status == '200') {
					mensagem = Ext.names.ErroHTTPNotJSON + response.responseText;
				}
				showMessageBox({title:titulo, msg: mensagem});
			},
			 */
			
			
		}
	}
}();
