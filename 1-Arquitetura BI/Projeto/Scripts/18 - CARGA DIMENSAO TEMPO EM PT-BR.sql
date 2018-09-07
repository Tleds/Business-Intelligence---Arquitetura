		-------------------------------
		--CARREGANDO A DIMENS�O TEMPO--
		-------------------------------

		--EXIBINDO A DATA ATUAL

		PRINT CONVERT(VARCHAR,GETDATE(),113) 

		--ALTERANDO O INCREMENTO PARA IN�CIO EM 5000
		--PARA A POSSIBILIDADE DE DATAS ANTERIORES

		DBCC CHECKIDENT (DIM_TEMPO, RESEED, 50000) 

		--INSER��O DE DADOS NA DIMENS�O

		DECLARE    @DATAINICIO DATETIME 
				 , @DATAFIM DATETIME 
				 , @DATA DATETIME
		 		  
		PRINT GETDATE() 

				SELECT @DATAINICIO = '1/1/1950' 
					, @DATAFIM = '1/1/2050'

				SELECT @DATA = @DATAINICIO 

		WHILE @DATA < @DATAFIM 
		 BEGIN 
	
			INSERT INTO DIM_TEMPO 
			( 
				  DATA, 
				  DIA,
				  DIA_SEMANA, 
				  MES,
				  NOME_MES, 
				  QUARTO,
				  NOMEQUARTO, 
				  ANO 
		
			) 
			SELECT @DATA AS DATA, DATEPART(DAY,@DATA) AS DIA, 

				 CASE DATEPART(DW, @DATA) 
            
					WHEN 1 THEN 'Domingo'
					WHEN 2 THEN 'Segunda' 
					WHEN 3 THEN 'Ter�a' 
					WHEN 4 THEN 'Quarta' 
					WHEN 5 THEN 'Quinta' 
					WHEN 6 THEN 'Sexta' 
					WHEN 7 THEN 'S�bado' 
             
				END AS DIA_SEMANA,

				 DATEPART(MONTH,@DATA) AS MES, 

				 CASE DATENAME(MONTH,@DATA) 
			
					WHEN 'Janeiro' THEN 'Janeiro'
					WHEN 'Fevereiro' THEN 'Fevereiro'
					WHEN 'Mar�o' THEN 'Mar�o'
					WHEN 'Abril' THEN 'Abril'
					WHEN 'Maio' THEN 'Maio'
					WHEN 'Junho' THEN 'Junho'
					WHEN 'Julho' THEN 'Julho'
					WHEN 'Agosto' THEN 'Agosto'
					WHEN 'Setembro' THEN 'Setembro'
					WHEN 'Outubro' THEN 'Outubro'
					WHEN 'Novembro' THEN 'Novembro'
					WHEN 'Dezembro' THEN 'Dezembro'
		
				END AS NOME_MES,
		 
				 DATEPART(qq,@DATA) QUARTO, 

				 CASE DATEPART(qq,@DATA) 
					WHEN 1 THEN 'Primeiro' 
					WHEN 2 THEN 'Segundo' 
					WHEN 3 THEN 'Terceiro' 
					WHEN 4 THEN 'Quarto' 
				END AS NOMEQUARTO 
				, DATEPART(YEAR,@DATA) ANO
	
			SELECT @DATA = DATEADD(dd,1,@DATA)
		END

		UPDATE DIM_TEMPO 
		SET DIA = '0' + DIA 
		WHERE LEN(DIA) = 1 

		UPDATE DIM_TEMPO 
		SET MES = '0' + MES 
		WHERE LEN(MES) = 1 

		UPDATE DIM_TEMPO 
		SET DATA_COMPLETA = ANO + MES + DIA 
		GO

		select * from DIM_TEMPO

		----------------------------------------------
		----------FINS DE SEMANA E ESTA��ES-----------
		----------------------------------------------

		DECLARE C_TEMPO CURSOR FOR	
			SELECT SKTEMPO, DATA_COMPLETA, DIA_SEMANA, ANO FROM DIM_TEMPO
		DECLARE			
					@ID INT,
					@DATA varchar(10),
					@DIASEMANA VARCHAR(20),
					@ANO CHAR(4),
					@FIMSEMANA CHAR(3),
					@ESTACAO VARCHAR(15)
					
		OPEN C_TEMPO
			FETCH NEXT FROM C_TEMPO
			INTO @ID, @DATA, @DIASEMANA, @ANO
		WHILE @@FETCH_STATUS = 0
		BEGIN
			
					 IF @DIASEMANA in ('Domingo','S�bado') 
						SET @FIMSEMANA = 'Sim'
					 ELSE 
						SET @FIMSEMANA = 'N�o'

					--ATUALIZANDO ESTACOES

					IF @DATA BETWEEN CONVERT(CHAR(4),@ano)+'0923' 
					AND CONVERT(CHAR(4),@ANO)+'1220'
						SET @ESTACAO = 'Primavera'

					ELSE IF @DATA BETWEEN CONVERT(CHAR(4),@ano)+'0321' 
					AND CONVERT(CHAR(4),@ANO)+'0620'
						SET @ESTACAO = 'Outono'

					ELSE IF @DATA BETWEEN CONVERT(CHAR(4),@ano)+'0621' 
					AND CONVERT(CHAR(4),@ANO)+'0922'
						SET @ESTACAO = 'Inverno'

					ELSE -- @data between 21/12 e 20/03
						SET @ESTACAO = 'Ver�o'

					--ATUALIZANDO FINS DE SEMANA
	
					UPDATE DIM_TEMPO SET FIM_SEMANA = @FIMSEMANA
					WHERE SKTEMPO = @ID

					--ATUALIZANDO

					UPDATE DIM_TEMPO SET ESTACAO_ANO = @ESTACAO
					WHERE SKTEMPO = @ID
		
			FETCH NEXT FROM C_TEMPO
			INTO @ID, @DATA, @DIASEMANA, @ANO	
		END
		CLOSE C_TEMPO
		DEALLOCATE C_TEMPO
		GO

		SELECT * FROM DIM_TEMPO