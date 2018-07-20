<?php

class Ideias extends CI_Controller {

	function __construct() {
        parent::__construct();
        if(!$this->session->userdata('logged_in')) {
			redirect("login");
		}
		$this->load->model('MIdeias');
    }
	
	function index(){
		
	}
	function ideiasGrid(){
		$query = $this->input->post('query', TRUE);
		$limit = $this->input->post('limit', TRUE);
		$limit_start = $this->input->post('start', TRUE);
		$order_by = $this->input->post('sort', TRUE);
		$order_direction = $this->input->post('dir', TRUE);
		
		$lista = $this->MIdeias->listaIdeias($query, $limit, $limit_start, $order_by, $order_direction);

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
	
	function ideiasGridPrint(){
		$data = array();
		$query = $this->input->post('query', TRUE);
		$limit = $this->input->post('limit', TRUE);
		$limit_start = $this->input->post('start', TRUE);
		$order_by = $this->input->post('sort', TRUE);
		$order_direction = $this->input->post('dir', TRUE);
		
		$lista = $this->MIdeias->listaIdeias($query, $limit, $limit_start, $order_by, $order_direction);
		$temp = '';
			
		$this->load->library('table');
		
		$this->table->set_heading('ID', 'Idéia', 'Onde Usar?', 'Autor', 'Descrição');
		$this->table->set_widths('3%','20%','10%','15%','52%'); 
		
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
	
	function salvaIdeiaGrid(){
		$data = array(
			'idideias' => $this->input->post('idideias', TRUE),
			'ideia' => $this->input->post('ideia', TRUE),
			'autor' => $this->input->post('autor', TRUE)
		);

		if($this->MIdeias->salvaIdeiaGrid($data)) json_echo("{success:true}");
		else json_echo("{success:false, errormsg:'Não foi possível gravar informações no banco de dados.'}");
	}
	
	function salvaIdeia(){
		$data = array(
			'idideias' => $this->input->post('idideias', TRUE),
			'ideia' => $this->input->post('ideia', TRUE),
			'ondeusar' => $this->input->post('ondeusar', TRUE),
			'autor' => $this->input->post('autor', TRUE),
			'desc' => $this->input->post('desc', TRUE)
		);
		
		if($this->MIdeias->salvaIdeia($data)) json_echo("{success:true}");
		else json_echo("{success:false, errormsg:'Não foi possível gravar informações no banco de dados.'}");
	}
	
	function removeIdeias(){		
		$ids = $this->input->post('ids', TRUE);
		$ids = json_decode($ids);
		$qtd = $this->MIdeias->removeIdeias($ids);
		json_echo('{success: true, qtd:' . $qtd . '}');
	}
}
?>