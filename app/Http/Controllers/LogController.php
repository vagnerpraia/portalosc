<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Dao\LogDao;

class LogController extends Controller
{
	public function __construct()
	{
		$this->log = new LogDao();
	}

    public function saveLog($table_name, $id_osc, $id_user, $tx_dado_anterior, $tx_dado_posterior){
    	if($tx_dado_posterior){
    		$tx_dado_anterior = '{' . rtrim($tx_dado_anterior, ',') . '}';
    		$tx_dado_posterior = '{' . rtrim($tx_dado_posterior, ',') . '}';

    		$params = [$table_name, $id_osc, $id_user, date("Y-m-d H:i:s"), $tx_dado_anterior, $tx_dado_posterior];
    		//$resultDaoLog = $this->log->insertLog2($params);
    	}
    }
}
