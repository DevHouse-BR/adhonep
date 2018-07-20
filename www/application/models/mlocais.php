<?php
class MLocais extends CI_Model{
	function MLocais(){
		parent::__construct();
	}
	
	function checkLogin($user, $pass){
		$this->db->where("email", xss_clean($user));
		$this->db->where("senha", dohash(xss_clean($pass)));
		
		$result = $this->db->get("locais");

		if($result->num_rows()>0){
			return $result->row_array();
		}
		else{
			return false;
		}
	}
	
	function listaLocais($query, $limit, $limit_start, $order_by, $order_direction){
		$resultado = Array();
		
		if($query) $this->db->like("local", $query);
		$total = $this->db->count_all_results('locais');
		
		if($query) $this->db->like("local", $query);
		
		if($limit) $this->db->limit($limit, $limit_start);
		
		if($order_by) $this->db->order_by($order_by, $order_direction);
		
		
		$this->db->select('locais.idlocais, locais.local, locais.endereco, locais.bairro, locais.telefone, locais.desc, locais.idpessoas, locais.idcidades, pessoas.nome as contato, cidades.cidade');
		$this->db->from('locais');
		$this->db->join('pessoas', 'pessoas.idpessoas = locais.idpessoas');
		$this->db->join('cidades', 'cidades.idcidades = locais.idcidades');	
  
  
		$result = $this->db->get();
		
		foreach($result->result_array() as $row) $resultado[] = $row;
		
		return array($resultado, $total);
	}
	
	function salvaLocal($data){
		if(strlen($data['idlocais'])>0){
			$this->db->where('idlocais', $data['idlocais']);
			$query = $this->db->update('locais', $data);
		}
		else{
			$query = $this->db->insert('locais', $data);
		}
		if($query) return true;
		else return false;
	}

	function salvaLocalGrid($data){
		$this->db->where('idlocais', $data['idlocais']);
		$this->db->update('locais', $data); 
		if($this->db->affected_rows()>0) return true;
		else return false;
	}
	
	function removeLocais($ids){
		$query = "DELETE FROM locais WHERE ";
		for($i = 0; $i < sizeof($ids); $i++){
			$query = $query . "idlocais = ".$ids[$i];
			if($i < sizeof($ids)-1){
				$query = $query . " OR ";
			}     
		}
		$query = $this->db->query($query);
		return $this->db->affected_rows();
	}
	
	function localExiste($local){
		$this->db->where('local', $local);
		$total = $this->db->count_all_results('locais');
		if($total > 0) return true;
		else return false;
	}
}
?>