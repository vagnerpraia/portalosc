DROP FUNCTION IF EXISTS portal.obter_osc_descricao(param TEXT);

CREATE OR REPLACE FUNCTION portal.obter_osc_descricao(param TEXT) RETURNS TABLE (
	tx_como_surgiu TEXT, 
	ft_como_surgiu TEXT, 
	tx_missao_osc TEXT, 
	ft_missao_osc TEXT, 
	tx_visao_osc TEXT, 
	ft_visao_osc TEXT, 
	tx_finalidades_estatutarias TEXT, 
	ft_finalidades_estatutarias TEXT
) AS $$ 
BEGIN 
	RETURN QUERY 
		SELECT 
			vw_osc_descricao.tx_como_surgiu, 
			vw_osc_descricao.ft_como_surgiu, 
			vw_osc_descricao.tx_missao_osc, 
			vw_osc_descricao.ft_missao_osc, 
			vw_osc_descricao.tx_visao_osc, 
			vw_osc_descricao.ft_visao_osc, 
			vw_osc_descricao.tx_finalidades_estatutarias, 
			vw_osc_descricao.ft_finalidades_estatutarias 
		FROM portal.vw_osc_descricao 
		WHERE 
			vw_osc_descricao.id_osc::TEXT = param OR 
			vw_osc_descricao.tx_url_osc = param;
	RETURN;
END;
$$ LANGUAGE 'plpgsql';