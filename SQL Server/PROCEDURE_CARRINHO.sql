--CRIANDO TABELA
CREATE TABLE ARM_DADOS_CARRINHO
(
	ID		INT IDENTITY(1,1) ,
	USUARIO VARCHAR(50),
	ACAO	VARCHAR(30),
	DATA	VARCHAR(30),
	HORA	VARCHAR(30),
	FOTO	VARBINARY(MAX),
	SOM		VARBINARY(MAX),
	VIDEO	VARBINARY(MAX)
)

SELECT * FROM ARM_DADOS_CARINHO

--ATRIBUINDO DADOS NA PROCEDURE POR PAR�MENTROS.
EXEC [ARM_IMG_VD_FT] 'MOIS�S',
				     'ACAO1',
		             'C:\Users\Mois�s\Pictures\Fotos\Roles e amigos\1.jpg',
			         'C:\Users\Mois�s\Music\Bon Jovi\bon jovi - all about loving you.mp3',
			         'Bibliotecas\V�deos\video-2011-11-05-01-16-27.mp4'
			  
			  
--PROCEDURE QUE ADICIONA DADOS AS TABELA (ARM_DADOS_CARRINHO).
DROP PROCEDURE [ARM_IMG_VD_FT]
(
-- VARIAVEIS QUE RECEBERAM OS DADOS POR PAR�METRO.
	@USUARIO VARCHAR(50),  
	@ACAO	 VARCHAR(30),
	@FOTO	 VARCHAR(8000), --VARIAVEL QUE RECEBER� O ENDERE�O DO ARQUIVO
	@SOM	 VARCHAR(8000), --VARIAVEL QUE RECEBER� O ENDERE�O DO ARQUIVO
	@VIDEO	 VARCHAR(8000)  --VARIAVEL QUE RECEBER� O ENDERE�O DO ARQUIVO
)
	AS BEGIN
		SET NOCOUNT ON 
		
		DECLARE @SQL VARCHAR(8000) --VARIAVEL QUE IR� RECEBER O COMANDO SQL.
		    --CONCATENANDO AS INFORMA��OES DENTRO DA VARI�VEL @SQL.
			SET @SQL = ''
			SET @SQL = @SQL + 'INSERT INTO ARM_DADOS_CARRINHO (USUARIO,ACAO,DATA,HORA,FOTO,SOM,VIDEO)'
			SET @SQL = @SQL + 'SELECT  ''' +@USUARIO+ ''','''+@ACAO+''',' +CONVERT(VARCHAR, GETDATE(), 103)+ ',' +CONVERT(VARCHAR, GETDATE(), 108)
			SET @SQL = @SQL + ', BULKCOLUMN FROM OPENROWSET(BULK ''' +  @FOTO + ''', SINGLE_BLOB)'
			SET @SQL = @SQL + ', BULKCOLUMN FROM OPENROWSET(BULK ''' +  @SOM + ''', SINGLE_BLOG)'
			SET @SQL = @SQL + ', BULKCOLUMN FROM OPENROWSET(BULK ''' +  @VIDEO + ''', SINGLE_BLOG)'
			
				--SET @SQL = @SQL + ', BULKCOLUMN FROM OPENROWSET( BULK ''' + @ARQUIVO +''', SINGLE_BLOB)'
		
		--PRINT(@SQL)
	    EXEC(@SQL)
	END 
		
SP_HELPTEXT ARM_IMG_VD_FT

	