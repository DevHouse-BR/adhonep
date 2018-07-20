<?php
class MPermissoes extends CI_Model{
	function MPermissoes(){
		parent::__construct();
	}
	
	function listaPermissoes($query, $limit, $limit_start, $order_by, $order_direction){
		$resultado = Array();
		
		if($query) $this->db->like("permissao", $query);
		$total = $this->db->count_all_results('permissoes');
		
		if($query) $this->db->like("permissao", $query);
		
		if($limit) $this->db->limit($limit, $limit_start);
		
		if($order_by) $this->db->order_by($order_by, $order_direction);
		
		
		$this->db->select('idpermissoes, permissao');	
		$result = $this->db->get('permissoes');
		
		foreach($result->result_array() as $row) $resultado[] = $row;
		
		return array($resultado, $total);
	}
	
	function salvaAtributo($data){
		if(strlen($data['idpermissoes'])>0){
			$this->db->where('idpermissoes', $data['idpermissoes']);
			$query = $this->db->update('permissoes', $data);
		}
		else{
			$query = $this->db->insert('permissoes', $data);
		}
		if($query) return true;
		else return false;
	}

	function salvaAtributoGrid($data){
		$this->db->where('idpermissoes', $data['idpermissoes']);
		$this->db->update('permissoes', $data); 
		if($this->db->affected_rows()>0) return true;
		else return false;
	}
	
	function removeAtributos($ids){
		$query = "DELETE FROM permissoes WHERE ";
		for($i = 0; $i < sizeof($ids); $i++){
			$query = $query . "idpermissoes = ".$ids[$i];
			if($i < sizeof($ids)-1){
				$query = $query . " OR ";
			}     
		}
		$query = $this->db->query($query);
		return $this->db->affected_rows();
	}
	
	function permissaoExiste($permissao){
		$this->db->where('permissao', $permissao);
		$total = $this->db->count_all_results('permissoes');
		if($total > 0) return true;
		else return false;
	}
}
?>