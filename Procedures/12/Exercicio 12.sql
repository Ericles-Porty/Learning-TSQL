-- Exerc�cio 12

CREATE TABLE TB_VENDAS (
  CD_VENDA INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  DT_VENDA DATETIME,
  MATRICULA INT,
  CD_PRODUTO INT,
  QUANTIDADE NUMERIC(10,2)
)

CREATE TABLE TB_VENDAS_MENSAL (
  MATRICULA INT,
  ANO INT,
  MES INT,
  QUANTIDADE_MES_ATUAL NUMERIC(10,2),
  QUANTIDADE_MES_ANTERIOR NUMERIC(10,2),
  VARIACAO NUMERIC(10,2)
)

INSERT INTO TB_VENDAS VALUES('20180101', 10,1001,50)
INSERT INTO TB_VENDAS VALUES('20180101', 10,1002,50)
INSERT INTO TB_VENDAS VALUES('20180201', 10,1001,150)
INSERT INTO TB_VENDAS VALUES('20180101', 30,1001,200)
INSERT INTO TB_VENDAS VALUES('20180101', 30,1001,100)
INSERT INTO TB_VENDAS VALUES('20180201', 30,1001,150)
INSERT INTO TB_VENDAS VALUES('20180501', 40,1002,100)
INSERT INTO TB_VENDAS VALUES('20180510', 40,1002,200)
INSERT INTO TB_VENDAS VALUES('20180705', 40,1001,250)
