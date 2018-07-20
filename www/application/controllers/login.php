<?php

class Login extends CI_Controller {

	function Login(){
		parent::__construct();
	}
	
	function index(){
		if($this->session->userdata('logged_in')) {
			redirect("desktop");
		}
		else {
			$data["background"] = $this->retornaBackground();
			$this->load->view('login-view', $data);
		}
	}
	
	function doLogin(){
		$pessoa = array();
		
		$loginUsername = $this->input->post('loginUsername', TRUE);
		$loginPassword = $this->input->post('loginPassword', TRUE);
		$background = $this->input->post('background', TRUE);
		
		
		$pessoa = $this->MPessoas->checkLogin($loginUsername,$loginPassword);
		if(count($pessoa) > 0){
			if($pessoa['acesso'] == true){
				$this->session->sess_destroy();

				setcookie("usuario", htmlentities($pessoa['nome'], ENT_QUOTES, 'UTF-8'), false, "/", false);
	            $this->session->sess_create();
	            $this->session->set_userdata($pessoa);
	            $this->session->set_userdata(array('logged_in' => true));
	            $this->session->set_userdata(array('background' => $background));
				$this->session->set_userdata(array('isLoggedIn' => true));
				$this->session->set_userdata(array('logged_in' => true));

				//Session para o Image Manager
				session_start();
				$_SESSION['isLoggedIn'] = true;
				$_SESSION['user'] = htmlentities($pessoa['nome'], ENT_QUOTES, 'UTF-8');
	            
				$result["success"] = true;
			}
			else{
				$result["success"] = false;
			    $result["errormsg"] = "Você é um usuários registrado mas não tem permissão de acesso a este sistema.";
			}
		}
		else {
			$result["success"] = false;
		    $result["errors"]["loginPassword"] = "Nome de usuário ou senha inválidos.";
		    $result["errormsg"] = "Nome de usuário ou senha inválidos.";
		}
		json_echo(json_encode($result));
	}

    function logout() {
        //Put here for PHP 4 users
        $this->CI =& get_instance();

        //Destroy session
        $this->CI->session->sess_destroy();
    }
    
    private function retornaBackground(){
    	$path = $_SERVER['DOCUMENT_ROOT'] . "/showcase/adhonep/wallpapers/";
	    $dir=opendir($path);
	    
	    $i=0;
	    while($imgfile=readdir($dir))
	    {
	         if ($imgfile != "." && $imgfile!=".." && $imgfile!="thumb.db" && $imgfile!=".svn")
	             {
	            $imgarray[$i]=$imgfile;
	            $i++;
	            }
	    }
	    closedir($dir);
	    $num = intval(file_get_contents("bg.txt"));
	    $num++;
	    if($num > (count($imgarray)-1)) $num = 0;
	    file_put_contents("bg.txt", strval($num));
	    $fundo = $imgarray[$num];
	    return $fundo;
    }
}
?>
