<?php
function access_control($entidade){
	$access = $this->session->userdata('permissoes');
	
	if(!$access[$entidade]){
		header('Cache-Control: no-cache, must-revalidate');
		header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
		header('Content-type: application/json');
		echo('{"success":false, "errormsg":"Você não tem permissão para executar esta tarefa."}');	
	}
}
?>