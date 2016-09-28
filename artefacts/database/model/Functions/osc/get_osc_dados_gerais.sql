﻿CREATE OR REPLACE FUNCTION portal.get_osc_dados_gerais(id_request INTEGER) RETURNS TABLE (
	cd_identificador_osc NUMERIC(14, 0),
	ft_identificador_osc TEXT,
	tx_razao_social_osc TEXT,
	ft_razao_social_osc TEXT,
	tx_nome_fantasia_osc TEXT,
	ft_nome_fantasia_osc TEXT,
	im_logo BYTEA,
	ft_logo TEXT,
	tx_atividade_economica_osc TEXT,
	ft_atividade_economica_osc TEXT,
	tx_natureza_juridica_osc TEXT,
	ft_natureza_juridica_osc TEXT,
	tx_sigla_osc TEXT,
	ft_sigla_osc TEXT,
	tx_url_osc TEXT,
	ft_url_osc TEXT,
	dt_fundacao_osc DATE,
	ft_fundacao_osc TEXT,
	tx_nome_responsavel_legal TEXT,
	ft_nome_responsavel_legal TEXT,
	tx_link_estatuto_osc TEXT,
	ft_link_estatuto_osc TEXT,
	tx_resumo_osc TEXT,
	ft_resumo_osc TEXT,
	tx_endereco TEXT,
	ft_endereco TEXT,
	nr_localizacao INTEGER,
	ft_localizacao TEXT,
	tx_endereco_complemento TEXT,
	ft_endereco_complemento TEXT,
	tx_bairro TEXT,
	ft_bairro TEXT,
	tx_municipio CHARACTER VARYING(50),
	ft_municipio TEXT,
	tx_uf CHARACTER VARYING(2),
	ft_uf TEXT,
	nr_cep NUMERIC(8, 0),
	ft_cep TEXT,
	tx_email TEXT,
	ft_email TEXT,
	tx_site TEXT,
	ft_site TEXT,
	tx_telefone TEXT,
	ft_telefone TEXT
) AS $$
BEGIN
	RETURN QUERY
		SELECT
			vw_osc_dados_gerais.cd_identificador_osc,
			vw_osc_dados_gerais.ft_identificador_osc,
			vw_osc_dados_gerais.tx_razao_social_osc,
			vw_osc_dados_gerais.ft_razao_social_osc,
			vw_osc_dados_gerais.tx_nome_fantasia_osc,
			vw_osc_dados_gerais.ft_nome_fantasia_osc,
			vw_osc_dados_gerais.im_logo,
			vw_osc_dados_gerais.ft_logo,
			vw_osc_dados_gerais.tx_atividade_economica_osc,
			vw_osc_dados_gerais.ft_atividade_economica_osc,
			vw_osc_dados_gerais.tx_natureza_juridica_osc,
			vw_osc_dados_gerais.ft_natureza_juridica_osc,
			vw_osc_dados_gerais.tx_sigla_osc,
			vw_osc_dados_gerais.ft_sigla_osc,
			vw_osc_dados_gerais.tx_url_osc,
			vw_osc_dados_gerais.ft_url_osc,
			vw_osc_dados_gerais.dt_fundacao_osc,
			vw_osc_dados_gerais.ft_fundacao_osc,
			vw_osc_dados_gerais.tx_nome_responsavel_legal,
			vw_osc_dados_gerais.ft_nome_responsavel_legal,
			vw_osc_dados_gerais.tx_link_estatuto_osc,
			vw_osc_dados_gerais.ft_link_estatuto_osc,
			vw_osc_dados_gerais.tx_resumo_osc,
			vw_osc_dados_gerais.ft_resumo_osc,
			vw_osc_dados_gerais.tx_endereco,
			vw_osc_dados_gerais.ft_endereco,
			vw_osc_dados_gerais.nr_localizacao,
			vw_osc_dados_gerais.ft_localizacao,
			vw_osc_dados_gerais.tx_endereco_complemento,
			vw_osc_dados_gerais.ft_endereco_complemento,
			vw_osc_dados_gerais.tx_bairro,
			vw_osc_dados_gerais.ft_bairro,
			vw_osc_dados_gerais.tx_municipio,
			vw_osc_dados_gerais.ft_municipio,
			vw_osc_dados_gerais.tx_uf,
			vw_osc_dados_gerais.ft_uf,
			vw_osc_dados_gerais.nr_cep,
			vw_osc_dados_gerais.ft_cep,
			vw_osc_dados_gerais.tx_email,
			vw_osc_dados_gerais.ft_email,
			vw_osc_dados_gerais.tx_site,
			vw_osc_dados_gerais.ft_site,
			vw_osc_dados_gerais.tx_telefone,
			vw_osc_dados_gerais.ft_telefone
		FROM portal.vw_osc_dados_gerais
		WHERE vw_osc_dados_gerais.id_osc = id_request;
	RETURN;
END;
$$ LANGUAGE 'plpgsql'