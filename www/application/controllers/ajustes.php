<?php

class Ajustes extends CI_Controller {

	function Ajustes(){
		parent::__construct();
		if(!$this->session->userdata('logged_in')) {
			redirect("login");
		}
		$this->load->model('MAjustes');
	}
	
	function index(){
		
	}
	
	function ajustesGrid(){
		$lista = $this->MAjustes->listaAjustes();

		$nrows = count($lista);

		$data = Array();

		for($i=0; $i<count($lista[0]); $i++) {
			$data[$lista[0][$i]['nome']] = $lista[0][$i]['valor'];
		}
		
		if($nrows > 0){
			$resultado['success'] = true;
			$resultado['totalCount'] = $lista[1];
			$resultado['data'] = Array($data);
		}
		
		json_echo(json_encode($resultado));
	}
	
	function salvaAjustes(){
		$ajustes = $this->input->post('ajustes', TRUE);
		$ajustes = str_replace('true', '"true"', $ajustes);
		$ajustes = str_replace('false', '"false"', $ajustes);
		$ajustes = get_object_vars(json_decode($ajustes));

		$data = Array();
		foreach($ajustes as $nome => $valor) $data[] = Array('nome' => $nome, 'valor' => $valor); 

		if($this->MAjustes->salvaAjustes($data)) json_echo("{success:true}");
		else json_echo("{success:false, errormsg:'Não foi possível gravar informações no banco de dados.'}");	
	}
	
	function getAjuste(){
		$ajuste = $this->input->post('ajuste', TRUE);
		$ajuste = $this->MAjustes->getAjuste($ajuste);
		if(substr_count($ajuste, ";")>0){
			$ajuste = explode(";", $ajuste);
			$ajustes = Array();
			foreach($ajuste as $a){
				$ajustes[] = Array("valor" => $a);
			}
			
			
			$resultado['success'] = true;
			$resultado['results'] = count($ajuste);
			$resultado['rows'] = $ajustes;
			
			json_echo(json_encode($resultado));
		}
		else json_echo(json_encode($ajuste));
	}
}
?>