<?php
class MDownloads extends CI_Model{
	function MDownloads(){
		parent::__construct();
	}
	
	function listaDownloads($query, $limit, $limit_start, $order_by, $order_direction){
		$resultado = Array();
		
		if($query) $this->db->like("arquivo", $query);
		$total = $this->db->count_all_results('downloads');
		
		if($query) $this->db->like("arquivo", $query);
		
		if($limit) $this->db->limit($limit, $limit_start);
		
		if($order_by) $this->db->order_by($order_by, $order_direction);
		
		
		$this->db->select('downloads.iddownloads, downloads.arquivo, downloads.caminho, downloads.uploader, downloads.autor, pessoas.nome as nomeUploader, downloads.qtddownloads');	
		$this->db->from('downloads');
		$this->db->join('pessoas', 'pessoas.idpessoas = downloads.uploader');
		
		
		$result = $this->db->get();
		
		$resultado = $result->result_array();
		
		return array($resultado, $total);
	}
		
	function listaDownloadsPorIds($ids){
		$where = "";
		
		for($i = 0; $i < count($ids); $i++){
			$where .= "iddownloads = '" . $ids[$i] . "'";
			if($i != count($ids)-1) $where .= " OR ";
		}
		
		$this->db->where($where);

		$result = $this->db->get("downloads");
		return $result->result_array();		
	}
	
	function salvaDownload($data){		
		if(strlen($data['iddownloads'])>0){
			$this->db->where('iddownloads', $data['iddownloads']);
			$query = $this->db->update('downloads', $data);
		}
		else{
			$query = $this->db->insert('downloads', $data);
		}
		
		if($query) return true;
		else return false;
	}

	function salvaDownloadGrid($data){
		$this->db->where('iddownloads', $data['iddownloads']);
		$this->db->update('downloads', $data); 
		if($this->db->affected_rows()>0) return true;
		else return false;
	}
	
	function removeDownloads($ids){
		$query = "DELETE FROM downloads WHERE ";
		for($i = 0; $i < sizeof($ids); $i++){
			$query = $query . "iddownloads = ".$ids[$i];
			if($i < sizeof($ids)-1){
				$query = $query . " OR ";
			}     
		}
		$query = $this->db->query($query);
		return $this->db->affected_rows();
	}
	
	function downloadExiste($arquivo){
		$this->db->where('caminho', $arquivo);
		
		$total = $this->db->count_all_results('downloads');
		if($total > 0) return true;
		else return false;
	}
}
?>