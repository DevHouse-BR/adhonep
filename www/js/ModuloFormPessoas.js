/**
 * @author Leonardo
 */

DevHouseDesktop.ModuloFormPessoas = Ext.extend(Ext.app.Module, {
    id:'id-modulo-form-pessoas',
	windowId:'id-window-form-pessoas',
    init : function(){
        this.launcher = {
            text: Ext.names.FormPessoasTitle,
            iconCls:'pessoas',
            handler : this.createWindow,
            scope: this
        }
    },
	
	createWindow : function(options){
		if(options){
			var opcoes = {};
			var urlToLoad = DevHouseDesktop.FormPessoas.formPessoasConfig.formConfig.loadUrl;
			if(typeof options.carregaRegistro != 'undefined'){
				if (options.carregaRegistro) {
					opcoes.carregaRegistro = true;
					opcoes.loadUrl = DevHouseDesktop.FormPessoas.formPessoasConfig.formConfig.loadUrl + options.id;
				}
			}
			if(typeof options.storeToReload != 'undefined'){
				opcoes.storeToReload = options.storeToReload;
			}
			Ext.apply(DevHouseDesktop.FormPessoas.formPessoasConfig.formConfig,opcoes);
			var form = new ClassesBase.Forms.FormPanelBasico(DevHouseDesktop.FormPessoas.formPessoasConfig);
			Ext.apply(DevHouseDesktop.FormPessoas.formPessoasConfig.formConfig,{
				carregaRegistro:false,
				loadUrl: urlToLoad,
				storeToReload:null
			});
		}
		if(!form) var form = new ClassesBase.Forms.FormPanelBasico(DevHouseDesktop.FormPessoas.formPessoasConfig);
		var desktop = this.app.getDesktop();
		FormPessoasWindow = desktop.getWindow(this.windowId);
		if (!FormPessoasWindow) {
			FormPessoasWindow = desktop.createWindow({
				id: this.windowId,
				title: Ext.names.FormPessoasTitle,
				iconCls: 'pessoas',
				width: 610,
            	height: 550,
				plain:true,
				layout: 'fit',
				items: [form]
			});
		}
		FormPessoasWindow.show();
	}
});