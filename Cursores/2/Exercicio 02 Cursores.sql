CREATE TABLE TB_FUNCIONARIO (
  MATRICULA INT NOT NULL PRIMARY KEY,
  NOME VARCHAR(50) NOT NULL
) 

CREATE TABLE TB_DEPENDENTES (
  ID_DEPENDENTE INT NOT NULL IDENTITY(1,1),
  MATRICULA INT NOT NULL REFERENCES TB_FUNCIONARIO(MATRICULA),
  NOME VARCHAR(50) NOT NULL
  PRIMARY KEY (ID_DEPENDENTE, MATRICULA)
)

INSERT INTO TB_FUNCIONARIO VALUES (1, 'JOS� RICARDO')
INSERT INTO TB_FUNCIONARIO VALUES (2, 'ANA MILLER')

INSERT INTO TB_DEPENDENTES VALUES (1, 'ROBERTA'),
                                  (1, 'RITA'),
				  (1, 'GABRIELA')

INSERT INTO TB_DEPENDENTES VALUES (2, 'GUSTAVO'),
                                   (2, 'MARIANA')
