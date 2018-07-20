<?php

class Desktop extends CI_Controller {

	function __construct() {
        parent::__construct();

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