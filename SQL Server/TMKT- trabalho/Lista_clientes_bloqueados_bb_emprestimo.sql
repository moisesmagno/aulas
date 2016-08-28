DECLARE @LISTA VARCHAR(250)
SET @LISTA = '1528,1292,1295,1300,1327'
--SELECT @LISTA

EXEC STP_BLOQUEADOS_BB_EMPRESTIMOS @LISTA, '\\10.6.19.46\C$\IMPORTA\'

ALTER PROCEDURE STP_BLOQUEADOS_BB_EMPRESTIMOS

	@LISTA_CAMPANHAS VARCHAR(255),
	@CAMINHO_DESTINO VARCHAR(8000)

AS BEGIN 
	SET NOCOUNT ON 

	--DELETANDO TABELAS TEMPORÁRIAS. 
	IF OBJECT_ID('tempdb..#TB_CAMPANHA') IS NOT NULL DROP TABLE #TB_CAMPANHA
	IF OBJECT_ID('tempdb..#TB_BLOQUEADOS_BB_EMPRESTIMOS') IS NOT NULL DROP TABLE #TB_BLOQUEADOS_BB_EMPRESTIMOS
	IF OBJECT_ID('BB_EMPRESTIMOS..TB_TEMP_BLOQUEADOS') IS NOT NULL DROP TABLE TB_TEMP_BLOQUEADOS
	
	CREATE TABLE #TB_BLOQUEADOS_BB_EMPRESTIMOS
	(
			[CPF CLIENTE] VARCHAR(12),
			[CAMPANHA]    VARCHAR(30),
			[CMI]		  VARCHAR(30),
		    [AGÊNCIA]	  VARCHAR(20),
			[CONTA]		  VARCHAR(20),
			[MENSGAEM]	  VARCHAR(100),
			[DDD]		  VARCHAR(6),
			[TELEFONE]	  VARCHAR(25)
	)
	
    CREATE TABLE TB_TEMP_BLOQUEADOS
	(
			LINHA VARCHAR(8000)
    )              
  
	CREATE TABLE #TB_CAMPANHA 
	(
		CAMPANHA_CODIGO    INT IDENTITY(1,1), 
		CAMPANHAS INT
	)
	--TESTE
	--DECLARE @LISTA_CAMPANHAS VARCHAR(250)
	--SET @LISTA_CAMPANHAS = '1528,1292,1295,1300,1327'

	INSERT INTO #TB_CAMPANHA
	EXEC STP_GERA_TEMP_VARCHAR @LISTA_CAMPANHAS
	--SELECT * FROM #TB_CAMPANHA    

	DECLARE @ARQUIVO VARCHAR(8000)
	DECLARE @TEXTO VARCHAR(8000)
	DECLARE @BLOQUEADOS_BB_EMPRESTIMOS  VARCHAR(500)
	
	INSERT INTO #TB_BLOQUEADOS_BB_EMPRESTIMOS
	SELECT  
    DISTINCT DDS_CPFCNPJ AS [CPF CLIENTE], 
		     CMP_CAMPANHA AS [CAMPANHA],
		     DET_CODCONTROLE AS [CMI], 
	         CTR_AGENCIA AS [AGÊNCIA], 
		     CTR_CONTA AS [CONTA], 
	         CTR_MENSAGEM AS [MENSGAEM], 
	         FON_DDD AS [DDD], 
	         FON_FONE AS [TELEFONE]
		     FROM TB_CLIENTE 
				  INNER JOIN #TB_CAMPANHA WITH(NOLOCK) ON CAMPANHAS = CLI_CMPCODIGO 
				  INNER JOIN TB_DADOSCLI WITH(NOLOCK) ON DDS_CLICODIGO = CLI_CODIGO 
				  INNER JOIN TMKT..TB_CAMPANHA WITH(NOLOCK) ON CMP_CODIGO = CLI_CMPCODIGO 
				  INNER JOIN TB_DETALHE WITH(NOLOCK) ON DET_CLICODIGO = CLI_CODIGO 
				  INNER JOIN TB_CONTROLE_CALCULO WITH(NOLOCK) ON CTR_CLICODIGO = CLI_CODIGO
				  INNER JOIN TB_FONE WITH(NOLOCK) ON FON_CLICODIGO = CLI_CODIGO  
				  WHERE CTR_MENSAGEM IS NOT NULL OR CTR_MENSAGEM <> 'OK:Cliente finalizado com sucesso'
					
	SET @BLOQUEADOS_BB_EMPRESTIMOS = 'BLOQUEADOS_BB_EMPRESTIMOS'
			
   --INSERINDO DADOS NA TABELA TEMPORÁRIA TB_TEMP_BLOQUEADOS
   INSERT INTO TB_TEMP_BLOQUEADOS
   --CRIACAO DE HEADER + LINHA
   SELECT 'BLOQUEADOS BB EMPRESTIMOS'
   UNION ALL                                                                   
   SELECT  'CPF CLIENTE;' + 'CAMPANHA;' + 'CMI;'+ 'AGÊNCIA;' + 'CONTA;' + 'MENSGAEM;' + 'DDD;' + 'TELEFONE;'          
   UNION ALL                                                
   SELECT                                                                         
	   ISNULL([CPF CLIENTE],'') + ';' +
	   ISNULL([CAMPANHA],'') + ';' +
	   ISNULL([CMI],'') + ';' +
	   ISNULL([AGÊNCIA],'') + ';' +
	   ISNULL([CONTA],'') + ';' +
	   ISNULL([MENSGAEM],'') + ';' + 
	   ISNULL([DDD],'') + ';' + 
	   ISNULL([TELEFONE],'')
   FROM #TB_BLOQUEADOS_BB_EMPRESTIMOS WITH(NOLOCK)                                                  
    --SELECT * FROM #EXPORTA WITH(NOLOCK)           
    --DECLARE @ARQUIVO VARCHAR(8000)            
    --DECLARE @TEXTO   VARCHAR(8000)       
    /* EXPORTA ARQUIVO */                                                                                     
   SET @ARQUIVO = @CAMINHO_DESTINO + @BLOQUEADOS_BB_EMPRESTIMOS + '_' + REPLACE(CONVERT(VARCHAR, GETDATE(), 103), '/', '') + '.CSV'            
   
   SET @TEXTO = ' BCP '                                                                              
               + ' " SELECT LINHA FROM BB_EMPRESTIMOS.DBO.TB_TEMP_BLOQUEADOS " '                                     
                 + ' QUERYOUT '                                                           
                 +  @ARQUIVO                                                              
                 + ' -c -C1252 '                                                                                     
                 + ' -UADM '                                                                   
                 + ' -STMKTBDSQL11 '                                                                             
                 + ' -PADMUSR '                                                                        
                                                                          
    EXEC MASTER.DBO.XP_CMDSHELL @TEXTO                                                                 
    
END			

