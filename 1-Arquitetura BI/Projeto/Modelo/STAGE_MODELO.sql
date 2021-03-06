-- TODO POR � UM CANDIDATO A SER UMA DIMENS�O
--CLIENTE 
--VENDEDOR
--CATEGORIA
--FORNECEDOR
--PRODUTO
--FORMA PAGAMENTO
-- ANTES DO POR TEMOS UM FATO - S�O AS MEDIDAS DO NEG�CIO
--TOTAL, QUANTIDADE, CUSTO_MEDIO - VALOR = LUCRO, CUSTO, 
USE COMERCIO_STAGE
GO
CREATE TABLE ST_CLIENTE
(
	IDCLIENTE INT DEFAULT NULL,
	NOME VARCHAR(100) DEFAULT NULL,
	SEXO VARCHAR (20) DEFAULT NULL,
	NASCIMENTO DATE DEFAULT NULL,
	CIDADE VARCHAR(100) DEFAULT NULL,
	ESTADO VARCHAR (10) DEFAULT NULL,
	REGIAO VARCHAR(20) DEFAULT NULL
)
GO
CREATE TABLE ST_VENDEDOR
(
	IDVENDEDOR INT DEFAULT NULL,
	NOME VARCHAR(70) DEFAULT NULL,
	SEXO VARCHAR(20) DEFAULT NULL,
	ID_GERENTE INT DEFAULT NULL
)
GO
CREATE TABLE ST_CATEGORIA
(
	IDCATEGORIA INT DEFAULT NULL,
	NOME VARCHAR (50) DEFAULT NULL
)
GO
CREATE TABLE ST_FORNECEDOR
(
	IDFORNECEDOR INT DEFAULT NULL,
	NOME VARCHAR (100)
)
GO
CREATE TABLE ST_PRODUTO
(
	IDPRODUTO INT DEFAULT NULL,
	NOME VARCHAR(50) DEFAULT NULL,
	VALOR_UNITARIO NUMERIC(10,2) DEFAULT NULL,
	CUSTO_MEDIO NUMERIC(10,2) DEFAULT NULL,
	ID_CATEGORIA INT DEFAULT NULL
)
GO
CREATE TABLE ST_NOTA_FISCAL
(
	IDNOTA_FISCAL INT DEFAULT NULL,
)
CREATE TABLE ST_FORMA_PAGAMENTO
(
	IDFORMA_PAGAMENTO INT DEFAULT NULL,
	NOME VARCHAR(50) DEFAULT NULL
)
GO
CREATE TABLE ST_FATO
(
	ID_CLIENTE INT DEFAULT NULL,
	ID_VENDEDOR INT DEFAULT NULL,
	ID_PRODUTO INT DEFAULT NULL,
	ID_FORNECEDOR INT DEFAULT NULL,
	ID_NOTA_FISCAL INT DEFAULT NULL,
	ID_FORMA_PAGAMENTO INT DEFAULT NULL,
	QUANTIDADE INT DEFAULT NULL,
	TOTAL_ITEM NUMERIC(10,2) DEFAULT NULL,
	DATA_VENDA DATE DEFAULT NULL, 
	CUSTO_TOTAL NUMERIC(10,2) DEFAULT NULL,
	LUCRO_TOTAL NUMERIC(10,2) DEFAULT NULL,
)