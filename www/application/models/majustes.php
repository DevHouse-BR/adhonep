<?php
class MAjustes extends CI_Model{
	function MAjustes(){
		parent::__construct();
	}
	
	function listaAjustes(){
		$resultado = Array();

		$result = $this->db->get('ajustes');
		
		foreach($result->result_array() as $row) $resultado[] = $row;
		
		return array($resultado, count($resultado));
	}
	
	function getAjuste($ajuste){
		$this->db->where('nome', $ajuste);
		$this->db->select('valor');
		$result = $this->db->get('ajustes');
		$resultado = $result->row_array();
		return $resultado["valor"];
	}
	
	function salvaAjustes($data){
		foreach($data as $ajuste){
			$this->db->where('nome', $ajuste['nome']);
			$query = $this->db->update('ajustes', $ajuste);
		}
		if($query) return true;
		else return false;
	}
}
?>