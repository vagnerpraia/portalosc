<?php

namespace App\Dao;

use App\Dao\Dao;

class GeoDao extends Dao
{
	private $queriesRegion = array(
    	/* Estrutura: nome_componente => [query_sql, is_unique] */
        "municipio" => ["SELECT * FROM portal.obter_geo_osc_municipio(?::NUMERIC);", false],
        "estado" => ["SELECT * FROM portal.obter_geo_osc_estado(?::SMALLINT);", false],
        "regiao" => ["SELECT * FROM portal.obter_geo_osc_regiao(?::SMALLINT);", false]
    );

    public function getOsc($id)
	{
	    $query = "SELECT * FROM portal.obter_geo_osc(?::INTEGER);";
				$result = $this->executeQuery($query, true, [$id]);
        return $result;
    }

	private function configResultGeo($result){
		$json = [[]];

		for ($i = 0; $i<count($result); $i++) {
			//print_r($result[$i]->geo_lat);
				$json[$result[$i]->id_osc][0] = $result[$i]->geo_lat;//lat
				$json[$result[$i]->id_osc][1] = $result[$i]->geo_lng;//lng
		}

		return $json;
	}

	public function getOscRegion($region, $id)
	{
        if(array_key_exists($region, $this->queriesRegion)){
        	$query_info = $this->queriesRegion[$region];
	    	$query = $query_info[0];
	    	$unique = $query_info[1];
	    	if(($region == 'regiao' && intval($id) <= 5) || ($region == 'estado' && intval($id) <= 53) || ($region == 'municipio' && strlen($id) <= 7)){
        		$result = $this->executeQuery($query, $unique, [$id]);
	    	}else{
	    		$result = null;
	    	}
        }
        return $result;
    }

    public function getOscCountry()
	{
	    $query = "SELECT * FROM portal.obter_geo_osc_pais();";
        $result = $this->executeQuery($query, false, null);

        return $this->configResultGeo($result);
    }

    public function getOscArea($north, $south, $east, $west)
	{
	    $query = "SELECT vw_geo_osc.id_osc, vw_geo_osc.geo_lat, vw_geo_osc.geo_lng
					FROM portal.vw_geo_osc
					WHERE ST_MakePoint(vw_geo_osc.geo_lng, vw_geo_osc.geo_lat) && ST_MakeEnvelope(".$west.", ".$south.", ".$east.", ".$north.", 4674);";
        $result = $this->executeQuery($query, false, null);
        return $result;
    }

	public function getClusterRegion($region, $id)
	{
		if($region == 'regiao'){
			$query = "SELECT
						vw_geo_osc.cd_regiao,
						vw_geo_osc.tx_nome_regiao,
						count(*) AS nr_quantidade_osc
					FROM portal.vw_geo_osc
					GROUP BY vw_geo_osc.cd_regiao, tx_nome_regiao;";
		}else{
			if($id){
				if ($region == 'estado') {
					$query = "SELECT
								vw_geo_osc.cd_estado,
								vw_geo_osc.tx_nome_estado,
								vw_geo_osc.tx_sigla_estado,
								count(*) AS nr_quantidade_osc
							FROM portal.vw_geo_osc
							WHERE vw_geo_osc.cd_regiao = " . $id . "
							GROUP BY vw_geo_osc.cd_estado, tx_nome_estado, tx_sigla_estado;";
				}elseif ($region == 'municipio') {
					$query = "SELECT
								vw_geo_osc.cd_municipio,
								vw_geo_osc.tx_nome_municipio,
								count(*) AS nr_quantidade_osc
							FROM portal.vw_geo_osc
							WHERE vw_geo_osc.cd_estado = " . $id . "
							GROUP BY vw_geo_osc.cd_municipio, tx_nome_municipio;";
				}
			}else{
				if ($region == 'estado') {
					$query = "SELECT
								vw_geo_osc.cd_estado,
								vw_geo_osc.tx_nome_estado,
								vw_geo_osc.tx_sigla_estado,
								count(*) AS nr_quantidade_osc
							FROM portal.vw_geo_osc
							GROUP BY vw_geo_osc.cd_estado, tx_nome_estado, tx_sigla_estado;";
				}elseif ($region == 'municipio') {
					$query = "SELECT
								vw_geo_osc.cd_municipio,
								vw_geo_osc.tx_nome_municipio,
								count(*) AS nr_quantidade_osc
							FROM portal.vw_geo_osc
							GROUP BY vw_geo_osc.cd_municipio, tx_nome_municipio;";
				}
			}
		}
        $result = $this->executeQuery($query, false, null);
        return $result;
	}



// ==================================================================================================== \\
    public function getTestCluster()
	{
// 	    $query = "SELECT 
// 					row_number() over () AS id_cluster,
// 					ST_NumGeometries(cluster) AS nr_quantidade_osc,
// 					cluster AS geom_collection,
// 					ST_Y(ST_Centroid(cluster)) AS geo_lat,
// 					ST_X(ST_Centroid(cluster)) AS geo_lng
// 				FROM (
// 					SELECT unnest(ST_ClusterWithin(ST_MakePoint(data.geo_lng, data.geo_lat), 1)) AS cluster 
// 					FROM (
// 						SELECT * 
// 						FROM portal.vw_geo_osc 
// 						WHERE substr(cd_municipio::text, 0, 3)::NUMERIC(2, 0) = 13
// 	    				OR substr(cd_municipio::text, 0, 3)::NUMERIC(2, 0) = 13
// 						LIMIT 1000000
// 					) AS data
// 				) f;";
	    
	    $query = "SELECT
					row_number() over () AS id_cluster,
					ST_NumGeometries(cluster) AS nr_quantidade_osc,
					cluster AS geom_collection,
					ST_Y(ST_Centroid(cluster)) AS geo_lat,
					ST_X(ST_Centroid(cluster)) AS geo_lng
				FROM (
					SELECT unnest(ST_ClusterWithin(ST_MakePoint(data.geo_lng, data.geo_lat), 0.5)) AS cluster
					FROM (
						SELECT *
						FROM portal.vw_geo_osc
						WHERE substr(cd_municipio::text, 0, 1)::NUMERIC(1, 0) = 1
						LIMIT 1000000
					) AS data
				) f;";
	    
        $result = $this->executeQuery($query, false, null);
        return $result;
    }
}
