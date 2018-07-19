<?php

class Pessoas extends Controller {

	function Pessoas(){
		parent::Controller();
		/*if(!$this->session->userdata('logged_in')) {
			redirect("login");
		}*/
		$this->load->helper('email');
	}
	
	function index(){
		
	}
	function pessoasGrid(){
		$idatributospessoais = "";
		$query = $this->input->post('query', TRUE);
		if(array_key_exists('idatributospessoais', $_POST)) $idatributospessoais = $this->input->post('idatributospessoais', TRUE);
		$limit = $this->input->post('limit', TRUE);
		$limit_start = $this->input->post('start', TRUE);
		$order_by = $this->input->post('sort', TRUE);
		$order_direction = $this->input->post('dir', TRUE);
		
		$query = Array('nome'=>$query);
		if((array_key_exists('idatributospessoais', $_POST)) && (strlen($idatributospessoais)>0)) $query['idatributospessoais'] = $idatributospessoais;
		$lista = $this->MPessoas->listaPessoas($query, $limit, $limit_start, $order_by, $order_direction);

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
	function getPessoa($idpessoas){	
		$query = Array('idpessoas'=>$idpessoas);
		$lista = $this->MPessoas->listaPessoas($query, 1, 0, 'nome', 'ASC');
		
		$registro = Array();
		foreach($lista[0][0]["atributos"] as $atributo){
			$registro["idatributospessoais[" . $atributo['idatributospessoais'] . "]"] = 1;
		}		
		unset($lista[0][0]["atributos"]); 
		$lista[0][0]['id-field-pessoas-atributospessoais'] = $registro;
		
		$registro = Array();
		foreach($lista[0][0]["permissoes"] as $atributo){
			$registro["idpermissoes[" . $atributo['idpermissoes'] . "]"] = 1;
		}		
		unset($lista[0][0]["permissoes"]); 
		$lista[0][0]['id-field-pessoas-permissoes'] = $registro;
		
		
		$nrows = count($lista[0]);
		if($nrows > 0){
			$resultado['success'] = true;
			$resultado['rows'] = $lista[0];
			$resultado['errors'] = "";
		}
		else {
			$resultado['success'] = false;
			$resultado['errormsg'] = "O registro especificado não foi encontrado.";
			$resultado['rows'] = Array();
		}
		json_echo(json_encode($resultado));
	}
	function accessControl(){
		$lista = $this->MPessoas->listaPermissoes($this->session->userdata('idpessoas'));
		$nrows = count($lista);
		if($nrows > 0){
			$resultado['success'] = true;
			$resultado['results'] = $nrows;
			$resultado['rows'] = $lista;
		}
		else {
			$resultado['success'] = true;
			$resultado['results'] = 0;
			$resultado['rows'] = Array();
		}
		json_echo(json_encode($resultado));
	}
	
	function pessoasGridPrint(){
		$data = array();
		
		$lista = $this->MPessoas->listaPessoas(Array(), 99999999, 0, "nome", "ASC");
		$temp = '';
		
		for ($i = 0; $i < count($lista[0]); $i++) {
			unset($lista[0][$i]['idcidades']);
		    unset($lista[0][$i]['desc']);
			unset($lista[0][$i]['permissoes']);
			unset($lista[0][$i]['participacoes']);
			unset($lista[0][$i]['acesso']);
			
			$temp = '';
			for ($j = 0; $j < count($lista[0][$i]['atributos']); $j++) {
				$temp .= $lista[0][$i]['atributos'][$j]['atributo'];
				if($j != count($lista[0][$i]['atributos'])-1) $temp .= ", ";
			}
			$lista[0][$i]['atributos'] = $temp;
		}
		

		$this->load->library('table');
		
		$this->table->set_heading('ID', 'Nome', 'Email', 'Telefone', 'Celular', 'Endereço', 'Bairro', 'Cidade', 'Atributos');
		
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
	
	function salvaPessoaGrid(){
		$data = Array();
		if(array_key_exists('idpessoas', $_POST)) $data['idpessoas'] = $this->input->post('idpessoas', TRUE);
		if(array_key_exists('nome', $_POST)) $data['nome'] = $this->input->post('nome', TRUE);
		if(array_key_exists('email', $_POST)) $data['email'] = $this->input->post('email', TRUE);
		if(array_key_exists('telefone', $_POST)) $data['telefone'] = $this->input->post('telefone', TRUE);
		if(array_key_exists('celular', $_POST)) $data['celular'] = $this->input->post('celular', TRUE);
		if(array_key_exists('idcidades', $_POST)) $data['idcidades'] = $this->input->post('idcidades', TRUE);
		if(array_key_exists('acesso', $_POST)) $data['acesso'] = $this->input->post('acesso', TRUE);

		if(array_key_exists("email", $data)){
			if (!valid_email($data["email"])){
				json_echo("{success:false, errormsg:'Formato de email inválido.'}");
				return;
			}
		}
		if($this->MPessoas->salvaPessoaGrid($data)) json_echo("{success:true}");
		else json_echo("{success:false, errormsg:'Não foi possível gravar informações no banco de dados.'}");
	}
	function salvaPessoa(){
		$data = array(
			'idpessoas' => $this->input->post('idpessoas', TRUE),
			'nome' => $this->input->post('nome', TRUE),
			'email' => $this->input->post('email', TRUE),
			'senha' => dohash($this->input->post('senha', TRUE)),
			'telefone' => $this->input->post('telefone', TRUE),
			'celular' => $this->input->post('celular', TRUE),
			'endereco' => $this->input->post('endereco', TRUE),
			'bairro' => $this->input->post('bairro', TRUE),
			'idcidades' => $this->input->post('idcidades', TRUE),
			'desc' => $this->input->post('desc', TRUE),
			'idatributospessoais' => $this->input->post('idatributospessoais', TRUE),
			'idpermissoes' => $this->input->post('idpermissoes', TRUE),
			'acesso' => array_key_exists("acesso", $_POST) ? true : false,
		);
		$confirma = dohash(xss_clean($_POST['confirmaSenha']));
		
		if (!valid_email($data["email"])){
			json_echo('{success: false, errors: {"id-field-pessoas-email": "Formato de email inválido."}, errormsg:"Formato de email inválido."}');
			return;
		}
		if($data["senha"] != $confirma){
			json_echo('{success: false, errors: {"id-field-pessoas-senha": "Senhas não conferem.", "id-field-pessoas-confirmasenha":"Senhas não conferem."}, errormsg:"Senhas não conferem."}');
			return;
		}
		if((int)$data['idpessoas']== 0){
			if($this->MPessoas->pessoaExiste($data['email'])){
				json_echo('{success: false, errors: {"id-field-pessoas-email": "Email já cadastrado no sistema."}, errormsg:"Email já cadastrado no sistema."}');
				return;
			}	
		}
		else{
			if(strlen(xss_clean($_POST['senha']))==0) unset($data["senha"]);
		}
		if($this->MPessoas->salvaPessoa($data)) json_echo("{success:true}");
		else json_echo("{success:false, errormsg:'Não foi possível gravar informações no banco de dados.'}");
	}
	
	function removePessoas(){
		$ids = $this->input->post('ids', TRUE);
		$ids = json_decode($ids);
		$qtd = $this->MPessoas->removePessoas($ids);
		json_echo('{success: true, qtd:' . $qtd . '}');
	}
}
?>