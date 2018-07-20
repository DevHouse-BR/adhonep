<?php

class Permissoes extends CI_Controller {

	function __construct() {
        parent::__construct();
        /*if(!$this->session->userdata('logged_in')) {
			redirect("login");
		}*/
		$this->load->model('MPermissoes');
    }
	
	function index(){
		
	}
	
	function permissoesGrid(){
		$query = $this->input->post('query', TRUE);
		$limit = $this->input->post('limit', TRUE);
		$limit_start = $this->input->post('start', TRUE);
		$order_by = $this->input->post('sort', TRUE);
		$order_direction = $this->input->post('dir', TRUE);
		
		$lista = $this->MPermissoes->listaPermissoes($query, $limit, $limit_start, $order_by, $order_direction);


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
	
	function permissoesCheckBoxGroup(){
		$query = $this->input->post('query', TRUE);
		$limit = $this->input->post('limit', TRUE);
		$limit_start = $this->input->post('start', TRUE);
		$order_by = $this->input->post('sort', TRUE);
		$order_direction = $this->input->post('dir', TRUE);
		
		$lista = $this->MPermissoes->listaPermissoes($query, $limit, $limit_start, $order_by, $order_direction);

		$nrows = count($lista);
		if($nrows > 0){
			$resultado['success'] = true;
			$resultado['results'] = $lista[1];
			$resultado['rows'] = $lista[0];
		}
		else {
			$resultado['success'] = true;
			$resultado['results'] = 0;
		}
		json_echo(json_encode($resultado));
	}
	
	function permissoesGridPrint(){
		$data = array();
		$query = $this->input->post('query', TRUE);
		$limit = $this->input->post('limit', TRUE);
		$limit_start = $this->input->post('start', TRUE);
		$order_by = $this->input->post('sort', TRUE);
		$order_direction = $this->input->post('dir', TRUE);
		
		$lista = $this->MPermissoes->listaPermissoes($query, $limit, $limit_start, $order_by, $order_direction);
		
		$this->load->library('table');
		
		$this->table->set_heading('ID', 'Permissoes');
		
		$tmpl = array (
			'table_open'          => '<table width="100%" border="0" cellpadding="6" cellspacing="0" class="tabela">',
			
			'heading_row_start'   => '<tr class="cabecalho">',
			'heading_row_end'     => '</tr>',
			'heading_cell_start'  => '<th align="left">',
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
	
	function salvaPermissaoGrid(){
		$data = array(
			'idpermissoes' => $this->input->post('idpermissoes', TRUE),
			'permissao' => $this->input->post('permissao', TRUE),
		);

		if($this->MPermissoes->salvaPermissaoGrid($data)) json_echo("{success:true}");
		else json_echo("{success:false, errormsg:'Não foi possível gravar informações no banco de dados.'}");
	}
	
	function salvaPermissao(){
		$data = array(
			'idpermissoes' => $this->input->post('idpermissoes', TRUE),
			'permissao' => $this->input->post('permissao', TRUE),
		);
		
		if((int)$data['idpermissoes']== 0){
			if($this->MPermissoes->permissaoExiste($data['permissao'])){
				json_echo('{success: false, errors: {permissaoField: "Permissao já cadastrado no sistema."}, errormsg:"Permissao já cadastrado no sistema."}');
				return;
			}	
		}
		
		if($this->MPermissoes->salvaPermissao($data)) json_echo("{success:true}");
		else json_echo("{success:false, errormsg:'Não foi possível gravar informações no banco de dados.'}");	
	}
	
	function removePermissoes(){
		$ids = $this->input->post('ids', TRUE);
		$ids = json_decode($ids);
		$qtd = $this->MPermissoes->removePermissoes($ids);
		json_echo('{success: true, qtd:' . $qtd . '}');
	}
}
?>