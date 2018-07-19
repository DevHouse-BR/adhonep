/**
 * @author Leonardo
 */

var DesktopHelpers = function(){
	return{
		getCookie: function(name) {
			var dc = document.cookie;
			var prefix = name + "=";
			var begin = dc.indexOf("; " + prefix);
			if (begin == -1) {
				begin = dc.indexOf(prefix);
				if (begin != 0) return null;
			}
			else
				begin += 2;
			var end = document.cookie.indexOf(";", begin);
			if (end == -1)
				end = dc.length;
			return unescape(dc.substring(begin + prefix.length, end)).replace(/\+/g, " ");
		},
		
		showNotification: function(config){
			var a = "leo";
			var win = new Ext.ux.Notification(Ext.apply({animateTarget:Ext.get('ux-taskbar'),autoDestroy:true,hideDelay:3000,html:'',iconCls:'alerta',title:''}, config));
			win.show();
			return win;
		}
	}
}();
