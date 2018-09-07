--CRIANDO CURSOR 

DECLARE
C_LIVROS CURSOR FOR --CRIANDO CURSOR PARA A TABELA LIVROS
SELECT NOME, VALOR FROM LIVROS
DECLARE
@NOME VARCHAR(30), @PRECO DECIMAL(10,2)

 OPEN C_LIVROS --ABRIU O CURSOS

FETCH NEXT FROM C_LIVROS -- PUXA O PRIMEIRO REGISTRO
INTO @NOME,@PRECO

WHILE @@FETCH_STATUS = 0	--ENQUANTO EXISTIR REGISTRO FETCH_STATUS = 0
BEGIN 
	PRINT 'VALOR DO LIVRO ' + @NOME + ' R$' + CAST(@PRECO AS VARCHAR(10))
	FETCH NEXT FROM C_LIVROS
	INTO @NOME,@PRECO

END
CLOSE C_LIVROS -- FECHA O CURSOR
DEALLOCATE C_LIVROS --TIRA O CURSOR DA MEMORIA
GO
