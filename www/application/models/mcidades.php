<?php
class MCidades extends CI_Model{

	function __construct() {
        parent::__construct();
        //echo $this->db->_compile_select();
		//echo $this->db->last_query();
    }
	
	function listaCidades($query, $limit, $limit_start, $order_by, $order_direction){
		$resultado = Array();
				
		if($query) $this->db->like("cidade", $query);
		$total = $this->db->count_all_results('cidades');
		
		if($query) $this->db->like("cidade", $query);
		
		if($limit) $this->db->limit($limit, $limit_start);
		
		if($order_by) $this->db->order_by($order_by, $order_direction);

		
		$this->db->select('idcidades, cidade, capitulo, imagem, desc');
		$this->db->from('cidades');

		
		$result = $this->db->get();		

		foreach($result->result_array() as $row){
			
			$this->db->select('cidades_atributospessoais_pessoas.idatributospessoais, cidades_atributospessoais_pessoas.idpessoas, atributospessoais.atributo, pessoas.nome');	
			$this->db->from('cidades_atributospessoais_pessoas');
			$this->db->join('atributospessoais', 'atributospessoais.idatributospessoais = cidades_atributospessoais_pessoas.idatributospessoais');
			$this->db->join('pessoas', 'pessoas.idpessoas = cidades_atributospessoais_pessoas.idpessoas');
			$this->db->where('cidades_atributospessoais_pessoas.idcidades', $row['idcidades']);
			$result2 = $this->db->get();
			
			$responsaveis = array();
			foreach($result2->result_array() as $responsavel){
				$responsaveis[] = $responsavel;	
			}
			$row['responsaveis'] = $responsaveis;

			$resultado[] = $row;
		}
		
		return array($resultado, $total);
	}
	
	function salvaCidade($data){
		$responsaveis = Array();
		
		if($data['responsaveis']) $responsaveis = $data['responsaveis'];

		unset($data['responsaveis']);
		
		
		if(strlen($data['idcidades'])>0){
			$this->db->where('idcidades', $data['idcidades']);
			$query = $this->db->update('cidades', $data);
		}
		else{
			$query = $this->db->insert('cidades', $data);
		}
		
		
		if($query){
			if(strlen($data['idcidades'])>0){
				$id = $data['idcidades'];
				
				$query = "DELETE FROM cidades_atributospessoais_pessoas WHERE idcidades=" . $id;
				$query = $this->db->query($query);
			}
			else $id = $this->db->insert_id();
			
			foreach($responsaveis as $idatributospessoais => $idpessoas) {
				if(strlen($idpessoas)>0)
					$query = $this->db->insert('cidades_atributospessoais_pessoas', array('idcidades' => $id, 'idatributospessoais' => $idatributospessoais, 'idpessoas' => $idpessoas));
			}
		}
		else return false;

		if($query) return true;
		else return false;
	}

	function salvaCidadeGrid($data){
		$this->db->where('idcidades', $data['idcidades']);
		$this->db->update('cidades', $data); 
		if($this->db->affected_rows()>0) return true;
		else return false;
	}
	
	function removeCidades($ids){
		$query = "DELETE FROM cidades WHERE ";
		for($i = 0; $i < sizeof($ids); $i++){
			$query = $query . "idcidades = ".$ids[$i];
			if($i < sizeof($ids)-1){
				$query = $query . " OR ";
			}     
		}
		$query = $this->db->query($query);
		return $this->db->affected_rows();
	}
	
	function cidadeExiste($cidade){
		$this->db->where('cidade', $cidade);
		$total = $this->db->count_all_results('cidades');
		if($total > 0) return true;
		else return false;
	}
}
?>