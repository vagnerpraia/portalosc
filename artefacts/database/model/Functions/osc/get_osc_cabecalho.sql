CREATE OR REPLACE FUNCTION portal.get_osc_cabecalho(id_request INTEGER) RETURNS TABLE (
	cd_identificador_osc NUMERIC(14, 0),
	ft_identificador_osc TEXT,
	tx_razao_social_osc TEXT,
	ft_razao_social_osc TEXT,
	tx_subclasse_atividade_economica TEXT,
	ft_atividade_economica_osc TEXT,
	tx_natureza_juridica TEXT,
	ft_natureza_juridica_osc TEXT,
	im_logo BYTEA,
	ft_logo TEXT
) AS $$
BEGIN
	RETURN QUERY
		SELECT
			vw_osc_cabecalho.cd_identificador_osc,
			vw_osc_cabecalho.ft_identificador_osc,
			vw_osc_cabecalho.tx_razao_social_osc,
			vw_osc_cabecalho.ft_razao_social_osc,
			vw_osc_cabecalho.tx_subclasse_atividade_economica,
			vw_osc_cabecalho.ft_atividade_economica_osc,
			vw_osc_cabecalho.tx_natureza_juridica,
			vw_osc_cabecalho.ft_natureza_juridica_osc,
			vw_osc_cabecalho.im_logo,
			vw_osc_cabecalho.ft_logo
		FROM portal.vw_osc_cabecalho
		WHERE vw_osc_cabecalho.id_osc = id_request;
	RETURN;
END;
$$ LANGUAGE 'plpgsql'