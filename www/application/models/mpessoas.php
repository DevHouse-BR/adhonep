<?php
class MPessoas extends CI_Model{

	function __construct() {
        parent::__construct();
    }
	
	function checkLogin($user, $pass){
		$this->db->where("email", $user);
		$this->db->where("senha", do_hash($pass));
		
		$this->db->select('idpessoas, nome, email, acesso');	
		$result = $this->db->get("pessoas");

		if($result->num_rows()>0){
			$row = $result->row_array();
			
			$this->db->select('pessoas_permissoes.idpermissoes, permissoes.permissao');	
			$this->db->from('pessoas_permissoes');
			$this->db->join('permissoes', 'permissoes.idpermissoes = pessoas_permissoes.idpermissoes');
			$this->db->where('pessoas_permissoes.idpessoas', $row['idpessoas']);
			$result2 = $this->db->get();
			
			$ids_permissoes = array();
			foreach($result2->result_array() as $permissoes){
				$ids_permissoes[] = $permissoes;	
			}
			$row['permissoes'] = $ids_permissoes;
			return $row;
		}
		else{
			return false;
		}
	}
	
	function listaPessoas($query, $limit, $limit_start, $order_by, $order_direction){
		$resultado = Array();
		
		
		if(array_key_exists("nome", $query)) $this->db->like("pessoas.nome", $query["nome"]);
		if(array_key_exists("idatributospessoais", $query)) $this->db->like("pessoas_atributospessoais.idatributospessoais", $query["idatributospessoais"]);
		$this->db->join('cidades', 'cidades.idcidades = pessoas.idcidades');
		if(array_key_exists("idatributospessoais", $query)) $this->db->join('pessoas_atributospessoais', 'pessoas_atributospessoais.idpessoas = pessoas.idpessoas', 'left');
		$total = $this->db->count_all_results('pessoas');
		
		if(array_key_exists("nome", $query)) $this->db->like("pessoas.nome", $query["nome"]);
		if(array_key_exists("idatributospessoais", $query)) $this->db->like("pessoas_atributospessoais.idatributospessoais", $query["idatributospessoais"]);
		
		if(array_key_exists("idpessoas", $query)) $this->db->where($query);
		
		if($limit) $this->db->limit($limit, $limit_start);
		
		if($order_by) $this->db->order_by($order_by, $order_direction);
		
		
		
		$this->db->select('pessoas.idpessoas, pessoas.nome, pessoas.email, pessoas.telefone, pessoas.celular, pessoas.endereco, pessoas.bairro, pessoas.idcidades, pessoas.acesso, pessoas.desc, cidades.cidade');	
		$this->db->from('pessoas');
		$this->db->join('cidades', 'cidades.idcidades = pessoas.idcidades');
		if(array_key_exists("idatributospessoais", $query)) $this->db->join('pessoas_atributospessoais', 'pessoas_atributospessoais.idpessoas = pessoas.idpessoas', 'left');
		
		$result = $this->db->get();

		foreach($result->result_array() as $row){
			
			$this->db->select('pessoas_atributospessoais.idatributospessoais, atributospessoais.atributo');	
			$this->db->from('pessoas_atributospessoais');
			$this->db->join('atributospessoais', 'atributospessoais.idatributospessoais = pessoas_atributospessoais.idatributospessoais');
			$this->db->where('pessoas_atributospessoais.idpessoas', $row['idpessoas']);
			$result2 = $this->db->get();
			
			$ids_atributos = array();
			foreach($result2->result_array() as $atributos){
				$ids_atributos[] = $atributos;	
			}
			$row['atributos'] = $ids_atributos;
			
			
			$this->db->select('pessoas_permissoes.idpermissoes, permissoes.permissao');	
			$this->db->from('pessoas_permissoes');
			$this->db->join('permissoes', 'permissoes.idpermissoes = pessoas_permissoes.idpermissoes');
			$this->db->where('pessoas_permissoes.idpessoas', $row['idpessoas']);
			$result2 = $this->db->get();
			
			$ids_permissoes = array();
			foreach($result2->result_array() as $permissoes){
				$ids_permissoes[] = $permissoes;	
			}
			$row['permissoes'] = $ids_permissoes;
			
			
			$this->db->select('tipo, count(tipo) as qtd');	
			$this->db->from('agenda_encarregados');
			$this->db->where('idpessoas', $row['idpessoas']);
			$this->db->group_by("tipo"); 
			$result2 = $this->db->get();
			
			$participacoes_arr = array();
			foreach($result2->result_array() as $participacoes){
				$participacoes_arr[] = $participacoes;	
			}
			$row['participacoes'] = $participacoes_arr;
			
			
			$resultado[] = $row;
		}
		
		return array($resultado, $total);
	}
	
	function listaPermissoes($idpessoas){
		$this->db->select('permissoes.permissao');	
		$this->db->from('pessoas_permissoes');
		$this->db->join('permissoes', 'permissoes.idpermissoes = pessoas_permissoes.idpermissoes');
		$this->db->where('pessoas_permissoes.idpessoas', $idpessoas);
		$result = $this->db->get();
		
		$permissoes_arr = array();
		foreach($result->result_array() as $permissoes){
			$permissoes_arr[] = $permissoes;	
		}
		return $permissoes_arr;
	}
	
	function salvaPessoa($data){
		$idatributospessoais = Array();
		$idpermissoes = Array();
		
		if($data['idatributospessoais']) $idatributospessoais = $data['idatributospessoais'];		
		if($data['idpermissoes']) $idpermissoes = $data['idpermissoes'];

		unset($data['idatributospessoais']);
		unset($data['idpermissoes']);
		
		if(strlen($data['idpessoas'])>0){
			$this->db->where('idpessoas', $data['idpessoas']);
			$query = $this->db->update('pessoas', $data);
		}
		else{
			$query = $this->db->insert('pessoas', $data);
		}
		
		if($query){
			if(strlen($data['idpessoas'])>0){
				$id = $data['idpessoas'];
				
				$query = "DELETE FROM pessoas_atributospessoais WHERE idpessoas=" . $id;
				$query = $this->db->query($query);
				
				$query = "DELETE FROM pessoas_permissoes WHERE idpessoas=" . $id;
				$query = $this->db->query($query);
			}
			else $id = $this->db->insert_id();
			
			foreach($idatributospessoais as $atributo) {
				$query = $this->db->insert('pessoas_atributospessoais', array('idpessoas'=>$id, 'idatributospessoais'=>$atributo));
			}
			
			foreach($idpermissoes as $permissao) {
				$query = $this->db->insert('pessoas_permissoes', array('idpessoas'=>$id, 'idpermissoes'=>$permissao));
			}
		}
		else return false;
		
		if($query) return true;
		else return false;
	}

	function salvaPessoaGrid($data){
		$this->db->where('idpessoas', $data['idpessoas']);
		unset($data['idpessoas']);
		$this->db->update('pessoas', $data);
		
		if($this->db->affected_rows()>0) return true;
		else return false;
	}
	
	function removePessoas($ids){
		$query = "DELETE FROM pessoas WHERE ";
		for($i = 0; $i < sizeof($ids); $i++){
			$query = $query . "idpessoas = ".$ids[$i];
			if($i < sizeof($ids)-1){
				$query = $query . " OR ";
			}     
		}
		$query = $this->db->query($query);
		return $this->db->affected_rows();
	}
	
	function pessoaExiste($email){
		$this->db->where('email', $email);
		$total = $this->db->count_all_results('pessoas');
		if($total > 0) return true;
		else return false;
	}
}
?>