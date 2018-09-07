/*PREENCHENDO NOTAS FISCALS */
DECLARE 
	@ID_CLIENTE INT, @ID_VENDEDOR INT, @ID_FORMA INT, @DATA DATE, @MES int, @DIA int
BEGIN
	SET @ID_CLIENTE =  (SELECT TOP 1 IDCLIENTE FROM CLIENTE ORDER BY NEWID())
	SET @ID_VENDEDOR = (SELECT TOP 1 IDVENDEDOR FROM VENDEDOR ORDER BY NEWID())
	SET @ID_FORMA = (SELECT TOP 1 IDFORMA_PAGAMENTO FROM FORMA_PAGAMENTO ORDER BY NEWID())
	SET @MES = (CONVERT(INT,RAND() * 13))
	SET @DIA = 31
	
	IF (@MES = 2)
	BEGIN 
	SET @DIA = 29
	END

	SET @DATA =		(
						SELECT 
						CONVERT(
				DATE,
				CONVERT(VARCHAR(15),'2018') + '-' + CONVERT(VARCHAR(5),@mes) + '-'
				+ CONVERT(VARCHAR(5),
				CONVERT(INT,RAND() * @dia))
								)
					)
	INSERT INTO NOTA_FISCAL (ID_CLIENTE,ID_VENDEDOR,ID_FORMA_PAGAMENTO,DATA_NOTA)
	VALUES (@ID_CLIENTE,@ID_VENDEDOR,@ID_FORMA,@DATA)
END
GO 