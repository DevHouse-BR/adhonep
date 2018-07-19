<?php
class MIdeias extends Model{
	function MIdeias(){
		parent::Model();
	}
	
	function listaIdeias($query, $limit, $limit_start, $order_by, $order_direction){
		$resultado = Array();
		
		if($query) $this->db->like("ideia", $query);
		$total = $this->db->count_all_results('ideias');
		
		if($query) $this->db->like("ideia", $query);
		
		if($limit) $this->db->limit($limit, $limit_start);
		
		if($order_by) $this->db->order_by($order_by, $order_direction);
		
		$result = $this->db->get('ideias');
		
		$resultado = $result->result_array();
		
		return array($resultado, $total);
	}
	
	function salvaIdeia($data){
		if(strlen($data['idideias'])>0){
			$this->db->where('idideias', $data['idideias']);
			$query = $this->db->update('ideias', $data);
		}
		else{
			$query = $this->db->insert('ideias', $data);
		}
		
		if($query) return true;
		else return false;
	}

	function salvaIdeiaGrid($data){
		$this->db->where('idideias', $data['idideias']);
		$this->db->update('ideias', $data); 
		if($this->db->affected_rows()>0) return true;
		else return false;
	}
	
	function removeIdeias($ids){
		$query = "DELETE FROM ideias WHERE ";
		for($i = 0; $i < sizeof($ids); $i++){
			$query = $query . "idideias = ".$ids[$i];
			if($i < sizeof($ids)-1){
				$query = $query . " OR ";
			}     
		}
		$query = $this->db->query($query);
		return $this->db->affected_rows();
	}
	
	function ideiaExiste($arquivo){
		$this->db->where('caminho', $arquivo);
		
		$total = $this->db->count_all_results('ideias');
		if($total > 0) return true;
		else return false;
	}
}
?>