<?php

class Locais extends Controller {

	function Locais(){
		parent::Controller();
		if(!$this->session->userdata('logged_in')) {
			redirect("login");
		}
		$this->load->model('MLocais');
	}
	
	function index(){
		
	}
	function locaisGrid(){
		$query = $this->input->post('query', TRUE);
		$limit = $this->input->post('limit', TRUE);
		$limit_start = $this->input->post('start', TRUE);
		$order_by = $this->input->post('sort', TRUE);
		$order_direction = $this->input->post('dir', TRUE);
		
		$lista = $this->MLocais->listaLocais($query, $limit, $limit_start, $order_by, $order_direction);
		

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
	
	function locaisGridPrint(){
		$data = array();
		$query = $this->input->post('query', TRUE);
		$limit = $this->input->post('limit', TRUE);
		$limit_start = $this->input->post('start', TRUE);
		$order_by = $this->input->post('sort', TRUE);
		$order_direction = $this->input->post('dir', TRUE);
		
		$lista = $this->MLocais->listaLocais($query, $limit, $limit_start, $order_by, $order_direction);
		
		for ($i = 0; $i < count($lista[0]); $i++) {
		    unset($lista[0][$i]['desc']);
			unset($lista[0][$i]['idpessoas']);
			unset($lista[0][$i]['idcidades']);
		}


		$this->load->library('table');
		
		$this->table->set_heading('ID', 'Local', 'Endereço', 'Bairro', 'Telefone', 'Contato', 'Cidade');
		
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
	
	function salvaLocalGrid(){
		$data = array(
			'idlocais' => $this->input->post('idlocais', TRUE),
			'local' => $this->input->post('local', TRUE),
			'bairro' => $this->input->post('bairro', TRUE),
			'idcidades' => $this->input->post('idcidades', TRUE),
			'telefone' => $this->input->post('telefone', TRUE),
			'idpessoas' => $this->input->post('idpessoas', TRUE)
		);
		if($this->MLocais->salvaLocalGrid($data)) json_echo("{success:true}");
		else json_echo("{success:false, errormsg:'Não foi possível gravar informações no banco de dados.'}");
	}
	
	function salvaLocal(){
		$data = array(
			'idlocais' => $this->input->post('idlocais', TRUE),
			'local' => $this->input->post('local', TRUE),
			'bairro' => $this->input->post('bairro', TRUE),
			'idcidades' => $this->input->post('idcidades', TRUE),
			'telefone' => $this->input->post('telefone', TRUE),
			'endereco' => $this->input->post('endereco', TRUE),
			'desc' => $this->input->post('desc', TRUE),			
			'idpessoas' => $this->input->post('idpessoas', TRUE)
		);
		
		if($this->MLocais->salvaLocal($data)) json_echo("{success:true}");
		else json_echo("{success:false, errormsg:'Não foi possível gravar informações no banco de dados.'}");
	}
	
	function removeLocais(){
		$ids = $this->input->post('ids', TRUE);
		$ids = json_decode($ids);
		$qtd = $this->MLocais->removeLocais($ids);
		json_echo('{success: true, qtd:' . $qtd . '}');
	}
}
?>