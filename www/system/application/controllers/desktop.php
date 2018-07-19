<?php

class Desktop extends Controller {

	function Desktop(){
		parent::Controller();
		if($this->session->userdata('logged_in')) {
			$data["background"] = $this->session->userdata('background');
			$this->load->view('desktop-view', $data);
		}
		else {
			redirect("login");
		}
	}
	
	function index(){
		
	}
}
?>