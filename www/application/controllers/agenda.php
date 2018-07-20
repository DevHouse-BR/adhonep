<?php

class Agenda extends CI_Controller {

	function Agenda(){
		parent::__construct();
		if(!$this->session->userdata('logged_in')) {
			redirect("login");
		}
		$this->load->model('MAgenda');
	}
	
	function index(){
		
	}
	function agendaGrid(){
		$query = $this->input->post('query', TRUE);
		$limit = $this->input->post('limit', TRUE);
		$limit_start = $this->input->post('start', TRUE);
		$order_by = $this->input->post('sort', TRUE);
		$order_direction = $this->input->post('dir', TRUE);
		
		$lista = $this->MAgenda->listaAgenda($query, $limit, $limit_start, $order_by, $order_direction);

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
	
	function agendaGridPrint(){
		$data = array();
		$query = $this->input->post('query', TRUE);
		$limit = $this->input->post('limit', TRUE);
		$limit_start = $this->input->post('start', TRUE);
		$order_by = $this->input->post('sort', TRUE);
		$order_direction = $this->input->post('dir', TRUE);
		
		$lista = $this->MAgenda->listaAgenda($query, $limit, $limit_start, $order_by, $order_direction);
		$temp = '';
		
		for ($i = 0; $i < count($lista[0]); $i++) {
			unset($lista[0][$i]['idpessoas']);
		    unset($lista[0][$i]['idlocais']);
			unset($lista[0][$i]['statuslocal']);
			unset($lista[0][$i]['site']);

			$lista[0][$i]['Preletor'] = "";
			$lista[0][$i]['Mestre'] = "";
			$lista[0][$i]['Músico'] = "";
			$lista[0][$i]['5 Min'] = "";
			
			for ($j = 0; $j < count($lista[0][$i]['encarregados']); $j++) {
				switch($lista[0][$i]['encarregados'][$j]['tipoencarregado']){
					case "1":{
						$lista[0][$i]['Preletor'] = $lista[0][$i]['encarregados'][$j]['encarregado'];
						break;
					}
					case "2":{
						$lista[0][$i]['Mestre'] = $lista[0][$i]['encarregados'][$j]['encarregado'];
						break;
					}
					case "3":{
						$lista[0][$i]['Músico'] = $lista[0][$i]['encarregados'][$j]['encarregado'];
						break;
					}
					case "4":{
						$lista[0][$i]['5 Min'] = $lista[0][$i]['encarregados'][$j]['encarregado'];
						break;
					}
				}
			}
			unset($lista[0][$i]['encarregados']);
		}


		$this->load->library('table');
		
		$this->table->set_heading('ID', 'Data', 'Novos', 'Total', 'Descrição', 'Editor', 'Local', 'Preletor', 'Mestre', 'Músico', '5 Min.');
		
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
	
	function salvaAgendaGrid(){
		$data = array(
			'idagenda' => $this->input->post('idagenda', TRUE),
			'novos' => $this->input->post('novos', TRUE),
			'total' => $this->input->post('total', TRUE)
		);
		
		if($this->MAgenda->salvaAgendaGrid($data)) json_echo("{success:true}");
		else json_echo("{success:false, errormsg:'Não foi possível gravar informações no banco de dados.'}");
	}
	function salvaAgenda(){
		$dados = array(
			'idagenda' => $this->input->post('idagenda', TRUE),
			'novos' => $this->input->post('novos', TRUE),
			'total' => $this->input->post('total', TRUE),
			'desc' => $this->input->post('desc', TRUE),
			'idlocais' => $this->input->post('idlocais', TRUE),
			'statuslocal' => $this->input->post('statusLocal', TRUE),
			'idpessoas' => $this->session->userdata('idpessoas'),
			'site' => array_key_exists("site", $_POST) ? true : false,

			'preletor' => $this->input->post('preletor', TRUE),
			'statusPreletor' => $this->input->post('statusPreletor', TRUE),
			'mestre' => $this->input->post('mestre', TRUE),
			'statusMestre' => $this->input->post('statusMestre', TRUE),
			'musico' => $this->input->post('musico', TRUE),
			'statusMusico' => $this->input->post('statusMusico', TRUE),
			'5min' => $this->input->post('5min', TRUE),
			'status5min' => $this->input->post('status5min', TRUE),
		);
		$data = $this->input->post('data', TRUE);
		$hora = $this->input->post('hora', TRUE);
		$datahora = "";
		
		if($data){
			$data = explode("/", $data);
			$data = $data[2] . '-' . $data[1] . '-' . $data[0];
			$datahora = $data;
		}
		if($hora) $datahora .= " " . $hora . ":00";
		
		$dados["datahora"] = $datahora;
		
		//die($datahora);
		
		//2009-09-27 23:07:00
	
		if($this->MAgenda->salvaAgenda($dados)) json_echo("{success:true}");
		else json_echo("{success:false, errormsg:'Não foi possível gravar informações no banco de dados.'}");
	}
	
	function removePessoas(){
		$ids = $_POST['ids'];
		$ids = json_decode(stripslashes($ids));
		$qtd = $this->MAgenda->removePessoas($ids);
		json_echo('{success: true, qtd:' . $qtd . '}');
	}
}
?>