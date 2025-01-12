CREATE TABLE TB_VENDAS (
   CD_VENDA INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
   DT_VENDA DATETIME NOT NULL,
   CD_PRODUTO INT NOT NULL,
   QUANTIDADE INT NOT NULL,
   VALOR NUMERIC(10,2) NOT NULL
)


/* Tabela para log de altera��es na tabela de Vendas. As altera��es podem
   ser de tr�s tipos: (I - Inclusao, A - Alteracao, R - Remocao). O Log
   sempre armazena os valores antigos e os novos valores. Somente os 
   os atributos QUANTIDADE e VALOR podem ser alterados para uma venda. */

CREATE TABLE TB_LOG_VENDAS (
    CD_LOG 		INT IDENTITY (1,1) NOT NULL,
    DT_LOG 		DATETIME NOT NULL,     -- Data em que o log foi registrado
    TIPO_OPERACAO 	CHAR(1) CHECK (TIPO_OPERACAO IN ('I','A','R')),	
    CD_VENDA 		INT NULL,
    CD_PRODUTO 		INT NULL,
    DT_VENDA 		DATETIME NULL,
    QUANTIDADE_ANTIGA   INT NULL,
    VALOR_ANTIGO	NUMERIC(10,2) NULL,
    QUANTIDADE_NOVA	INT NULL,
    VALOR_NOVO		NUMERIC(10,2) NULL 
)


GO
CREATE OR ALTER TRIGGER TG_VENDAS_INSERT
ON TB_VENDAS
AFTER INSERT
AS
BEGIN 
	DECLARE @CD_VENDA INT, @DT_VENDA DATETIME, @CD_PRODUTO INT, @QUANTIDADE INT, @VALOR NUMERIC(10,2)
	SELECT @CD_VENDA = CD_VENDA, @DT_VENDA = DT_VENDA, @CD_PRODUTO = CD_PRODUTO, @QUANTIDADE = QUANTIDADE, @VALOR = VALOR 
	FROM INSERTED

	INSERT INTO TB_LOG_VENDAS
	VALUES(
	GETDATE(),
	'I',
	@CD_VENDA,
	@CD_PRODUTO,
	@DT_VENDA,
	NULL,
	NULL,
	@QUANTIDADE,
	@VALOR
	)
END
GO

GO
CREATE OR ALTER TRIGGER TG_VENDAS_UPDATE
ON TB_VENDAS
AFTER UPDATE
AS
BEGIN 
	DECLARE @CD_VENDA INT, @DT_VENDA DATETIME, @CD_PRODUTO INT, @QUANTIDADE_ANTIGA INT,@QUANTIDADE_NOVA  INT,@VALOR_ANTIGO INT, @VALOR_NOVO NUMERIC(10,2)

	SELECT @CD_VENDA = CD_VENDA, @DT_VENDA = DT_VENDA, @CD_PRODUTO = CD_PRODUTO, @QUANTIDADE_NOVA = QUANTIDADE, @VALOR_NOVO = VALOR 
	FROM INSERTED

	SELECT @QUANTIDADE_ANTIGA = QUANTIDADE, @VALOR_ANTIGO = VALOR 
	FROM DELETED

	INSERT INTO TB_LOG_VENDAS
	VALUES(
	GETDATE(),
	'A',
	@CD_VENDA,
	@CD_PRODUTO,
	@DT_VENDA,
	@QUANTIDADE_ANTIGA,
	@VALOR_ANTIGO,
	@QUANTIDADE_NOVA,
	@VALOR_NOVO
	)
END
GO

GO
CREATE OR ALTER TRIGGER TG_VENDAS_DELETE
ON TB_VENDAS
AFTER DELETE
AS
BEGIN 
	DECLARE @CD_VENDA INT, @DT_VENDA DATETIME, @CD_PRODUTO INT, @QUANTIDADE_ANTIGA INT,@QUANTIDADE_NOVA  INT,@VALOR_ANTIGO INT, @VALOR_NOVO NUMERIC(10,2)

	SELECT @CD_VENDA = CD_VENDA, @DT_VENDA = DT_VENDA, @CD_PRODUTO = CD_PRODUTO, @QUANTIDADE_ANTIGA = QUANTIDADE, @VALOR_ANTIGO = VALOR 
	FROM DELETED

	INSERT INTO TB_LOG_VENDAS
	VALUES(
	GETDATE(),
	'R',
	@CD_VENDA,
	@CD_PRODUTO,
	@DT_VENDA,
	@QUANTIDADE_ANTIGA,
	@VALOR_ANTIGO,
	NULL,
	NULL
	)
END
GO

SELECT * FROM TB_VENDAS
SELECT * FROM TB_LOG_VENDAS

INSERT INTO TB_VENDAS
VALUES(GETDATE(),1,7,100.50)

UPDATE TB_VENDAS
SET QUANTIDADE = 0,
	VALOR = 0
WHERE CD_PRODUTO = 1

DELETE TB_VENDAS
WHERE CD_PRODUTO = 1

DELETE TB_VENDAS
DELETE TB_LOG_VENDAS