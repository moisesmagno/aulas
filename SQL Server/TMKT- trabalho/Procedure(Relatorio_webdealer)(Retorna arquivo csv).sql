CREATE TABLE TB_VENDAS_WEBDEALER_GVT
 (        
  VWG_CODIGO    INT IDENTITY(1,1) PRIMARY KEY,
  VWG_CRIACAO	DATETIME,        
  VWG_RPON		VARCHAR(40),                                                                                                    
  VWG_PON		VARCHAR(70),        
  VWG_PRODUTO	VARCHAR(70),        
  VWG_STATUS	VARCHAR(70),        
  VWG_CANAL		VARCHAR(80),        
  VWG_LOGIN		VARCHAR(90),        
  VWG_CAMPANHA	VARCHAR(100),        
  VWG_INSTANCIA VARCHAR(100),        
  VWG_DOCUMENTO VARCHAR(50),        
  VWG_CONTA		VARCHAR(50),        
  VWG_CIDADE	VARCHAR(100),        
  VWG_UF		VARCHAR(2),        
  VWG_ARMARIO	VARCHAR(90)         
 ) 
DROP TABLE TB_VENDAS_WEBDEALER_GVT
SELECT * FROM TB_VENDAS_WEBDEALER_GVT

EXEC STP_WEBDEALER_RELATORIO '2012-05-03 00:00:00','2012-05-03 23:59:59','\\10.6.19.46\C$\IMPORTA'--,'\\10.6.19.46\C$\IMPORTA\webdealer_20120503.csv'

ALTER PROCEDURE STP_WEBDEALER_RELATORIO        
(        
 --DECLARANDO A VARIÁVEL QUE IRÁ RECEBER O CAMINHO DO ARQUIVO PARA IMPORTAÇÃO.            
 @DATAINICIAL     DATETIME,
 @DATAFINAL	      DATETIME,     
 @CAMINHO_DESTINO VARCHAR (8000),
 @CAMINHO_ARQUIVO VARCHAR(8000)=  NULL
 )              
AS    
 BEGIN         
     SET NOCOUNT ON     
        
	-- DELETANDO TABELAS TEMPORÁRIAS. 
	IF OBJECT_ID('tempdb..#TEMPORARIA_WEBDEALER') IS NOT NULL DROP TABLE #TEMPORARIA_WEBDEALER
	IF OBJECT_ID('tempdb..#EXPORTA') IS NOT NULL DROP TABLE #EXPORTA    
	IF OBJECT_ID('TB_TEMP_EXP_WEBDEALER') IS NOT NULL DROP TABLE TB_TEMP_EXP_WEBDEALER    

	--DECLARANDO VARIAVEIS PARA TESTAR A PROCEDURE.    
	--DECLARE @CAMINHO_ARQUIVO VARCHAR(8000) = NULL
	--DECLARE @CAMINHO_DESTINO VARCHAR(8000) 
	--DECLARE @DATAINICIAL DATETIME
	--DECLARE @DATAFINAL DATETIME    
	--SET @CAMINHO_ARQUIVO = '\\10.6.19.46\C$\IMPORTA\webdealer_20120503.csv'    
	--SET @CAMINHO_DESTINO = '\\10.6.19.46\C$\IMPORTA'  
	--SET @DATAINICIAL = '2012-05-03 00:00:00'      
	--SET @DATAFINAL   = '2012-05-03 23:59:59'  
	 
	CREATE TABLE #TEMPORARIA_WEBDEALER       
	 (      
	  CRIACAO	DATETIME,      
	  RPON		VARCHAR(20),                                                                                                  
	  PON		VARCHAR(50),      
	  PRODUTO	VARCHAR(50),      
	  STATUS	VARCHAR(50),      
	  CANAL		VARCHAR(70),      
	  LOGIN		VARCHAR(70),      
	  CAMPANHA	VARCHAR(80),      
	  INSTANCIA VARCHAR(80),      
	  DOCUMENTO VARCHAR(30),      
	  CONTA		VARCHAR(30),      
	  CIDADE	VARCHAR(80),      
	  UF		VARCHAR(2),      
	  ARMARIO   VARCHAR(70)       
	 )  
	
	CREATE TABLE #EXPORTA    
	 (    
	  [CPF CLIENTE]  VARCHAR(20),    
	  [NOME CLIENTE]  VARCHAR(60),    
	  [ENDEREÇO CLIENTE] VARCHAR(80),    
	  INSTANCIA   VARCHAR(80),    
	  [EASYCODE CLIENTE] VARCHAR(30),    
	  [PRODUTO VENDIDO] VARCHAR(80),    
	  [DATA DA VENDA]  VARCHAR(20),    
	  OPERADOR   VARCHAR(30),    
	  [RAMAL OPERADOR] VARCHAR(12),    
	  [REGISTRO VENDA] VARCHAR(20)    
	 )      
	         
	 CREATE TABLE TB_TEMP_EXP_WEBDEALER      
	 (      
	  LINHA VARCHAR(8000)      
	 )        
	 
	 
	  DECLARE @QTDE_CPF_TMKT INT                
	  DECLARE @QTDE_CPF_WEBDEALER INT
	  DECLARE @ARQUIVO VARCHAR(8000)      
	  DECLARE @TEXTO   VARCHAR(8000)                                                                   
	    
	         
	 --DECLARE @CAMINHO_ARQUIVO  VARCHAR(8000)        
	 --SET @CAMINHO_ARQUIVO = '\\10.6.19.46\C$\IMPORTA\webdealer_20120503.csv'        
	         
	 --DECLARANDO O BULK INSERT, POIS DO JEITO TRADICIONAL ELE NÃO ACEITA VARIÁVEIS COMO PARAMETRO, ENTÃO TEM QUE SER FEITA A IMPORTAÇÃO DE FORMA DINÂMCA        
	 IF @CAMINHO_ARQUIVO IS NOT NULL  
	 BEGIN  
	     --DECLARANDO O BULK INSERT, POIS DO JEITO TRADICIONAL ELE NÃO ACEITA VARIÁVEIS COMO PARAMETRO, ENTÃO TEM QUE SER FEITA A IMPORTAÇÃO DE FORMA DINÂMCA        
		 DECLARE @SSQL VARCHAR(8000)        
		         
		 --REALIZANDO A IMPORTTAÇÃO DO ARQUIVO DINAMICAMENTE.         
		 SET @SSQL = N''                                                  
		 SET @SSQL = @SSQL + ' BULK INSERT #TEMPORARIA_WEBDEALER'                                                  
		 SET @SSQL = @SSQL + ' FROM '''+LTRIM(RTRIM(ISNULL(@CAMINHO_ARQUIVO,'')))+''''                                                   
		 SET @SSQL = @SSQL + ' WITH (ROWTERMINATOR =''\n'',FIRSTROW=2,FIELDTERMINATOR='';'')'                                             
		 BEGIN TRY                          
			EXEC(@SSQL)                     
		 END TRY                           
		 BEGIN CATCH                   
			
			PRINT @SSQL              
			SELECT 'Não foi possível importar o arquivo indicado. Por favor, verifique o arquivo.'                          
			RETURN                          
		END CATCH
		INSERT INTO TB_VENDAS_WEBDEALER_GVT (VWG_CRIACAO,VWG_RPON,VWG_PON,VWG_PRODUTO,VWG_STATUS,VWG_CANAL,VWG_LOGIN,VWG_CAMPANHA,VWG_INSTANCIA,VWG_DOCUMENTO,VWG_CONTA,VWG_CIDADE,VWG_UF,VWG_ARMARIO) 
		SELECT *FROM #TEMPORARIA_WEBDEALER
		--SELECT * FROM TB_VENDAS_WEBDEALER_GVT 	         
       
	 --EXEC(@BULK)        
	 --DELCARADO AS VARIÁVEIS QUE RECEBERAM AS DATA INCIAL E FINAL, PARA PODER REALIZAR A BUSCA DAS VENDAS FEITAS EM UM DETERMINÁDO PERÍODO.        
	 --DECLARE @DATAINICIAL DATETIME        
	 --DECLARE @DATAFINAL  DATETIME        
	         
	 --INSERINDO DATA INICIAL DA TABLE TEMPORARIA NA VARIÁVEL         
	 --SELECT @DATAINICIAL = MIN(CRIACAO) FROM #TEMPORARIA_WEBDEALER         
	 --SELECT @DATAINICIAL        
	         
	 --INSERINDO DATA FINAL DA TABLE TEMPORARIA NA VARIÁVEL         
	 --SELECT @DATAFINAL = MAX(CRIACAO) FROM #TEMPORARIA_WEBDEALER        
	 --SELECT @DATAFINAL  
	      
	         
	 --DECLARE @QTDE_CPF_TMKT INT        
	 --SELECIONANDO A QUANTIDADE DE CPFS NAS BASES DA TMKT.      
	 SELECT @QTDE_CPF_TMKT = COUNT(DISTINCT DDS_CPFCNPJ) FROM TB_ASSOCIADOS INNER JOIN TB_DADOSCLI WITH(NOLOCK) ON ASS_CLICODIGO = DDS_CLICODIGO        
	 WHERE ASS_DATAAUDITORIA BETWEEN @DATAINICIAL AND @DATAFINAL         
	 --SELECT @QTDE_CPF_TMKT   
	 
	  
	  --DECLARE @QTDE_CPF_WEBDEALER INT        
	 --SELECIONANDO A QUANTIDADE DE CPFS NAS BASES DO WEBDEALER.     
	 SELECT @QTDE_CPF_WEBDEALER = COUNT(DISTINCT VWG_DOCUMENTO) FROM TB_VENDAS_WEBDEALER_GVT         
	 WHERE VWG_CRIACAO  BETWEEN @DATAINICIAL AND @DATAFINAL         
	 --SELECT @QTDE_CPF_WEBDEALER        
	          
	 --DECLARANDO O NOME DO ARQUIVO COM QUE SERÁ GERADO O RELATÓRIO.
	 DECLARE @NOME_ARQUIVO  VARCHAR(8000)            
	          
	  IF @QTDE_CPF_TMKT > @QTDE_CPF_WEBDEALER        
	  BEGIN       
	        
	   INSERT INTO #EXPORTA     
	   SELECT        
	   DISTINCT ISNULL (DDS_CPFCNPJ,   ' ') AS [CPF CLIENTE],        
				ISNULL (DDS_NOME,    ' ') AS [NOME CLIENTE],         
				ISNULL (END_ENDERECO,   ' ') AS [ENDEREÇO CLIENTE],        
				ISNULL (DET_INSTANCIA,  ' ') AS INSTANCIA,         
				ISNULL (CLI_EASYCODE,   ' ') AS [EASYCODE CLIENTE],        
				ISNULL (PRD_DESCRICAO,  ' ') AS [PRODUTO VENDIDO],         
				ISNULL (ASS_DATAAUDITORIA, ' ') AS [DATA DA VENDA],         
				ISNULL (NRREG,          ' ') AS OPERADOR,        
				ISNULL (ASS_RAMALAGENTE,  ' ') AS [RAMAL OPERADOR],        
				ISNULL (ASS_CODIGO,   ' ') AS [REGISTRO VENDA]     
	                
	   FROM TB_DADOSCLI        
	   INNER JOIN TB_ASSOCIADOS WITH(NOLOCK) ON ASS_CLICODIGO = DDS_CLICODIGO         
	   INNER JOIN TB_EVENTO_DETALHE WITH(NOLOCK) ON ASS_CODIGO = EVD_ASSCODIGO            
	   INNER JOIN TB_ENDERECO WITH(NOLOCK) ON END_CLICODIGO = DDS_CLICODIGO        
	   INNER JOIN TB_CLIENTE  WITH(NOLOCK) ON CLI_CODIGO = DDS_CLICODIGO        
	   INNER JOIN TB_DETALHE  WITH(NOLOCK) ON DET_CLICODIGO = DDS_CLICODIGO        
	   INNER JOIN TB_CONTATO  WITH(NOLOCK) ON CTO_CODIGO = ASS_CTOCODIGO        
	   INNER JOIN TB_EVENTO WITH(NOLOCK) ON EVD_EVTCODIGO = EVT_CODIGO        
	   INNER JOIN TB_PRODUTO WITH(NOLOCK) ON PRD_CODIGO = EVT_PRDCODIGO          
	   INNER JOIN TMKT..OPERADORES WITH(NOLOCK) ON NRREG = ASS_AGTCODIGO        
	   LEFT JOIN TB_VENDAS_WEBDEALER_GVT WITH(NOLOCK) ON LTRIM(RTRIM(VWG_DOCUMENTO)) = LTRIM(RTRIM(DDS_CPFCNPJ)) AND VWG_PRODUTO = PRD_RETORNO       
	   WHERE ASS_STACODIGO IN (2,3) AND ASS_DATAAUDITORIA BETWEEN @DATAINICIAL AND @DATAFINAL AND VWG_DOCUMENTO IS NULL          
	   --SELECT * FROM #VENDAS_TMKT      
	     
	 SET @NOME_ARQUIVO = 'RegistrosTMKT'  
	      
	 END        
	 ELSE        
	 BEGIN         
	       
	   INSERT INTO #EXPORTA        
	   SELECT        
	   DISTINCT ISNULL (DDS_CPFCNPJ,  ' ') AS [CPF CLIENTE],        
				ISNULL (DDS_NOME,   ' ') AS [NOME CLIENTE],         
				ISNULL (END_ENDERECO,  ' ') AS [ENDEREÇO CLIENTE],        
				ISNULL (DET_INSTANCIA,  ' ') AS INSTANCIA,         
				ISNULL (CLI_EASYCODE,  ' ') AS [EASYCODE CLIENTE],        
				ISNULL (PRD_DESCRICAO,  ' ') AS [PRODUTO VENDIDO],         
				ISNULL (ASS_DATAAUDITORIA, ' ') AS [DATA DA VENDA],         
				ISNULL (NRREG,       ' ') AS OPERADOR,        
				ISNULL (ASS_RAMALAGENTE, ' ') AS [RAMAL OPERADOR],        
				ISNULL (ASS_CODIGO,  ' ') AS [REGISTRO VENDA]    
	             
	  FROM TB_VENDAS_WEBDEALER_GVT        
		LEFT JOIN TB_DADOSCLI WITH(NOLOCK) ON LTRIM(RTRIM(DDS_CPFCNPJ)) = LTRIM(RTRIM(VWG_DOCUMENTO))        
		INNER JOIN TB_ASSOCIADOS WITH(NOLOCK) ON ASS_CLICODIGO = DDS_CLICODIGO        
		INNER JOIN TB_EVENTO_DETALHE WITH(NOLOCK) ON ASS_CODIGO = EVD_ASSCODIGO        
		INNER JOIN TB_ENDERECO WITH(NOLOCK) ON END_CLICODIGO = DDS_CLICODIGO        
		INNER JOIN TB_CLIENTE  WITH(NOLOCK) ON CLI_CODIGO = DDS_CLICODIGO         
		INNER JOIN TB_DETALHE  WITH(NOLOCK) ON DET_CLICODIGO = DDS_CLICODIGO        
		INNER JOIN TB_CONTATO WITH(NOLOCK) ON CTO_CODIGO = ASS_CTOCODIGO        
		INNER JOIN TB_EVENTO WITH(NOLOCK) ON EVD_EVTCODIGO = EVT_CODIGO        
		LEFT JOIN TB_PRODUTO WITH(NOLOCK) ON PRD_CODIGO = EVT_PRDCODIGO  AND PRD_RETORNO = VWG_PRODUTO 
		INNER JOIN TMKT..OPERADORES WITH(NOLOCK) ON NRREG = ASS_AGTCODIGO        
		WHERE ASS_STACODIGO IN (2,3) AND ASS_DATAAUDITORIA BETWEEN @DATAINICIAL AND @DATAFINAL AND DDS_CPFCNPJ IS NULL         
		--SELECT *FROM #VENDAS_WEBDEALER  
	   
		SET @NOME_ARQUIVO = 'RegistrosWebdealer'  
	   
	 END      
	       
	   --POPULANDO TABELA FISICA TEMPORARIA                                                               
	  INSERT INTO TB_TEMP_EXP_WEBDEALER      
	           
		--CRIACAO DE HEADER + LINHA                                                                  
	  SELECT  'CPF CLIENTE;' + 'NOME CLIENTE;'+ 'ENDEREÇO CLIENTE;' + 'INSTÂNCIA;' + 'EASYCODE CLIENTE;' + 'PRODUTO VENDIDO;' + 'DATA DA VENDA;'+ 'OPERADOR;' +  'RAMAL OPERADOR;' + 'REGISTRO VENDA;'      
	  UNION ALL                                          
	  SELECT                                                                   
			ISNULL([CPF CLIENTE],'')  + ';' +                               
			ISNULL([NOME CLIENTE],'') + ';' +                                            
			ISNULL([ENDEREÇO CLIENTE] ,'') + ';' +                                            
			ISNULL([INSTANCIA],'')  + ';' +                                            
			ISNULL([EASYCODE CLIENTE],'')  + ';' +                                            
			ISNULL([PRODUTO VENDIDO],'')  + ';' +                                            
			ISNULL([DATA DA VENDA],'')  + ';' +                                            
			ISNULL([OPERADOR],'')  + ';' +                                            
			ISNULL([RAMAL OPERADOR] ,'') + ';' +                                            
			ISNULL([REGISTRO VENDA] ,'')                                            
	  FROM #EXPORTA  WITH(NOLOCK)                                            
		-- SELECT * FROM #EXPORTA WITH(NOLOCK)     
	  --DECLARE @ARQUIVO VARCHAR(8000)      
	  --DECLARE @TEXTO   VARCHAR(8000)                                                                   
	  /* EXPORTA ARQUIVO */                                                                               
	  SET @ARQUIVO = @CAMINHO_DESTINO + @NOME_ARQUIVO + REPLACE(CONVERT(VARCHAR, GETDATE(), 103), '/', '') + '.CSV'      
	                 
	  SET @TEXTO = ' BCP '          
		   + ' " SELECT LINHA FROM TMKTBDSQL03.GVT_WEB.DBO.TB_TEMP_EXP_WEBDEALER" '                                           
		  + ' QUERYOUT '                                                                 
		  +  @ARQUIVO                                                                    
		  + ' -c -C1252 '                                                                                           
		  + ' -UADM '                                                                         
		  + ' -STMKTBDSQL14 '                                                                                   
		  + ' -PADMUSR '                                                                              
		 --PRINT(@TEXTO)                                                                            
	  EXEC MASTER.DBO.XP_CMDSHELL @TEXTO  
   
	END
    ELSE 
    BEGIN
    
	       
	 --SELECIONANDO A QUANTIDADE DE CPFS NAS BASES DA TMKT.      
	 SELECT @QTDE_CPF_TMKT = COUNT(DISTINCT DDS_CPFCNPJ) FROM TB_ASSOCIADOS INNER JOIN TB_DADOSCLI WITH(NOLOCK) ON ASS_CLICODIGO = DDS_CLICODIGO        
	 WHERE ASS_DATAAUDITORIA BETWEEN @DATAINICIAL AND @DATAFINAL         
	 --SELECT @QTDE_CPF_TMKT   
	 
	                 
	        
	 --SELECIONANDO A QUANTIDADE DE CPFS NAS BASES DO WEBDEALER.     
	 SELECT @QTDE_CPF_WEBDEALER = COUNT(DISTINCT VWG_DOCUMENTO) FROM TB_VENDAS_WEBDEALER_GVT         
	 WHERE VWG_CRIACAO  BETWEEN @DATAINICIAL AND @DATAFINAL         
	 --SELECT @QTDE_CPF_WEBDEALER        
	          
	 --DECLARANDO O NOME DO ARQUIVO COM QUE SERÁ GERADO O RELATÓRIO.
	             
	          
	  IF @QTDE_CPF_TMKT > @QTDE_CPF_WEBDEALER        
	  BEGIN       
	        
	   INSERT INTO #EXPORTA     
	   SELECT        
	   DISTINCT ISNULL (DDS_CPFCNPJ,   ' ') AS [CPF CLIENTE],        
				ISNULL (DDS_NOME,    ' ') AS [NOME CLIENTE],         
				ISNULL (END_ENDERECO,   ' ') AS [ENDEREÇO CLIENTE],        
				ISNULL (DET_INSTANCIA,  ' ') AS INSTANCIA,         
				ISNULL (CLI_EASYCODE,   ' ') AS [EASYCODE CLIENTE],        
				ISNULL (PRD_DESCRICAO,  ' ') AS [PRODUTO VENDIDO],         
				ISNULL (ASS_DATAAUDITORIA, ' ') AS [DATA DA VENDA],         
				ISNULL (NRREG,          ' ') AS OPERADOR,        
				ISNULL (ASS_RAMALAGENTE,  ' ') AS [RAMAL OPERADOR],        
				ISNULL (ASS_CODIGO,   ' ') AS [REGISTRO VENDA]     
	                
	   FROM TB_DADOSCLI        
	   INNER JOIN TB_ASSOCIADOS WITH(NOLOCK) ON ASS_CLICODIGO = DDS_CLICODIGO         
	   INNER JOIN TB_EVENTO_DETALHE WITH(NOLOCK) ON ASS_CODIGO = EVD_ASSCODIGO            
	   INNER JOIN TB_ENDERECO WITH(NOLOCK) ON END_CLICODIGO = DDS_CLICODIGO        
	   INNER JOIN TB_CLIENTE  WITH(NOLOCK) ON CLI_CODIGO = DDS_CLICODIGO        
	   INNER JOIN TB_DETALHE  WITH(NOLOCK) ON DET_CLICODIGO = DDS_CLICODIGO        
	   INNER JOIN TB_CONTATO  WITH(NOLOCK) ON CTO_CODIGO = ASS_CTOCODIGO        
	   INNER JOIN TB_EVENTO WITH(NOLOCK) ON EVD_EVTCODIGO = EVT_CODIGO        
	   INNER JOIN TB_PRODUTO WITH(NOLOCK) ON PRD_CODIGO = EVT_PRDCODIGO          
	   INNER JOIN TMKT..OPERADORES WITH(NOLOCK) ON NRREG = ASS_AGTCODIGO        
	   LEFT JOIN TB_VENDAS_WEBDEALER_GVT WITH(NOLOCK) ON LTRIM(RTRIM(VWG_DOCUMENTO)) = LTRIM(RTRIM(DDS_CPFCNPJ)) AND VWG_PRODUTO = PRD_RETORNO       
	   WHERE ASS_STACODIGO IN (2,3) AND ASS_DATAAUDITORIA BETWEEN @DATAINICIAL AND @DATAFINAL AND VWG_DOCUMENTO IS NULL          
	   --SELECT * FROM #VENDAS_TMKT      
	     
	 SET @NOME_ARQUIVO = 'RegistrosTMKT'  
	      
	 END        
	 ELSE        
	 BEGIN         
	       
	  INSERT INTO #EXPORTA        
	  SELECT        
	   DISTINCT ISNULL (DDS_CPFCNPJ,  ' ') AS [CPF CLIENTE],        
				ISNULL (DDS_NOME,   ' ') AS [NOME CLIENTE],         
				ISNULL (END_ENDERECO,  ' ') AS [ENDEREÇO CLIENTE],        
				ISNULL (DET_INSTANCIA,  ' ') AS INSTANCIA,         
				ISNULL (CLI_EASYCODE,  ' ') AS [EASYCODE CLIENTE],        
				ISNULL (PRD_DESCRICAO,  ' ') AS [PRODUTO VENDIDO],         
				ISNULL (ASS_DATAAUDITORIA, ' ') AS [DATA DA VENDA],         
				ISNULL (NRREG,       ' ') AS OPERADOR,        
				ISNULL (ASS_RAMALAGENTE, ' ') AS [RAMAL OPERADOR],        
				ISNULL (ASS_CODIGO,  ' ') AS [REGISTRO VENDA]    
	             
	  FROM TB_VENDAS_WEBDEALER_GVT        
		LEFT JOIN TB_DADOSCLI WITH(NOLOCK) ON LTRIM(RTRIM(DDS_CPFCNPJ)) = LTRIM(RTRIM(VWG_DOCUMENTO))        
		INNER JOIN TB_ASSOCIADOS WITH(NOLOCK) ON ASS_CLICODIGO = DDS_CLICODIGO        
		INNER JOIN TB_EVENTO_DETALHE WITH(NOLOCK) ON ASS_CODIGO = EVD_ASSCODIGO        
		INNER JOIN TB_ENDERECO WITH(NOLOCK) ON END_CLICODIGO = DDS_CLICODIGO        
		INNER JOIN TB_CLIENTE  WITH(NOLOCK) ON CLI_CODIGO = DDS_CLICODIGO         
		INNER JOIN TB_DETALHE  WITH(NOLOCK) ON DET_CLICODIGO = DDS_CLICODIGO        
		INNER JOIN TB_CONTATO WITH(NOLOCK) ON CTO_CODIGO = ASS_CTOCODIGO        
		INNER JOIN TB_EVENTO WITH(NOLOCK) ON EVD_EVTCODIGO = EVT_CODIGO        
		LEFT JOIN TB_PRODUTO WITH(NOLOCK) ON PRD_CODIGO = EVT_PRDCODIGO  AND PRD_RETORNO = VWG_PRODUTO 
		INNER JOIN TMKT..OPERADORES WITH(NOLOCK) ON NRREG = ASS_AGTCODIGO        
		WHERE ASS_STACODIGO IN (2,3) AND ASS_DATAAUDITORIA BETWEEN @DATAINICIAL AND @DATAFINAL AND DDS_CPFCNPJ IS NULL         
		--SELECT *FROM #VENDAS_WEBDEALER  
	   
		SET @NOME_ARQUIVO = 'RegistrosWebdealer'  
	   
	 END      
	       
	   --POPULANDO TABELA FISICA TEMPORARIA                                                               
	  INSERT INTO TB_TEMP_EXP_WEBDEALER      
	           
		--CRIACAO DE HEADER + LINHA                                                                  
	  SELECT  'CPF CLIENTE;' + 'NOME CLIENTE;'+ 'ENDEREÇO CLIENTE;' + 'INSTÂNCIA;' + 'EASYCODE CLIENTE;' + 'PRODUTO VENDIDO;' + 'DATA DA VENDA;'+ 'OPERADOR;' +  'RAMAL OPERADOR;' + 'REGISTRO VENDA;'      
	  UNION ALL                                          
	  SELECT                                                                   
			ISNULL([CPF CLIENTE],'')  + ';' +                               
			ISNULL([NOME CLIENTE],'') + ';' +                                            
			ISNULL([ENDEREÇO CLIENTE] ,'') + ';' +                                            
			ISNULL([INSTANCIA],'')  + ';' +                                            
			ISNULL([EASYCODE CLIENTE],'')  + ';' +                                            
			ISNULL([PRODUTO VENDIDO],'')  + ';' +                                            
			ISNULL([DATA DA VENDA],'')  + ';' +                                            
			ISNULL([OPERADOR],'')  + ';' +                                            
			ISNULL([RAMAL OPERADOR] ,'') + ';' +                                            
			ISNULL([REGISTRO VENDA] ,'')                                            
	  FROM #EXPORTA  WITH(NOLOCK)                                            
		-- SELECT * FROM #EXPORTA WITH(NOLOCK)     
	  --DECLARE @ARQUIVO VARCHAR(8000)      
	  --DECLARE @TEXTO   VARCHAR(8000)                                                                   
	  /* EXPORTA ARQUIVO */                                                                               
	  SET @ARQUIVO = @CAMINHO_DESTINO + @NOME_ARQUIVO + REPLACE(CONVERT(VARCHAR, GETDATE(), 103), '/', '') + '.CSV'      
	                 
	  SET @TEXTO = ' BCP '          
		   + ' " SELECT LINHA FROM TMKTBDSQL03.GVT_WEB.DBO.TB_TEMP_EXP_WEBDEALER" '                                           
		  + ' QUERYOUT '                                                                 
		  +  @ARQUIVO                                                                    
		  + ' -c -C1252 '                                                                                           
		  + ' -UADM '                                                                         
		  + ' -STMKTBDSQL14 '                                                                                   
		  + ' -PADMUSR '                                                                              
		 --PRINT(@TEXTO)                                                                            
	  EXEC MASTER.DBO.XP_CMDSHELL @TEXTO  
   
   END           
 END
 
 
 
 
 
 