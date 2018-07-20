<?php

class Teste extends CI_Controller {

	
	function index(){
		
	}

	function testeGrid(){
		$data = Array(
        	Array("id" => 1, "empresa" => '3m Co',									"valor" => 71.72,	"variacao" => 0.02,		"percentual" => 0.03,	"data"=>'9/1 12:00am'),
	        Array("id" => 2, "empresa" => 'Alcoa Inc', 								"valor" => 29.01,	"variacao" => 0.42,		"percentual" => 1.47,	"data"=>'9/1 12:00am'),
	        Array("id" => 3, "empresa" => 'Altria Group Inc', 						"valor" => 83.81,	"variacao" => 0.28,		"percentual" => 0.34,	"data"=>'9/1 12:00am'),
	        Array("id" => 4, "empresa" => 'American Express Company', 				"valor" => 52.55,	"variacao" => 0.01,		"percentual" => 0.02,	"data"=>'9/1 12:00am'),
	        Array("id" => 5, "empresa" => 'American International Group, Inc.', 	"valor" => 64.13,	"variacao" => 0.31,		"percentual" => 0.49,	"data"=>'9/1 12:00am'),
	        Array("id" => 6, "empresa" => 'AT&T Inc.', 								"valor" => 31.61,	"variacao" => -0.48,	"percentual" => -1.54,	"data"=>'9/1 12:00am'),
	        Array("id" => 7, "empresa" => 'Boeing Co.', 							"valor" => 75.43,	"variacao" => 0.53,		"percentual" => 0.71,	"data"=>'9/1 12:00am'),
	        Array("id" => 8, "empresa" => 'Caterpillar Inc.', 						"valor" => 67.27,	"variacao" => 0.92,		"percentual" => 1.39,	"data"=>'9/1 12:00am'),
	        Array("id" => 9, "empresa" => 'Citigroup, Inc.', 						"valor" => 49.37,	"variacao" => 0.02,		"percentual" => 0.04,	"data"=>'9/1 12:00am'),
	        Array("id" => 10, "empresa" => 'E.I. du Pont de Nemours and Company',	"valor" => 40.48,	"variacao" => 0.51,		"percentual" => 1.28,	"data"=>'9/1 12:00am'),
	        Array("id" => 11, "empresa" => 'Exxon Mobil Corp', 						"valor" => 68.1,	"variacao" => -0.43,	"percentual" => -0.64,	"data"=>'9/1 12:00am'),
	        Array("id" => 12, "empresa" => 'General Electric Company', 				"valor" => 34.14,	"variacao" => -0.08,	"percentual" => -0.23,	"data"=>'9/1 12:00am'),
	        Array("id" => 13, "empresa" => 'General Motors Corporation', 			"valor" => 30.27,	"variacao" => 1.09,		"percentual" => 3.74,	"data"=>'9/1 12:00am'),
	        Array("id" => 14, "empresa" => 'Hewlett-Packard Co.', 					"valor" => 36.53,	"variacao" => -0.03,	"percentual" => -0.08,	"data"=>'9/1 12:00am'),
	        Array("id" => 15, "empresa" => 'Honeywell Intl Inc', 					"valor" => 38.77,	"variacao" => 0.05,		"percentual" => 0.13,	"data"=>'9/1 12:00am'),
	        Array("id" => 16, "empresa" => 'Intel Corporation', 					"valor" => 19.88,	"variacao" => 0.31,		"percentual" => 1.58,	"data"=>'9/1 12:00am'),
	        Array("id" => 17, "empresa" => 'International Business Machines',		"valor" => 81.41,	"variacao" => 0.44,		"percentual" => 0.54,	"data"=>'9/1 12:00am'),
	        Array("id" => 18, "empresa" => 'Johnson & Johnson',						"valor" => 64.72,	"variacao" => 0.06,		"percentual" => 0.09,	"data"=>'9/1 12:00am'),
	        Array("id" => 19, "empresa" => 'JP Morgan & Chase & Co', 				"valor" => 45.73,	"variacao" => 0.07,		"percentual" => 0.15,	"data"=>'9/1 12:00am'),
	        Array("id" => 20, "empresa" => 'McDonald\'s Corporation', 				"valor" => 36.76,	"variacao" => 0.86,		"percentual" => 2.40,	"data"=>'9/1 12:00am'),
	        Array("id" => 21, "empresa" => 'Merck & Co., Inc.',						"valor" => 40.96,	"variacao" => 0.41,		"percentual" => 1.01,	"data"=>'9/1 12:00am'),
	        Array("id" => 22, "empresa" => 'Microsoft Corporation', 				"valor" => 25.84,	"variacao" => 0.14,		"percentual" => 0.54,	"data"=>'9/1 12:00am'),
	        Array("id" => 23, "empresa" => 'Pfizer Inc', 							"valor" => 27.96,	"variacao" => 0.4,		"percentual" => 1.45,	"data"=>'9/1 12:00am'),
	        Array("id" => 24, "empresa" => 'The Coca-Cola Company', 				"valor" => 45.07,	"variacao" => 0.26,		"percentual" => 0.58,	"data"=>'9/1 12:00am'),
	        Array("id" => 25, "empresa" => 'The Home Depot, Inc.', 					"valor" => 34.64,	"variacao" => 0.35,		"percentual" => 1.02,	"data"=>'9/1 12:00am'),
	        Array("id" => 26, "empresa" => 'The Procter & Gamble Company', 			"valor" => 61.91,	"variacao" => 0.01,		"percentual" => 0.02,	"data"=>'9/1 12:00am'),
	        Array("id" => 27, "empresa" => 'United Technologies Corporation', 		"valor" => 63.26,	"variacao" => 0.55,		"percentual" => 0.88,	"data"=>'9/1 12:00am'),
	        Array("id" => 28, "empresa" => 'Verizon Communications', 				"valor" => 35.57,	"variacao" => 0.39,		"percentual" => 1.11,	"data"=>'9/1 12:00am'),
	        Array("id" => 29, "empresa" => 'Wal-Mart Stores, Inc.', 				"valor" => 45.45,	"variacao" => 0.73,		"percentual" => 1.63,	"data"=>'9/1 12:00am')
    	);
		$resultado['success'] = true;
		$resultado['results'] = 29;
		$resultado['rows'] = $data;
		json_echo(json_encode($resultado));
	}
	
	
	
	function salvaTesteGrid(){
		$data = array(
			'idagenda' => $this->input->post('idagenda', TRUE),
			'novos' => $this->input->post('novos', TRUE),
			'total' => $this->input->post('total', TRUE)
		);
		
		if($this->MAgenda->salvaAgendaGrid($data)) json_echo("{success:true}");
		else json_echo("{success:false, errormsg:'Não foi possível gravar informações no banco de dados.'}");
	}
	function salvaTeste(){
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
			$data = split("/", $data);
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
	
	function removeTeste(){
		$ids = $_POST['ids'];
		$ids = json_decode(stripslashes($ids));
		$qtd = $this->MAgenda->removePessoas($ids);
		json_echo('{success: true, qtd:' . $qtd . '}');
	}
}
?>