<?php

class Cidades extends Controller {

	function Cidades(){
		parent::Controller();
		if(!$this->session->userdata('logged_in')) {
			redirect("login");
		}
		$this->load->model('MCidades');
	}
	
	function index(){
		
	}
	function cidadesGrid(){
		$query = $this->input->post('query', TRUE);
		$limit = $this->input->post('limit', TRUE);
		$limit_start = $this->input->post('start', TRUE);
		$order_by = $this->input->post('sort', TRUE);
		$order_direction = $this->input->post('dir', TRUE);
		
		$lista = $this->MCidades->listaCidades($query, $limit, $limit_start, $order_by, $order_direction);


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
	
	function cidadesGridPrint(){
		$data = array();
		$query = $this->input->post('query', TRUE);
		$limit = $this->input->post('limit', TRUE);
		$limit_start = $this->input->post('start', TRUE);
		$order_by = $this->input->post('sort', TRUE);
		$order_direction = $this->input->post('dir', TRUE);
		
		$lista = $this->MCidades->listaCidades($query, $limit, $limit_start, $order_by, $order_direction);
		
		for ($i = 0; $i < count($lista[0]); $i++) {
		    unset($lista[0][$i]['desc']);
			$temp = '';
			for ($j = 0; $j < count($lista[0][$i]['responsaveis']); $j++) {
				$temp .= $lista[0][$i]['responsaveis'][$j]['atributo'] . ': ' . $lista[0][$i]['responsaveis'][$j]['nome'];
				if($j != count($lista[0][$i]['responsaveis'])-1) $temp .= ", <br />";
			}
			$lista[0][$i]['responsaveis'] = $temp;
		}


		$this->load->library('table');
		
		$this->table->set_heading('ID', 'Cidade', 'Capítulo', 'Imagem', 'Responsáveis');
		
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
	
	function salvaCidadeGrid(){
		$data = array(
			'idcidades' => $this->input->post('idcidades', TRUE),
			'cidade' => $this->input->post('cidade', TRUE),
			'imagem' => $this->input->post('imagem', TRUE)
		);

		if($this->MCidades->salvaCidadeGrid($data)) json_echo("{success:true}");
		else json_echo("{success:false, errormsg:'Não foi possível gravar informações no banco de dados.'}");
	}
	
	function salvaCidade(){
		$data = array(
			'idcidades' => $this->input->post('idcidades', TRUE),
			'cidade' => $this->input->post('cidade', TRUE),
			'capitulo' => $this->input->post('capitulo', TRUE),
			'desc' => $this->input->post('desc', TRUE),
			'responsaveis' => $this->input->post('responsaveis', TRUE)
		);
		
		if((int)$data['idcidades']== 0){
			if($this->MCidades->cidadeExiste($data['cidade'])){
				json_echo('{success: false, errors: {cidadeField: "Cidade já cadastrada no sistema."}, errormsg:"Cidade já cadastrado no sistema."}');
				return;
			}	
		}
		if(array_key_exists('imagem', $_FILES)){
			if(strlen($_FILES['imagem']["tmp_name"])>0){
				$config['upload_path'] = './images/cidades/';
				$config['allowed_types'] = 'gif|jpg|png';
				$config['max_size']	= '500';
				$config['max_width']  = '1024';
				$config['max_height']  = '768';
				$config['overwrite']  = TRUE;
				
				$this->load->library('upload', $config);
				
				if (!$this->upload->do_upload('imagem')){
					json_echo('{success: false, errors: {imagemField: "' . $this->upload->display_errors() . '"}, errormsg:"' . $this->upload->display_errors() . '"}');
					return;
				}	
				else{
					$uploadData = $this->upload->data();
					$data['imagem'] = $uploadData['file_name'];
				}
			}
		}
		if($this->MCidades->salvaCidade($data)) json_echo("{success:true}");
		else json_echo("{success:false, errormsg:'Não foi possível gravar informações no banco de dados.'}");	
	}
	
	function removeCidades(){
		$ids = $this->input->post('ids', TRUE);
		$ids = json_decode($ids);
		$qtd = $this->MCidades->removeCidades($ids);
		json_echo('{success: true, qtd:' . $qtd . '}');
	}
}
?>