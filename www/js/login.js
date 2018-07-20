var login;

Ext.onReady(function(){
    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
	
	 var hideMask = function () {
        Ext.get('loading').remove();
        Ext.fly('loading-mask').fadeOut({
            remove:true
        });
    }
    hideMask.defer(250);

    login = new Ext.FormPanel({
        url:'login/doLogin',
		id:'id-form-login',
		iconCls: 'cadeado',
        frame:true,
        title:'Login',
        bodyStyle: 'padding:10px;',
		monitorValid:true,
		layout:'hbox',
		items:[{
        	html: '<img src="images/login.png" width="48" height="48" />',
        	flex: 1
		},{
			flex:4,
			layout:'form',
			labelAlign:'left',
			labelWidth: 40,
			height:100,						
			defaultType:'textfield',
			items:[{
                fieldLabel: 'Email', 
                name: 'loginUsername',
				id: 'loginUsername',
                allowBlank:false,
				blankText: "Informe o usuário",
				width: '90%',
				value: 'contato@devhouse.com.br',
				listeners:{
					specialkey:function(owner,e){
						if (e.getKey() == 13){
							var valid = true;
							var f = Ext.getCmp('id-form-login');
							f.form.items.each(function(f){
					            if(!f.isValid(true)){
					                valid = false;
					                return false;
					            }
					        });

						}
						if(valid) doLogin();
					}
				}
            },{ 
                fieldLabel:'Senha',
				xtype:'passwordfield',
				showCapsWarning:true,
                name:'loginPassword',
				id: 'loginPassword',
                inputType:'password', 
                allowBlank:false,
				blankText: "Informe a senha",
				value: '123456',
				width: '90%',
				listeners:{
					specialkey:function(owner,e){
						if (e.getKey() == 13){
							var valid = true;
							var f = Ext.getCmp('id-form-login');
							f.form.items.each(function(f){
					            if(!f.isValid(true)){
					                valid = false;
					                return false;
					            }
					        });

						}
						if(valid) doLogin();
					}
				}
            },{
            	name:'background', 
                inputType:'hidden', 
                allowBlank:true,
                value: Ext.get("background").getAttribute("src")
            }]
		}],
		buttons:[{
    		id: 'botaoLogin',
            text:'Login',
			type:'submit',
			iconCls: 'chave',
            formBind: true,
            handler: doLogin
        },{
			xtype:'panel',
			baseCls: 'x-plain',
			width: 13
		}]
    });
     
    var win = new Ext.Window({
        layout:'fit',
        width:330,
        height:165,
        closable: false,
        resizable: false,
        plain: true,
        border: false,
        items: [login] 
	});
	win.show();
	
	Ext.MessageBox.show({
		id:'fullScreenMsg',
        title: 'Atenção!',
        msg: "Precione a tecla F11 do seu teclado para melhor visualização do sistema.",
        buttons: Ext.MessageBox.OK,
        animEl: 'botaoLogin',
        icon: Ext.MessageBox.WARNING,
		fn:function(){
			Ext.getCmp('loginUsername').focus(false, false);
		}
    });
	
});

function doLogin(){	
    login.getForm().submit({
        method:'POST', 
        waitTitle:'Conectando', 
        waitMsg:'Enviando Informações...',

		success:function(){
			var redirect = 'desktop.html'; 
			window.location = redirect;
		},
		failure:HttpHelpers.failHandler
    }); 
}