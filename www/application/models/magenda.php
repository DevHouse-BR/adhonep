<?php
class MAgenda extends CI_Model{
	
	function __construct() {
        parent::__construct();
    }
	
	function listaAgenda($query, $limit, $limit_start, $order_by, $order_direction){
		$resultado = Array();
		
		if($query) $this->db->like("datahora", $query);
		$total = $this->db->count_all_results('agenda');
		
		if($query) $this->db->like("datahora", $query);
		
		if($limit) $this->db->limit($limit, $limit_start);
		
		if($order_by) $this->db->order_by($order_by, $order_direction);

		
		$this->db->select('agenda.idagenda, agenda.datahora, agenda.novos, agenda.total, agenda.desc, agenda.site, agenda.idlocais, agenda.statuslocal, agenda.idpessoas, pessoas.nome as editor, locais.local');	
		$this->db->from('agenda');
		$this->db->join('pessoas', 'pessoas.idpessoas = agenda.idpessoas');
		$this->db->join('locais', 'locais.idlocais = agenda.idlocais');

		
		$result = $this->db->get();		

		foreach($result->result_array() as $row){
			
			$this->db->select('agenda_encarregados.idpessoas as idencarregado, agenda_encarregados.tipo as tipoencarregado, agenda_encarregados.status, pessoas.nome as encarregado');	
			$this->db->from('agenda_encarregados');
			$this->db->join('pessoas', 'pessoas.idpessoas = agenda_encarregados.idpessoas');
			$this->db->where('agenda_encarregados.idagenda', $row['idagenda']);
			$this->db->order_by('agenda_encarregados.tipo', 'ASC');
			$result2 = $this->db->get();
			
			$arr_encarregados = array();
			foreach($result2->result_array() as $encarregados){
				$arr_encarregados[] = $encarregados;	
			}
			$row['encarregados'] = $arr_encarregados;

			$resultado[] = $row;
		}
		
		return array($resultado, $total);
	}
	
	function salvaAgenda($data){		
		if($data['preletor']) $preletor = $data['preletor'];
		if($data['statusPreletor']) $statusPreletor = $data['statusPreletor'];
		if($data['mestre']) $mestre = $data['mestre'];
		if($data['statusMestre']) $statusMestre = $data['statusMestre'];
		if($data['musico']) $musico = $data['musico'];
		if($data['statusMusico']) $statusMusico = $data['statusMusico'];
		if($data['5min']) $cincomin = $data['5min'];
		if($data['status5min']) $statuscincomin = $data['status5min'];
		

		unset($data['preletor']);
		unset($data['statusPreletor']);
		unset($data['mestre']);
		unset($data['statusMestre']);
		unset($data['musico']);
		unset($data['statusMusico']);
		unset($data['5min']);
		unset($data['status5min']);
		
		if(strlen($data['idagenda'])>0){
			$this->db->where('idagenda', $data['idagenda']);
			$query = $this->db->update('agenda', $data);
		}
		else{
			$query = $this->db->insert('agenda', $data);
		}
		
		if($query){
			if(strlen($data['idagenda'])>0){
				$id = $data['idagenda'];
				
				$query = "DELETE FROM agenda_encarregados WHERE idagenda=" . $id;
				$query = $this->db->query($query);
			}
			else $id = $this->db->insert_id();
			
			$query = $this->db->insert('agenda_encarregados', array('idagenda'=>$id, 'idpessoas'=>$preletor, 'tipo'=>'1', 'status'=>$statusPreletor));
			$query = $this->db->insert('agenda_encarregados', array('idagenda'=>$id, 'idpessoas'=>$mestre, 'tipo'=>'2', 'status'=>$statusMestre));
			$query = $this->db->insert('agenda_encarregados', array('idagenda'=>$id, 'idpessoas'=>$musico, 'tipo'=>'3', 'status'=>$statusMusico));
			$query = $this->db->insert('agenda_encarregados', array('idagenda'=>$id, 'idpessoas'=>$cincomin, 'tipo'=>'4', 'status'=>$statuscincomin));
		}
		else return false;
		
		if($query) return true;
		else return false;
	}

	function salvaAgendaGrid($data){
		$this->db->where('idagenda', $data['idagenda']);
		$this->db->update('agenda', $data); 
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