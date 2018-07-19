/**
 * @author Leonardo
 */

DevHouseDesktop.ModuloGridPessoas = Ext.extend(Ext.app.Module, {
    id:'id-modulo-grid-pessoas',
	windowId:'id-window-grid-pessoas',
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
		GridPessoasWindow = desktop.getWindow(this.windowId);
		if (!GridPessoasWindow) {
			GridPessoasWindow = desktop.createWindow({
				id: this.windowId,
				title: Ext.names.GridPessoasTitle,
				width: 740,
				height: 480,
				iconCls: 'pessoas',
				shim: false,
				animCollapse:false,
                constrainHeader:true,
				layout:'border',
				defaults: {
				    collapsible: true,
				    split: true
				},
				items: [
					DevHouseDesktop.GridPessoas.painelFiltros,
					{
						region: 'center',
						collapsible: false,
						xtype: 'container',
						cmargins: '5 0 0 0',
						layout: 'hbox',
						layoutConfig: {
							align: 'stretch',
							pack: 'start'
						},
						items: new ClassesBase.Grids.GridEditorBasico(DevHouseDesktop.GridPessoas.gridPessoasConfig)
					}],
				listeners:{
					show: function(){
						Ext.getCmp('id-painel-filtros-pessoas').expand();
						Ext.select('div.x-progress-text-back').setStyle('margin-top', '1px');
						var task = new Ext.util.DelayedTask(function(){
						    Ext.getCmp('id-painel-filtros-pessoas').collapse();
						});
						task.delay(500);
						var task2 = new Ext.util.DelayedTask(function(){
							var x = document.getElementById('id-painel-filtros-pessoas-xcollapsed');
							x.innerHTML = '<div class="x-collapsed-title"><img src="images/application_form_magnify.png" align="left" /> Filtros de Pesquisa</div>' + x.innerHTML;
						});
						task2.delay(1000);
					},
					close: function(){
						delete GridPessoasWindow;
						//comboCidades = new Ext.ux.comboCidades();
					}
				}
			});
		}
		GridPessoasWindow.show();
	}
});