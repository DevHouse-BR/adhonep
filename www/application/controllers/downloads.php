<?php

class Downloads extends CI_Controller {

	function __construct() {
        parent::__construct();
        if(!$this->session->userdata('logged_in')) {
			redirect("login");
		}
		$this->load->model('MDownloads');
    }
	
	function index(){
		
	}
	function downloadsGrid(){
		$query = $this->input->post('query', TRUE);
		$limit = $this->input->post('limit', TRUE);
		$limit_start = $this->input->post('start', TRUE);
		$order_by = $this->input->post('sort', TRUE);
		$order_direction = $this->input->post('dir', TRUE);
		
		$lista = $this->MDownloads->listaDownloads($query, $limit, $limit_start, $order_by, $order_direction);

		$nrows = count($lista);
		if($nrows > 0){
			$resultado['success'] = true;
			$resultado['results'] = $lista[1];
			$resultado['rows'] = $lista[0];
		}
		else {
			$resultado['success'] = true;
			$resultado['results'] = 0;
			$resultado['rows'] = Array();
		}
		json_echo(json_encode($resultado));
	}
	
	function downloadsGridPrint(){
		$data = array();
		$query = $this->input->post('query', TRUE);
		$limit = $this->input->post('limit', TRUE);
		$limit_start = $this->input->post('start', TRUE);
		$order_by = $this->input->post('sort', TRUE);
		$order_direction = $this->input->post('dir', TRUE);
		
		$lista = $this->MDownloads->listaDownloads($query, $limit, $limit_start, $order_by, $order_direction);
		
		$temp = '';
		
		for ($i = 0; $i < count($lista[0]); $i++) {
			unset($lista[0][$i]['uploader']);
		}
		
		$this->load->library('table');
		
		$this->table->set_heading('ID', 'Nome', 'Arquivo', 'Autor', 'Uploader');
		
		$tmpl = array (
			'table_open'          => '<table width="100%" border="0" cellpadding="6" cellspacing="0" class="tabela">',
			
			'heading_row_start'   => '<tr class="cabecalho">',
			'heading_row_end'     => '</tr>',
			'heading_cell_start'  => '<th>',
			'heading_cell_end'    => '</th>',
			
			'row_start'           => '<tr class="normal" onMouseOver="this.className=\'sobre\'" onMouseOut="this.className=\'normal\'">',
			'row_end'             => '</tr>',
			'cell_start'          => '<td>',
			'cell_end'            => '</td>',
			
			'row_alt_start'       => '<tr class="alt" onMouseOver="this.className=\'sobre\'" onMouseOut="this.className=\'alt\'">',
			'row_alt_end'         => '</tr>',
			'cell_alt_start'      => '<td>',
			'cell_alt_end'        => '</td>',
			
			'table_close'         => '</table>'
			);
		
		$this->table->set_template($tmpl);
		$this->table->set_empty("&nbsp;"); 
		$data["tabela"] = $this->table->generate($lista[0]); 
		$this->load->view('print_table', $data);		
	}
	
	function salvaDownloadGrid(){
		$data = array(
			'iddownloads' => $this->input->post('iddownloads', TRUE),
			'arquivo' => $this->input->post('arquivo', TRUE),
			'autor' => $this->input->post('autor', TRUE)			
		);

		if($this->MDownloads->salvaDownloadGrid($data)) json_echo("{success:true}");
		else json_echo("{success:false, errormsg:'Não foi possível gravar informações no banco de dados.'}");
	}
	
	function salvaDownload(){
		$data = array(
			'iddownloads' => $this->input->post('iddownloads', TRUE),
			'arquivo' => $this->input->post('arquivo', TRUE),
			'autor' => $this->input->post('autor', TRUE),
			'uploader' => $this->session->userdata('idpessoas')
		);
		
		if((int)$data['iddownloads']== 0){
			if(array_key_exists('caminho', $_FILES)){
				if($this->MDownloads->downloadExiste($_FILES['caminho']["tmp_name"])){
					json_echo('{success: false, errors: {caminhoField: "Arquivo já cadastrado no sistema."}, errormsg:"Arquivo já cadastrado no sistema."}');
					return;
				}	
			}
			if((array_key_exists('caminho', $_FILES)) && (strlen($_FILES['caminho']["tmp_name"])==0)){
				json_echo('{success: false, errors: {caminhoField: "É obrigatório o envio de um arquivo."}, errormsg:"É obrigatório o envio de um arquivo."}');
				return;
			}
		}
		
		if(array_key_exists('caminho', $_FILES)){
			if(strlen($_FILES['caminho']["tmp_name"])>0){
				$config['upload_path'] = './downloads/';
				
				$allowed_types = 'pdf|doc|docx|xls|xlsx|jpg|zip|png|gif|rar|rtf|doc|txt';
				$config['allowed_types'] = substr($allowed_types, strpos($allowed_types, substr($_FILES['caminho']['name'], -3)), 3);
				$this->load->library('upload', $config);
				
				$config['max_size']	= '5000';
				$config['overwrite']  = FALSE;
				
				$this->load->library('upload', $config);
				
				if (!$this->upload->do_upload('caminho')){
					json_echo('{success: false, errors: {caminhoField: "' . $this->upload->display_errors() . '"}, errormsg:"' . $this->upload->display_errors() . '"}');
					return;
				}	
				else{
					$uploadData = $this->upload->data();
					$data['caminho'] = $uploadData['file_name'];
				}
			}
		}
		
		if($this->MDownloads->salvaDownload($data)) json_echo("{success:true}");
		else json_echo("{success:false, errormsg:'Não foi possível gravar informações no banco de dados.'}");
	}
	
	function removeDownloads(){
		$ids = $this->input->post('ids', TRUE);
		$ids = json_decode($ids);
		
		$lista = $this->MDownloads->listaDownloadsPorIds($ids);
		$qtd = 0;
		
		foreach($lista as $download){
			if($this->MDownloads->removeDownloads($download['iddownloads'])){
				unlink('./downloads/' . $download['caminho']);
				$qtd++;
			}
		}
		json_echo('{success: true, qtd:' . $qtd . '}');
	}
	
	function downloadNow($iddownloads){
		$download = $this->MDownloads->listaDownloadsPorIds(array($iddownloads));
		$this->load->helper('download');
		
		$download[0]['qtddownloads'] = (int)$download[0]['qtddownloads'] + 1;
		
		$this->MDownloads->salvaDownload($download[0]);
		
		$data = file_get_contents('./downloads/' . $download[0]['caminho']);
		$nome = $download[0]['caminho'];
		
		force_download($nome, $data);
	}
}
?>