<?php
class MAtributosPessoais extends CI_Model{
	function MAtributosPessoais(){
		parent::__construct();
	}
	
	function listaAtributos($query, $limit, $limit_start, $order_by, $order_direction){
		$resultado = Array();

		if($query) $this->db->like("atributo", $query);
		$total = $this->db->count_all_results('atributospessoais');
		
		if($query) $this->db->like("atributo", $query);
		
		if($limit) $this->db->limit($limit, $limit_start);
		
		if($order_by) $this->db->order_by($order_by, $order_direction);
		
		$this->db->select('idatributospessoais, atributo, aplicacao');	
		$result = $this->db->get('atributospessoais');
		
		foreach($result->result_array() as $row) $resultado[] = $row;
		
		return array($resultado, $total);
	}
	
	function salvaAtributo($data){
		if(strlen($data['idatributospessoais'])>0){
			$this->db->where('idatributospessoais', $data['idatributospessoais']);
			$query = $this->db->update('atributospessoais', $data);
		}
		else{
			$query = $this->db->insert('atributospessoais', $data);
		}
		if($query) return true;
		else return false;
	}

	function salvaAtributoGrid($data){
		$this->db->where('idatributospessoais', $data['idatributospessoais']);
		$this->db->update('atributospessoais', $data); 
		if($this->db->affected_rows()>0) return true;
		else return false;
	}
	
	function removeAtributos($ids){
		$query = "DELETE FROM atributospessoais WHERE ";
		for($i = 0; $i < sizeof($ids); $i++){
			$query = $query . "idatributospessoais = ".$ids[$i];
			if($i < sizeof($ids)-1){
				$query = $query . " OR ";
			}     
		}
		$query = $this->db->query($query);
		return $this->db->affected_rows();
	}
	
	function atributoExiste($atributo){
		$this->db->where('atributo', $atributo);
		$total = $this->db->count_all_results('atributospessoais');
		if($total > 0) return true;
		else return false;
	}
}
?>