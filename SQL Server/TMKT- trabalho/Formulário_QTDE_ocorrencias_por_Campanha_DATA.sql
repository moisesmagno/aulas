SP_HELPTEXT STP_RELATORIO_DE_OCORRENCIAS

EXEC [STP_RELATORIO_DE_OCORRENCIAS] '2012-08-09 00:00:00','2012-08-14 23:59:59','1501,1502,1485,1435,1448,1509,1513',2,'CAMPANHA, CLICODIGO, EASYCODE, CPF,NOME,DATA_CONTATO,HORA_CONTATO','\\10.6.19.46\c$\IMPORTA'

ALTER PROCEDURE [STP_RELATORIO_DE_OCORRENCIAS] 
(                        
/* @AUTOR: HAMILTON FRANCO                            
   @ATUALIZAÇÃO: LEANDRO OLIVEIRA                            
   @DATA: 05/06/2012
   @SEGUANDA ATUALIZAÃO: MOISÉS SALVADOR ESCURRA AGUILAR
   @DATA: 15/08/2012                            
   @OBJETIVO: LISTAR AS OCORRENCIAS DO OPERADOR, DISCADOR E MOSTRAR LISTAR AS INFORMAÇÕES ANALITICAMENTE. 
   @EQUIPE: DESENV. SISTEMAS CALL CENTER                            
*/                            
@DATAINI DATETIME,                 --DATA INICIAL DA CONSULTA.              
@DATAFIM DATETIME,                 --DATA FINAL DA CONSULTA.              
@CMPCODIGO VARCHAR(1000),          --CAMPANHAS SELECIONDAS PELO USUÁRIO.               
@TIPO INT,                         --TIPO DE RELATÓRIO(ANALITICO, DISCADOR OU OPERADOR).                    
@SELECIONA_CAMPOS VARCHAR(8000),    --CAMPOS SELECIONADOS PELOS USUÁRIO E QUE QUER QUE EXIBA NO RELATÓRIO. 
@ARQUIVO VARCHAR(8000) = NULL     --CAMINHO DE ONDE SERÁ SALVO O RELATÓRIO.                  
)  
AS BEGIN                              
    SET NOCOUNT ON                         
  
   /*
   --PARA TESTES
   -----------------------------------------------------------                                    
    DECLARE @DATAINI DATETIME
    DECLARE @DATAFIM DATETIME
    DECLARE @CMPCODIGO VARCHAR(1000)
    DECLARE @ARQUIVO VARCHAR(8000)
	DECLARE @TIPO INT
	DECLARE @SELECIONA_CAMPOS VARCHAR(8000)
	
	SET @TIPO = 1
    SET @DATAINI = '2012-08-09 00:00:00'
    SET @DATAFIM = '2012-08-14 23:59:59'
    SET @CMPCODIGO = '1501,1502,1485,1435,1448,1509,1513'
    SET @ARQUIVO = '\\10.6.19.46\c$\IMPORTA'
    SET @SELECIONA_CAMPOS = 'CAMPANHA, CLICODIGO, EASYCODE, CPF,NOME,DATA_CONTATO,HORA_CONTATO'
    ----------------------------------------------------------- 
    */
                                 
    DECLARE @TEXTO VARCHAR(8000)                        
    DECLARE @NOME_ARQUIVO VARCHAR(8000)                    
    DECLARE @HEADER VARCHAR(8000)                    
    DECLARE @CAMPOS VARCHAR(8000)                     
    DECLARE @QUERY VARCHAR(8000)                    
    DECLARE @SSQL VARCHAR(8000)                    
    DECLARE @DBNEGOCIO VARCHAR(8000)                    
    
    --EXCLUI AS TABELAS TEMPORÁRIAS E FÍSICAS QUE SÃO CRIADAS PARA CRIAR O RELATÓRIO.
    IF OBJECT_ID('TEMPDB..#TB_CAMPANHA') IS NOT NULL DROP TABLE #TB_CAMPANHA                        
    IF OBJECT_ID('TEMPDB..#RELS') IS NOT NULL DROP TABLE #RELS                     
    IF OBJECT_ID('TEMPDB..#TB_CODIGO_CAMPOS') IS NOT NULL DROP TABLE #TB_CODIGO_CAMPOS                     
    IF OBJECT_ID('TB_FILTRO') IS NOT NULL DROP TABLE TB_FILTRO
    IF OBJECT_ID('RELATORIO') IS NOT NULL DROP TABLE RELATORIO
    IF OBJECT_ID('TEMPDB..#COLUNAS') IS NOT NULL DROP TABLE #COLUNAS
    IF OBJECT_ID('TEMPDB..#OCORRENCIAS') IS NOT NULL DROP TABLE #OCORRENCIAS
    IF OBJECT_ID('TEMPDB..#OCORRENCIAS_OP') IS NOT NULL DROP TABLE #OCORRENCIAS_OP
    IF OBJECT_ID('TEMPDB..#COLUNAS_OP') IS NOT NULL DROP TABLE #COLUNAS_OP
    IF OBJECT_ID('TB_TEMP_EXP_ANALITICO') IS NOT NULL DROP TABLE TB_TEMP_EXP_ANALITICO	
    IF OBJECT_ID('LINHAS_ARQUIVO') IS NOT NULL DROP TABLE LINHAS_ARQUIVO				
 
    --CRIANDO TABELA ONDE IRAM SER ADICIONADOS O CÓDIGO E DESCRIÇÃO DOS CAMPOS A SER LISTADOS NO RELATÓRIO. 	        
    CREATE TABLE #TB_CODIGO_CAMPOS
    (
		CODIGO INT, 
		DESCRICAO VARCHAR(8000)
	)                    
    
    --IMPORTANTE
    
    --INSERIDO OS CAMPOS NA TABELA #TB_CODIGO_CAMPOS ATRAVES DA PROCEDURE STP_GERA_TEMP_VARCHAR            .
    INSERT INTO #TB_CODIGO_CAMPOS (DESCRICAO)              
    EXEC STP_GERA_TEMP_VARCHAR @SELECIONA_CAMPOS                    
    
    --IMPORTANTE
    
    --CRIANDO A TABELA ONDE IRAM AS CAMPANHAS SELECIONADAS.        
        CREATE TABLE #TB_CAMPANHA 
    (
		CODIGO    INT IDENTITY(1,1), 
		CMPCODIGO INT
	)   
	
	CREATE TABLE LINHAS_ARQUIVO
	(
		SEQ_LINHAS     INT IDENTITY(1,1),
		LINHA_ARQUIVO  VARCHAR(MAX)
	)
	
	--INSERINDO NA TABELA #TB_CAMPANHA CAMPANHAS SELECIONADAS ATRAVÉS DA PROCEDURE STP_GERA_TEMP_VARCHAR.
	INSERT INTO #TB_CAMPANHA                               
    EXEC STP_GERA_TEMP_VARCHAR @CMPCODIGO                 
    
    --TABELA DO RELATÓRIO QUE IRÁ SER EXIBIDO PARA O USUÁRIO, CASO QUEIRA EXIBIR AS TABULAÇÕES DO DISCADOR OU OPERADOR. 
	CREATE TABLE RELATORIO
	(
		SEQ           INT IDENTITY(1,1),
		OCORRENCIA    VARCHAR(100),
		TOTAL	      VARCHAR(8000)  
		
	) 
	
    --ADICIONANDO NA VARIÁVEL @DBNEGOCIO A BASE DE NEGÓCIO(EX:TIM_BANDALARGA)
    SELECT TOP 1 @DBNEGOCIO = ACO_DBNEGOCIO   
      FROM TMKT.DBO.TB_CAMPANHA WITH(NOLOCK)    
		   INNER JOIN TMKT.DBO.TB_ACAO WITH(NOLOCK)ON ACO_CODIGO = CMP_ACOCODIGO     
		   INNER JOIN #TB_CAMPANHA ON CMPCODIGO = CMP_CODIGO      
    
    --CRIANDO A TABELA #RELS ONDE IRAM SER ARAMAZENADAS INFORMAÕES ANALÍTICAS
    CREATE TABLE #RELS 
    ( 
		CAMPANHA       VARCHAR(100),  
        CLICODIGO      VARCHAR(100),  
        EASYCODE       VARCHAR(100),  
        CPF			   VARCHAR(50),  
        NOME		   VARCHAR(8000),  
        DATA_CONTATO   VARCHAR(8000),  
        HORA_CONTATO   VARCHAR(8000),  
        NAO_SE_APLICA  VARCHAR(8000),  
        DDD			   VARCHAR(100),  
        FONE           VARCHAR(8000),  
        OCORRENCIA     VARCHAR(MAX),  
        MAT_OPERADOR   VARCHAR(8000),  
        NOME_OPERADOR  VARCHAR(8000),  
        RAMAL_OPERADOR VARCHAR(100) ,  
        PRODUTO        VARCHAR(8000),  
        STATUS_VENDA   VARCHAR(8000),  
        TPT			   VARCHAR(100),    
        TPA			   VARCHAR(100),     
        TPP            VARCHAR(100) 
   )                            
    
    --COMPARANADO SE A BASE DE NEGÓCIO É DA TIM_BOC, CASO SEJA IRÁ EXIBIR INFORMAÇÕES REFERENTES A BASE TIM_BOC, CASO NÃO SEJA MOSTRARÁ INFORMAÇÕES DE OUTRAS BASES.  
    IF @DBNEGOCIO = 'TIM_BOC'  
        BEGIN  
            IF ISNULL(OBJECT_ID('TB_TMP_EXPORTA_TIM'), 0) = 0                                                                                                                      
                BEGIN
                    --CRIANDO A TABELA PARA EXPORTAÇÃO.                                                                                                                       
                    CREATE TABLE TB_TMP_EXPORTA_TIM 
                    ( 
						CODIGO INT IDENTITY(1,1), 
						LINHA VARCHAR(MAX) 
					)                                  
                END                                          
            ELSE                                                               
                BEGIN                                
                    TRUNCATE TABLE TB_TMP_EXPORTA_TIM                                                                                    
                END  
             --SELECIONANDO CAMPOS E INSERINDO A TABELA TB_TMP_EXPORTA_TIM.
            INSERT INTO TB_TMP_EXPORTA_TIM (LINHA)  
                                SELECT 'DATA DO CONTATO' + ';' +  
                                       'DDS_NOME' + ';' +  
                                       'DDS_CPFCNPJ' + ';' +  
                                       'ENDERECO' + ';' +  
                                       'NUMERO' + ';' +  
                                       'COMPLEMENTO' + ';' +  
                                       'BAIRRO' + ';' +  
                                       'CIDADE' + ';' +  
                                       'UF' + ';' +  
                                       'CEP' + ';' +  
                                       'E-MAIL' + ';' +  
                                       'DDD' + ';' +  
                                       'TELEFONE' + ';' +  
                                       'VELOCIDADE' + ';' +  
                                       'ORIGEM' + ';' +  
                                       'NOME DO VENDEDOR' + ';' +  
                                       'STATUS' + ';' +  
                                       'NUMERO OS' + ';' +  
                                       'TEMPO EM (S)'  
              
            INSERT INTO TB_TMP_EXPORTA_TIM (LINHA)  
            SELECT CONVERT(VARCHAR, CTO_DATAHORA, 121) + ';' +  
                   ISNULL(DDS_NOME,'') + ';' +  
                   ISNULL(DDS_CPFCNPJ,'') + ';' +  
                   ISNULL(END_ENDERECO,'') + ';' +  
                   ISNULL(END_NUMERO,'') + ';' +  
                   ISNULL(END_COMPLEMENTO,'') + ';' +  
                   ISNULL(END_BAIRRO,'') + ';' +  
                   ISNULL(END_CIDADE,'') + ';' +  
                   ISNULL(END_UF,'') + ';' +  
                   ISNULL(END_CEP,'') + ';' +  
                   ISNULL(DDS_EMAILPESS,'') + ';' +  
                   CONVERT(VARCHAR,ISNULL(FON_DDD, 0)) + ';' +  
                   CONVERT(VARCHAR,ISNULL(FON_FONE, 0)) + ';' +  
                   ISNULL(PRD_DESCRICAO,'') + ';' +  
                   ISNULL(ORC_DESCRICAO,'') + ';' +  
                   ISNULL(DET_NOME_VENDEDOR,'') + ';' +  
                   ISNULL(OCR_DESCRICAO,'') + ';' +  
                   ISNULL(DET_NUMEROOS,'') + ';' +  
                   CONVERT(VARCHAR,ISNULL(CTO_TEMPO, 0))  
              FROM TIM_BOC.DBO.TB_CONTATO WITH(NOLOCK)  
                   INNER JOIN TIM_BOC.DBO.TB_OCORRENCIA WITH(NOLOCK)ON CTO_GRUPO = OCR_GRUPO 
						AND CTO_SUBGRUPO = OCR_SUBGRUPO  
						AND CTO_OCORRENCIA = OCR_OCORRENCIA  
				   INNER JOIN TIM_BOC.DBO.TB_CLIENTE WITH(NOLOCK)ON CLI_CODIGO = CTO_CLICODIGO  
				   INNER JOIN TIM_BOC.DBO.TB_DETALHE WITH(NOLOCK)ON DET_CLICODIGO = CTO_CLICODIGO  
				   INNER JOIN TIM_BOC.DBO.TB_DADOSCLI WITH(NOLOCK)ON DDS_CLICODIGO = CTO_CLICODIGO  
				   LEFT JOIN TIM_BOC.DBO.TB_ORIGEM_CHAMADA WITH(NOLOCK)ON DET_ORCCODIGO = ORC_CODIGO  
				   LEFT JOIN TIM_BOC.DBO.TB_ENDERECO WITH(NOLOCK)ON END_CODIGO = (SELECT MAX(END_CODIGO) FROM TIM_BOC.DBO.TB_ENDERECO WITH(NOLOCK) WHERE END_CLICODIGO =  CLI_CODIGO)  
				   LEFT JOIN TIM_BOC.DBO.TB_FONE WITH(NOLOCK)ON FON_CLICODIGO = CTO_CLICODIGO  
				   LEFT JOIN TIM_BOC.DBO.TB_ASSOCIADOS WITH(NOLOCK)ON ASS_CTOCODIGO = CTO_CODIGO  
				   LEFT JOIN TIM_BOC.DBO.TB_EVENTO WITH(NOLOCK)ON EVT_CTOCONTATO = CTO_CODIGO  
				   LEFT JOIN TIM_BOC.DBO.TB_PRODUTO WITH(NOLOCK)ON EVT_PRDCODIGO = PRD_CODIGO  
                   WHERE CTO_DATAHORA BETWEEN CONVERT(VARCHAR, @DATAINI,121) AND CONVERT(VARCHAR, @DATAFIM,121)  
            
            --REALIZANDO A CRIAÇÃO DO RELÁTORIO EM CSV.  
            SET @NOME_ARQUIVO = @ARQUIVO +  '\RELATORIO_DIARIO_TIM_' + REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(19),GETDATE(),121),'-',''),':',''),' ','') + '.CSV'                      
                                    
            /* EXPORTAÇÃO DO ARQUIVO*/                        
            SET @TEXTO = ' BCP ' + ' " SELECT LINHA FROM TMKT_EASY_REPORT..TB_TMP_EXPORTA_TIM " '                                                             
                                 + ' QUERYOUT '                                                                                   
                                 +  @NOME_ARQUIVO                                                                                      
                                 + ' -c -C1252 '                                                                                                             
                                 + ' -UADM '                                                                                           
                                 + ' -STMKT-ZL-DB20 '                                                                                                     
                                 + ' -PADMUSR '                                                                                                
                                                                                              
            EXEC MASTER.DBO.XP_CMDSHELL @TEXTO    
        END  
    ELSE              
        BEGIN  
        --SELECIONANDO CAMPOS ATRAVES DA QUERY DINÂMICA REFERENTES A OUTRA BASE, CAMPOS SELECIONADOS. 
            --INSERT INTO #RELS (CAMPANHA, CLICODIGO, EASYCODE, CPF, NOME, DATA_CONTATO, HORA_CONTATO, NAO_SE_APLICA, DDD, FONE,OCORRENCIA, MAT_OPERADOR, NOME_OPERADOR, RAMAL_OPERADOR,  PRODUTO, STATUS_VENDA,TPT,TPA,TPP)                              
            SET @SSQL = ''    
            SET @SSQL = @SSQL + ' SELECT '    
            SET @SSQL = @SSQL + ' CONVERT(VARCHAR, CMP_CODIGO) + '' - '' + CMP_CAMPANHA, '    
            SET @SSQL = @SSQL + ' CLI_CODIGO AS [CLICODIGO], '    
            SET @SSQL = @SSQL + ' CLI_EASYCODE AS [EASYCODE], '    
            SET @SSQL = @SSQL + ' CASE WHEN DDS_NOME = ''GUSTAVO - TESTE TMKT'' THEN '''' ELSE DDS_CPFCNPJ END AS CPF, '                              
            SET @SSQL = @SSQL + ' CASE WHEN DDS_NOME = ''GUSTAVO - TESTE TMKT'' THEN '''' ELSE DDS_NOME END AS NOME, '                              
            SET @SSQL = @SSQL + ' CONVERT(VARCHAR,CTO_DATAHORA,103) AS [DATA CONTATO], '                             
            SET @SSQL = @SSQL + ' CONVERT(VARCHAR, CTO_DATAHORA,108) AS [HORA CONTATO] , '      
            SET @SSQL = @SSQL + ' '''' AS [NAO SE APLICA], '                              
            SET @SSQL = @SSQL + '  CTO_DDD AS [DDD], '                             
            SET @SSQL = @SSQL + ' CTO_FONE AS [FONE], '    
            SET @SSQL = @SSQL + ' OCR_DESCRICAO AS [OCORRENCIA], '    
            SET @SSQL = @SSQL + ' ISNULL(CONVERT(VARCHAR,NRREG), ''DISCADOR'') AS [MAT. OPERADOR],'    
            SET @SSQL = @SSQL + ' ISNULL(NOME, '''') AS [NOME OPERADOR], '    
            SET @SSQL = @SSQL + ' ISNULL(CTO_RAMALAGENTE, '''') AS [RAMAL OPERADOR]  , '    
            SET @SSQL = @SSQL + '  PRD_DESCRICAO AS PRODUTO, '                               
            SET @SSQL = @SSQL + '  STA_DESCRICAO AS [STATUS VENDA]  , '    
            SET @SSQL = @SSQL + '  CASE WHEN  HIS_DURACAO <  HIS_TMPALO THEN HIS_TMPALO ELSE HIS_DURACAO END AS TPT, '    
            SET @SSQL = @SSQL + '  HIS_TMPALO AS TPA, '    
            SET @SSQL = @SSQL + '  (CASE WHEN HIS_DURACAO <  HIS_TMPALO THEN HIS_TMPALO ELSE HIS_DURACAO END - HIS_TMPALO)  AS TPP '    
            SET @SSQL = @SSQL + '                 FROM '+ @DBNEGOCIO + '.DBO.TB_ASSOCIADOS WITH(NOLOCK) '                              
            SET @SSQL = @SSQL + '                           INNER JOIN '+ @DBNEGOCIO + '.DBO.TB_CLIENTE WITH(NOLOCK) '    
            SET @SSQL = @SSQL + '                                             ON CLI_CODIGO = ASS_CLICODIGO '    
            SET @SSQL = @SSQL + '                           INNER JOIN TMKT.DBO.TB_CAMPANHA WITH(NOLOCK) '    
            SET @SSQL = @SSQL + '                              ON CMP_CODIGO = CLI_CMPCODIGO '                             
            SET @SSQL = @SSQL + '                           INNER JOIN #TB_CAMPANHA WITH(NOLOCk)  '                  
            SET @SSQL = @SSQL + '                              ON (CLI_CMPCODIGO = CMPCODIGO)  '                            
            SET @SSQL = @SSQL + '                           INNER JOIN '+ @DBNEGOCIO + '.DBO.TB_EVENTO_DETALHE WITH(NOLOCK)  '                             
            SET @SSQL = @SSQL + '                              ON EVD_ASSCODIGO = ASS_CODIGO  '                            
            SET @SSQL = @SSQL + '                           INNER JOIN '+ @DBNEGOCIO + '.DBO.TB_EVENTO WITH(NOLOCK) '                             
            SET @SSQL = @SSQL + '                              ON EVT_CODIGO = EVD_EVTCODIGO '                             
            SET @SSQL = @SSQL + '                           INNER JOIN '+ @DBNEGOCIO + '.DBO.TB_PRODUTO WITH(NOLOCK)  '                            
            SET @SSQL = @SSQL + '                              ON PRD_CODIGO = EVT_PRDCODIGO '                             
            SET @SSQL = @SSQL + '                           INNER JOIN '+ @DBNEGOCIO + '.DBO.TB_OCORRENCIA WITH(NOLOCK) '                             
            SET @SSQL = @SSQL + '                              ON OCR_GRUPO = CLI_GRUPO AND '                              
            SET @SSQL = @SSQL + '                             OCR_SUBGRUPO = CLI_SUBGRUPO AND '                              
            SET @SSQL = @SSQL + '                             OCR_OCORRENCIA = CLI_OCORRENCIA '                              
            SET @SSQL = @SSQL + '                            LEFT JOIN TMKT.DBO.OPERADORES WITH(NOLOCK) '                              
            SET @SSQL = @SSQL + '                              ON NRREG =  ASS_AGTCODIGO  '                            
            SET @SSQL = @SSQL + '                           INNER JOIN '+ @DBNEGOCIO + '.DBO.TB_CONTATO WITH(NOLOCK) '                              
            SET @SSQL = @SSQL + '                              ON ASS_CTOCODIGO = CTO_CODIGO '                             
            SET @SSQL = @SSQL + '                           INNER JOIN '+ @DBNEGOCIO + '.DBO.TB_DADOSCLI WITH(NOLOCK) '                             
            SET @SSQL = @SSQL + '                              ON DDS_CLICODIGO = CLI_CODIGO AND '                              
            SET @SSQL = @SSQL + '                                 DDS_TPRCODIGO = (SELECT MAX(DDS_TPRCODIGO) FROM '+ @DBNEGOCIO + '.DBO.TB_DADOSCLI WITH(NOLOCK) WHERE DDS_CLICODIGO = CLI_CODIGO) '                              
            SET @SSQL = @SSQL + '                           INNER JOIN '+ @DBNEGOCIO + '.DBO.TB_STATUSASSOCIADO WITH(NOLOCK)  '                            
            SET @SSQL = @SSQL + '                              ON ASS_STACODIGO=STA_CODIGO  '       
            --SET @SSQL = @SSQL + '      LEFT JOIN TMKT_EASY_REPORT.DBO.TB_HISTORICO_CLIENTE_TIM WITH(NOLOCK) '    
            --SET @SSQL = @SSQL + '           ON HIS_CLICODIGO = CLI_CODIGO AND '    
            --SET @SSQL = @SSQL + '               HIS_CMPCODIGO = CLI_CMPCODIGO AND  '    
            --SET @SSQL = @SSQL + '               HIS_CTOCODIGO = CTO_CODIGO '                                                
			SET @SSQL = @SSQL + '                              LEFT JOIN (SELECT HIS_CLICODIGO, HIS_CMPCODIGO, HIS_CTOCODIGO, SUM(HIS_DURACAO) AS HIS_DURACAO, SUM(HIS_TMPALO) AS HIS_TMPALO '  
			SET @SSQL = @SSQL + '                                     FROM TMKT_EASY_REPORT.DBO.TB_HISTORICO_CLIENTE_TIM WITH(NOLOCK) '   
			SET @SSQL = @SSQL + '                GROUP BY HIS_CLICODIGO, HIS_CMPCODIGO, HIS_CTOCODIGO) AS HIS '  
			SET @SSQL = @SSQL + '                ON HIS_CLICODIGO = CLI_CODIGO AND        '          
			SET @SSQL = @SSQL + '                                          HIS_CMPCODIGO = CLI_CMPCODIGO AND '  
			SET @SSQL = @SSQL + '             HIS_CTOCODIGO = CTO_CODIGO   '                
            SET @SSQL = @SSQL + '     WHERE ASS_DATAHORA BETWEEN ''' + CONVERT(VARCHAR, @DATAINI,121) + ''' AND ''' + CONVERT(VARCHAR, @DATAFIM,121) +''''    
  
            PRINT @SSQL    
            
            
            INSERT INTO #RELS (CAMPANHA, CLICODIGO, EASYCODE, CPF, NOME, DATA_CONTATO, HORA_CONTATO, NAO_SE_APLICA, DDD, FONE,OCORRENCIA, MAT_OPERADOR, NOME_OPERADOR, RAMAL_OPERADOR,  PRODUTO, STATUS_VENDA,TPT,TPA,TPP)                              
            EXEC(@SSQL)                     
          
			--SELECT * FROM #RELS WITH(NOLOCK)
            
            --INSERT INTO #RELS (CAMPANHA, CLICODIGO, EASYCODE, CPF, NOME, DATA_CONTATO, HORA_CONTATO, NAO_SE_APLICA, DDD, FONE,OCORRENCIA, MAT_OPERADOR, NOME_OPERADOR, RAMAL_OPERADOR,TPT,TPA,TPP)                              
            SET @SSQL = ''    
            SET @SSQL = @SSQL + ' SELECT '                              
            SET @SSQL = @SSQL + ' CONVERT(VARCHAR, CMP_CODIGO) + '' - '' + CMP_CAMPANHA, '    
            SET @SSQL = @SSQL + ' HIS_CLICODIGO AS [CLICODIGO],                     '         
            SET @SSQL = @SSQL + ' HIS_EASYCODE AS [EASYCODE],                         '     
            SET @SSQL = @SSQL + ' CASE WHEN DDS_NOME = ''GUSTAVO - TESTE TMKT'' THEN '''' ELSE DDS_CPFCNPJ END AS CPF,                          '    
            SET @SSQL = @SSQL + ' CASE WHEN DDS_NOME = ''GUSTAVO - TESTE TMKT'' THEN '''' ELSE DDS_NOME END AS NOME,                          '    
            SET @SSQL = @SSQL + ' CONVERT(VARCHAR,HIS_DATAINI,103) AS [DATA CONTATO],   '                           
            SET @SSQL = @SSQL + ' CONVERT(VARCHAR, HIS_DATAINI,108) AS [HORA CONTATO],  '                            
            SET @SSQL = @SSQL + ' '''' AS [NAO SE APLICA],   '                           
            SET @SSQL = @SSQL + ' HIS_DDD AS [DDD],            '                  
            SET @SSQL = @SSQL + ' HIS_FONE AS [FONE],         '                     
            SET @SSQL = @SSQL + ' OCR_DESCRICAO AS [OCORRENCIA],                          '    
            SET @SSQL = @SSQL + ' CASE WHEN NOME = ''GUSTAVO - TESTE TMKT'' THEN '''' ELSE ISNULL(CONVERT(VARCHAR,NRREG), ''DISCADOR'') END AS [MAT. OPERADOR],                          '    
            SET @SSQL = @SSQL + ' ISNULL(NOME, '''') AS [NOME OPERADOR],                          '    
            SET @SSQL = @SSQL + ' ISNULL(CTO_RAMALAGENTE, '''') AS [RAMAL OPERADOR] ,                          '    
            SET @SSQL = @SSQL + ' CASE WHEN HIS_DURACAO <  HIS_TMPALO THEN HIS_TMPALO ELSE HIS_DURACAO END AS TPT,'    
            SET @SSQL = @SSQL + ' HIS_TMPALO AS TPA,'    
            SET @SSQL = @SSQL + '  (CASE WHEN HIS_DURACAO <  HIS_TMPALO THEN HIS_TMPALO ELSE HIS_DURACAO END - HIS_TMPALO)  AS TPP        '    
            SET @SSQL = @SSQL + ' FROM TB_HISTORICO_CLIENTE_TIM WITH(NOLOCK)                          '   
            SET @SSQL = @SSQL + ' INNER JOIN TMKT.DBO.TB_CAMPANHA WITH(NOLOCK)'    
            SET @SSQL = @SSQL + ' ON CMP_CODIGO = HIS_CMPCODIGO                               '        
            SET @SSQL = @SSQL + ' INNER JOIN '+ @DBNEGOCIO + '.DBO.TB_OCORRENCIA WITH(NOLOCK)                          '    
            SET @SSQL = @SSQL + ' ON OCR_GRUPO = HIS_GRUPO AND                           '    
            SET @SSQL = @SSQL + ' OCR_SUBGRUPO = HIS_SUBGRUPO AND                    '           
            SET @SSQL = @SSQL + ' OCR_OCORRENCIA = HIS_OCORRENCIA                    '           
            SET @SSQL = @SSQL + ' INNER JOIN #TB_CAMPANHA WITH(NOLOCK) ON (HIS_CMPCODIGO = CMPCODIGO)                          '    
            SET @SSQL = @SSQL + ' LEFT JOIN TMKT.DBO.OPERADORES WITH(NOLOCK)                           '    
            SET @SSQL = @SSQL + ' ON NRREG =  HIS_AGENTE                          '    
            SET @SSQL = @SSQL + ' LEFT JOIN '+ @DBNEGOCIO + '.DBO.TB_CONTATO WITH(NOLOCK)                           '    
            SET @SSQL = @SSQL + ' ON HIS_CTOCODIGO = CTO_CODIGO      '    
            SET @SSQL = @SSQL + ' INNER JOIN '+ @DBNEGOCIO + '.DBO.TB_DADOSCLI WITH(NOLOCK)                          '    
            SET @SSQL = @SSQL + ' ON DDS_CLICODIGO = HIS_CLICODIGO AND                           '    
            SET @SSQL = @SSQL + ' DDS_TPRCODIGO = (SELECT MAX(DDS_TPRCODIGO) FROM '+ @DBNEGOCIO + '.DBO.TB_DADOSCLI WITH(NOLOCK) WHERE DDS_CLICODIGO = HIS_CLICODIGO) '    
            SET @SSQL = @SSQL + ' WHERE HIS_DATAINI BETWEEN  ''' + CONVERT(VARCHAR, @DATAINI,121) + ''' AND ''' + CONVERT(VARCHAR, @DATAFIM,121) +''''        
            SET @SSQL = @SSQL + ' AND NOT (HIS_GRUPO = 1 AND HIS_SUBGRUPO IN (1,3) AND HIS_OCORRENCIA = 1) '  
  
            PRINT @SSQL    
            
            --INSERINDO NA TABELA OS DADOS ADQUIRIDOS NO @SSQL E COLOCADOS CONFORME AS COLUNAS ABAIXO.  
            INSERT INTO #RELS (CAMPANHA, CLICODIGO, EASYCODE, CPF, NOME, DATA_CONTATO, HORA_CONTATO, NAO_SE_APLICA, DDD, FONE,OCORRENCIA, MAT_OPERADOR, NOME_OPERADOR, RAMAL_OPERADOR,  TPT,TPA,TPP)                              
            EXEC(@SSQL)  
            
            -- O SELECT GERAL É COLOCANDO EM UMA TABELA, PARA QUE POSSAMOS FILTRAR AS INFORMAÇÕES. 
            SELECT * 
            INTO TB_FILTRO
            FROM #RELS WITH(NOLOCK)
			
			--VARIÁVEIS QUE SERAM UTILIZADAS NAS QUERYS QUE ESTÃO DENTRO DENTRO DAS CONDIÇÕES 2 E 3. 
			DECLARE 
					@NOME_COLUNA		VARCHAR(150),
					@NOME_OCORRENCIAS	VARCHAR(150),
					@CONT				INT,
					@CONT_OCO			INT, 
					@CONTADOR			INT, 
					@CONTADOR_2			INT, 
					@CONT_CABECALHO		INT,
					@CONT_LINHAS		INT,
					@SQL_OCO			VARCHAR(8000),
				    @LINHAS_OCO			VARCHAR(150),
					@COLUNAS_CMP		VARCHAR(150),
					@SQL_REL			VARCHAR(8000),
					@CONT_CMP			VARCHAR(8000),
					@CONTADOR_CAMPANHAS INT,
					@SOMA_CAMPANHAS		INT,
					@TOTAL				INT,
					@SQL				VARCHAR(8000),
					@CABECALHO			VARCHAR(MAX),
					@SELECIONA_COLUNAS	VARCHAR(MAX),
					@SQL_LINHAS			VARCHAR(MAX),
					@AUX_NOMECOLUNA     VARCHAR(8000),
					@TOTAL_OCORRENCIAS	VARCHAR(8000),	
					@TOTAL_CABECALHO    VARCHAR(8000),
					@NOME_ARQUIVO_DISCADOR VARCHAR(MAX),
					@NOME_ARQUIVO_OPERADOR VARCHAR(MAX)		
					--@TEXTO_ANALITICO VARCHAR(MAX)
			   
          	--CRIANDO CONDIÇÕES PARA QUE POSSA SER EMITIDO O RELATÓRIO CONFORME A OPÇÃO ESCOLHIDA PELO USUÁRIO (ANALÍTICO, SISTEMA OU OPERADOR).
		    --RELATÓRIO ANALÍTICO.
		    IF @TIPO = 0
		    BEGIN
			    --GERA O RELATÓRIO ANALÍTICO, CONFORME OS CAMPOS ESCOLHIDOS PELOS USUÁRIO. 
			   IF ISNULL(OBJECT_ID('TB_TMP_EXPORTA_TIM'), 0) = 0                                                                                                                          
               BEGIN                                                                                                                          
					CREATE TABLE TB_TMP_EXPORTA_TIM 
					( 
						CODIGO INT IDENTITY(1,1), 
						LINHA VARCHAR(MAX) 
					)                                      
               END                                              
               ELSE                                                                   
               BEGIN                                    
					TRUNCATE TABLE TB_TMP_EXPORTA_TIM                                                                                        
               END                           
                                      
               UPDATE #TB_CODIGO_CAMPOS SET CODIGO = A.CODIGO FROM #TB_CODIGO_CAMPOS WITH(NOLOCK)                 
																   INNER JOIN TB_CAMPOS_REL_TIM A ON (LTRIM(RTRIM(A.CAMPO)) = LTRIM(RTRIM(DESCRICAO)))                    
                        
			   --GERANDO CSV A PARTIR DOS CAMPOS                        
               SELECT @CAMPOS = ISNULL(@CAMPOS,'') + 'ISNULL(CONVERT(VARCHAR(MAX),'+CAMPO+'),'''')' + '+'';''+'                      
               FROM TB_CAMPOS_REL_TIM WITH(NOLOCK)                      
                    INNER JOIN #TB_CODIGO_CAMPOS A ON (LTRIM(RTRIM(CAMPO))= LTRIM(RTRIM(DESCRICAO)))                    
               ORDER BY A.CODIGO                         
                                                                        
               SELECT @HEADER = ISNULL(@HEADER,'SELECT ''') + LTRIM(RTRIM(DESCRICAO)) +';''+'''                         
               FROM #TB_CODIGO_CAMPOS                      
               ORDER BY  CODIGO                    
                                        
               SET @HEADER = @HEADER + 'TMKT'                  
                                                                         
               --PRINT @HEADER                         
               SET @SSQL = N' '''+@HEADER +'''                        
               UNION ALL                        
               SELECT '+ @CAMPOS+ ' FROM #RELS'                        
                                        
               SELECT @QUERY = REPLACE(REPLACE(REPLACE(REPLACE(@SSQL,'+'';''+ FROM',' FROM'),'; FROM', ' FROM'),'''SELECT','SELECT'),';''+''TMKT','')                        
                                                                                    
               INSERT INTO  TB_TMP_EXPORTA_TIM         
               EXEC(@QUERY)                           
                                                       
               SET @NOME_ARQUIVO = @ARQUIVO +  '\REL_ANALÍTICO_TIM_' + REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(19),GETDATE(),121),'-',''),':',''),' ','') + '.CSV'                          
                                                              
               /* EXPORTAÇÃO DO ARQUIVO*/                            
               SET @TEXTO = ' BCP '                                                                                                          
               + ' " SELECT LINHA FROM TMKT_EASY_REPORT..TB_TMP_EXPORTA_TIM " '                                                                 
               + ' QUERYOUT '                                                                                       
               +  @NOME_ARQUIVO                                                                                          
               + ' -c -C1252 '                                                                                                                 
               + ' -UADM '                                                                                               
               + ' -STMKT-ZL-DB20 '                                                                                                         
               + ' -PADMUSR '                                                                                                    
                                                                                                                      
               EXEC MASTER.DBO.XP_CMDSHELL @TEXTO  
		    END
		   
		   --RELATÓRIO DE TABULAÇÕES REGISTRADAS PELO DISCADOR.
		    IF @TIPO = 1 
			BEGIN				  
				--INSERINDO ÀS CAMPANHAS SELECIONADAS PELO USUÁRIO EM UMA TABELA TEMPORÁRIA (#COLUNAS).
				SELECT
					IDENTITY(INT,1,1) AS SEQ,   
					CAMPANHA					
					INTO #COLUNAS				
					FROM #RELS WITH(NOLOCK)     
					GROUP BY CAMPANHA           
								
				--INSERINDO AS OCORRENCIAS EM UMA TABELA TEMPORÁRIA (#OCORRENCIAS).
				SELECT 
					IDENTITY (INT,1,1) AS SEQ_OCO,  
					OCORRENCIA						
					INTO #OCORRENCIAS				
					FROM #RELS WITH(NOLOCK)				
					WHERE MAT_OPERADOR = 'DISCADOR' 
					GROUP BY OCORRENCIA             
												
				--CRIANDO COLUNAS.
				--DECLARANDO VARIÁVEIS QUE SERAM USADAS NA QUERY ABAIXO. 
				SET @CONT = 1 --ADICIONA UM VALOR INICIAL AO CONTADOR. 
				WHILE @CONT <= (SELECT COUNT(0) FROM #COLUNAS WITH(NOLOCK)) --FAZ A INSERÇÃO DE COLUNAS DE ACORDO AS CAMPANHAS SELECIONAS. 
				BEGIN
					--É ATRIBUIDO A VARIÁVEL @NOME_COLUNA AS CAMPANHAS SELECIONADAS. 
					SELECT @NOME_COLUNA = CAMPANHA FROM #COLUNAS WITH(NOLOCK) WHERE SEQ = @CONT
						
					--ATRIBUINDO AS COLUNAS(CAMPANHAS) A TABELA. OBS. A TABELA JÁ POSSUI A COLUNA OCORRÊNCIA.
					SET @SQL = N'ALTER TABLE RELATORIO ADD ['+LTRIM(RTRIM(@NOME_COLUNA))+'] VARCHAR(50)'
						
					PRINT(@SQL)
					EXEC(@SQL)
					--ATRIBUI MAIS UM NÚMERO AO CONTATODOR. 
					SET @CONT = @CONT+1
				END
						
				--INSERINDO AS OCORRENCIAS NA TABELA RELATORIO.
				SET @CONT_OCO = 1 -- ADICIONA UM VALOR INICIAL AO CONTADOR.
				WHILE @CONT_OCO <= (SELECT COUNT(0) FROM #OCORRENCIAS WITH(NOLOCK))--ENQUANTO O CONTADOR FOR MENOR OU IGUAL AO TOTAL DE OCORRENCIAS REGISTRADAS. 	
				BEGIN	
					
					--É ATRIBUIDO A VARIÁEL @NOME_OCORRENCIAS AS OCORRENCIAS INSERIDAS PELOS DISCADOR. 
					SELECT @NOME_OCORRENCIAS = OCORRENCIA FROM #OCORRENCIAS WITH(NOLOCK) WHERE SEQ_OCO = @CONT_OCO
					--INSERINDO AS OCORRENCIAS NA COLUNA OCORRENCIA DA TABELA.		
					SET @SQL_OCO = N'INSERT INTO RELATORIO (OCORRENCIA)VALUES ('''+LTRIM(RTRIM(@NOME_OCORRENCIAS))+''')'
							
					PRINT(@SQL_OCO)
					EXEC(@SQL_OCO) --EXECUTA A QUEY DINÂMICA@NOME_OCORRENCIAS
					
					--ATRIBUI MAIS UM NÚMERO AO CONTATODOR. 		
					SET @CONT_OCO = @CONT_OCO+1
				END 
						
				--INSERINDO NA TABELA RELATÓRIO A QUANTIDADE DE OCORRENCIAS CORRESPONDENTES A CADA CAMPANHA. 		
				--DECLARANDO AS VARIÁVEIS QUE SERAM UTILIZADAS NA QUERY ABAIXO. 
				SET @CONTADOR = 1 --ATRIBUINDO UM VALOR INICIAL AO CONTADOR. 
				WHILE @CONTADOR <= (SELECT COUNT(0) FROM #OCORRENCIAS) 
				BEGIN
							
					--É ATRIBUIDO A VARIÁEL @@LINHAS_OCO AS OCORRENCIA QUE CONSTAM NA TABELA #OCORRENCIAS, CONFORME A ORDEM DO CONTADOR. 
					SELECT @LINHAS_OCO = OCORRENCIA FROM #OCORRENCIAS WHERE @CONTADOR = SEQ_OCO
							
					SET @SOMA_CAMPANHAS = 0 --ATRIBUINDO UM VALOR INICIAL A VARIÁVEL. 
					SET @CONTADOR_2 = 1	 --ATRIBUINDO UM VALOR INICIAL AO CONTADOR.   
					WHILE @CONTADOR_2 <= (SELECT COUNT(0) FROM #COLUNAS)
					BEGIN	
						
						--É ATRIBUIDO A VARIÁEL @COLUNAS_CMP AS CAMPANHAS QUE CONSTAM NA TABELA #COLUNAS, CONFORME A ORDEM DO CONTADOR. 
						SELECT @COLUNAS_CMP = CAMPANHA FROM #COLUNAS WHERE @CONTADOR_2 = SEQ
						
						--EFETUANDO A CONTAGEM DA OCORRENCIA. 
						SET @CONT_CMP = N'(SELECT CONVERT(VARCHAR, COUNT(0)) FROM TB_FILTRO WITH(NOLOCK) WHERE MAT_OPERADOR = ''DISCADOR'' AND CAMPANHA = '''+@COLUNAS_CMP+'''AND OCORRENCIA = '''+@LINHAS_OCO +''')'
						--INSERINDO NA TABELA RELATÓRIO A QUANTIDADE DE OCORRENCIAS DE ACORDO A CAMPANHA, QUE SEGUE NA ORDEM DO CONTADOR. 
						SET @SQL_REL = N'UPDATE RELATORIO SET ['+@COLUNAS_CMP+'] = '+@CONT_CMP+' WHERE OCORRENCIA = '''+@LINHAS_OCO+''''	
								
						PRINT(@SQL_REL)
						--EXECUTA A QUERY DINÂMICA.
						EXEC(@SQL_REL)
						
						--EFETUANDO A CONTAGEM DA OCORRENCIA. 
						SET @CONTADOR_CAMPANHAS = (SELECT COUNT(0) FROM TB_FILTRO WITH(NOLOCK) WHERE MAT_OPERADOR = 'DISCADOR' AND CAMPANHA = @COLUNAS_CMP AND OCORRENCIA = @LINHAS_OCO)
						
						--SOMANDO TODAS A QUANTIDADE DAS OCORRENCIAS DE TODAS AS CAMPANHAS, PORÉM SOMADAS AS QUANTIDADES POR LINHA, OU SEJA SEGUE A ORDEM DO CONTADOR. 							  
						SET @SOMA_CAMPANHAS = @SOMA_CAMPANHAS + @CONTADOR_CAMPANHAS 
						
						--ATUALIZA O CAMPO CAMPO TOTAL COM O TOTAL DE TODAS AS OCORRENCIAS CORRESPONDENTES AS SUAS CAMPANHAS E QUE SEGUEM A ORDEM DO CONTADOR. 														
						UPDATE RELATORIO SET TOTAL = @SOMA_CAMPANHAS WHERE OCORRENCIA = @LINHAS_OCO				
						
						--ATRIBUIDO MAIS UM VALOR AO CONTAOR							    
						SET @CONTADOR_2 = @CONTADOR_2 + 1
							    
					END 
							 --ATRIBUIDO MAIS UM VALOR AO CONTADOR. 
							 SET @CONTADOR = @CONTADOR + 1 
				END

				SET @CABECALHO = 'OCORRENCIA;'  --ATRIBUI O NOME DA COLUNA OCORRENCIA DA TABELA RELATÓRIO NA VARIÁVEL, SEPARADOS POR PONTO E VIRGULA.
				SET @SELECIONA_COLUNAS = 'OCORRENCIA +'';''+ ' --ATRIBUI O NOME DA COLUNA OCORRENCIA DA TABELA RELATÓRIO NA VARIÁVEL, SEPARADOS POR PONTO E VIRGULA. 
				SET @TOTAL_CABECALHO = 'TOTAL;'
				SET @TOTAL_OCORRENCIAS = 'TOTAL'--ATRIUBUI O TOTAL DA QUANTIDADE DE TODAS AS OCORRENCIAS. 
				SET @CONT_CABECALHO = 1
				WHILE @CONT_CABECALHO <= (SELECT COUNT(0) FROM #COLUNAS WITH(NOLOCK))
				BEGIN
					--RECEBE AS COLUNAS COM O NOME DAS CAMPANHAS ESCOLHIDAS PELO USUÁRIO. 
					SELECT @AUX_NOMECOLUNA = CAMPANHA FROM #COLUNAS WHERE SEQ = @CONT_CABECALHO
					
					--ARAMAZENA NA VARIÁVEL @CABECALHO AS COLUNAS SEPARADAS POR PONTO E VIRGULA
					SET  @CABECALHO = @CABECALHO+@AUX_NOMECOLUNA+';'
										
					SET @SELECIONA_COLUNAS = @SELECIONA_COLUNAS + '['+@AUX_NOMECOLUNA+']'+'+'';''+'
				 
					--ADICIONA MAIS UM VALOR AO CONTADOR.			
					SET @CONT_CABECALHO = @CONT_CABECALHO + 1
				END
				
				 SET  @CABECALHO = @CABECALHO + @TOTAL_CABECALHO -- ADICIONANDO O TOTAL DAS OCORRENCIAS NO CABEÇALHO. 
				 
				 --INSERE O CABEÇAÇHO NA COLUNA LINHA_ARQUIVO DA TABELA LINHAS_ARQUIVO.
				 INSERT INTO LINHAS_ARQUIVO (LINHA_ARQUIVO)
				 SELECT @CABECALHO
				 
				 --COLUNAS QUE SERÃO CHAMADOS QUANDO RODAR O WHILE.
				 SET @SELECIONA_COLUNAS = @SELECIONA_COLUNAS + CONVERT(VARCHAR,'['+@TOTAL_OCORRENCIAS+']')
				 
				 --NESSE WHILE SERÃO ADICIONADOS OS VALORES DOS CAMPOS. 
				 SET @CONT_LINHAS = 1
				 WHILE @CONT_LINHAS <= (SELECT COUNT(0) FROM RELATORIO WITH(NOLOCK))
				 BEGIN	
					
					
					SET @SQL_LINHAS = 'SELECT '+(@SELECIONA_COLUNAS)+' FROM RELATORIO WHERE CONVERT(VARCHAR, SEQ) = '''+CONVERT(VARCHAR,@CONT_LINHAS)+''''
					PRINT(@SQL_LINHAS)
					
	 				--INSERE NA TABELA LINHAS_ARQUIVO AS LINHAS CORRESPONDENTES A TABELA RELATÓRIO
				    INSERT INTO LINHAS_ARQUIVO (LINHA_ARQUIVO)
				    EXEC(@SQL_LINHAS)
					
					--ADICIONA MAIS UM VALOR AO CONTADOR.
					SET @CONT_LINHAS = @CONT_LINHAS + 1
					
				 END
				 
				 SET @NOME_ARQUIVO_DISCADOR = @ARQUIVO +  '\REL_OCORRENCIAS_DISCADOR' + REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(19),GETDATE(),121),'-',''),':',''),' ','') + '.CSV'                          
                                                              
                 /* EXPORTAÇÃO DO ARQUIVO*/                            
                 SET @TEXTO = ' BCP '                                                                                                          
                 + ' " SELECT LINHA_ARQUIVO FROM TMKT_EASY_REPORT..LINHAS_ARQUIVO" '                                                                 
                 + ' QUERYOUT '                                                                                       
                 + @NOME_ARQUIVO_DISCADOR                                                                                          
                 + ' -c -C1252 '                                                                                                                 
                 + ' -UADM '                                                                                               
                 + ' -STMKT-ZL-DB20 '                                                                                                         
                 + ' -PADMUSR '                                                                                                    
                                                                                                                      
                 EXEC MASTER.DBO.XP_CMDSHELL @TEXTO  
			
			END
						
		    --RELATÓRIO DE TABULAÇÕES REGISTRADAS PELO OPERADOR.
		    IF @TIPO = 2
			BEGIN 
				--INSERINDO ÀS CAMPANHAS SELECIONADAS PELO USUÁRIO EM UMA TABELA TEMPORÁRIA (#COLUNAS).
				SELECT
					IDENTITY(INT,1,1) AS SEQ,   
					CAMPANHA					
					INTO #COLUNAS_OP				
					FROM #RELS WITH(NOLOCK)     
					GROUP BY CAMPANHA           
					
				--INSERINDO AS OCORRENCIAS EM UMA TABELA TEMPORÁRIA (#OCORRENCIAS)
				SELECT 
					IDENTITY (INT,1,1) AS SEQ_OCO,  
					OCORRENCIA						
					INTO #OCORRENCIAS_OP				
					FROM #RELS WITH(NOLOCK)				
					WHERE MAT_OPERADOR <> 'DISCADOR' 
					GROUP BY OCORRENCIA             
											
				--CRIANDO COLUNAS.
				--DECLARANDO VARIÁVEIS QUE SERAM USADAS NA QUERY ABAIXO. 
				SET @CONT = 1 --ADICIONA UM VALOR INICIAL AO CONTADOR. 
				WHILE @CONT <= (SELECT COUNT(0) FROM #COLUNAS_OP WITH(NOLOCK)) --FAZ A INSERÇÃO DE COLUNAS DE ACORDO AS CAMPANHAS SELECIONAS. 
				BEGIN
					--É ATRIBUIDO A VARIÁVEL @NOME_COLUNA AS CAMPANHAS SELECIONADAS. 
					SELECT @NOME_COLUNA = CAMPANHA FROM #COLUNAS_OP WITH(NOLOCK) WHERE SEQ = @CONT
						
					--ATRIBUINDO AS COLUNAS(CAMPANHAS) A TABELA. OBS. A TABELA JÁ POSSUI A COLUNA OCORRÊNCIA.
					SET @SQL = N'ALTER TABLE RELATORIO ADD ['+LTRIM(RTRIM(@NOME_COLUNA))+'] VARCHAR(50)'
						
					PRINT(@SQL)
					EXEC(@SQL)
					--ATRIBUI MAIS UM NÚMERO AO CONTATODOR. 
					SET @CONT = @CONT+1
				END
						
						
				--INSERINDO AS OCORRENCIAS NA TABELA RELATORIO.
			    --DECLARANDO AS VARIÁVEIS QUE SERAM USADAS NA QUERY ABAIXO.
			    SET @CONT_OCO = 1 -- ADICIONA UM VALOR INICIAL AO CONTADOR.
				WHILE @CONT_OCO <= (SELECT COUNT(0) FROM #OCORRENCIAS_OP WITH(NOLOCK))--ENQUANTO O CONTADOR FOR MENOR OU IGUAL AO TOTAL DE OCORRENCIAS REGISTRADAS. 	
				BEGIN	
					
					--É ATRIBUIDO A VARIÁEL @NOME_OCORRENCIAS AS OCORRENCIAS INSERIDAS PELO OPERADOR. 
					SELECT @NOME_OCORRENCIAS = OCORRENCIA FROM #OCORRENCIAS_OP WITH(NOLOCK) WHERE SEQ_OCO = @CONT_OCO
					--INSERINDO AS OCORRENCIAS NA COLUNA OCORRENCIA DA TABELA.		
					SET @SQL_OCO = N'INSERT INTO RELATORIO (OCORRENCIA)VALUES ('''+LTRIM(RTRIM(@NOME_OCORRENCIAS))+''')'
							
					PRINT(@SQL_OCO)
					EXEC(@SQL_OCO) --EXECUTA A QUEY DINÂMICA@NOME_OCORRENCIAS
					
					--ATRIBUI MAIS UM NÚMERO AO CONTATODOR. 		
					SET @CONT_OCO = @CONT_OCO+1
				END 
						
				--INSERINDO NA TABELA RELATÓRIO A QUANTIDADE DE OCORRENCIAS CORRESPONDENTES A CADA CAMPANHA. 		
			    SET @CONTADOR = 1 --ATRIBUINDO UM VALOR INICIAL AO CONTADOR. 
				WHILE @CONTADOR <= (SELECT COUNT(0) FROM #OCORRENCIAS_OP) 
				BEGIN
							
					--É ATRIBUIDO A VARIÁEL @@LINHAS_OCO AS OCORRENCIA QUE CONSTAM NA TABELA #OCORRENCIAS, CONFORME A ORDEM DO CONTADOR. 
					SELECT @LINHAS_OCO = OCORRENCIA FROM #OCORRENCIAS_OP WHERE @CONTADOR = SEQ_OCO
							
					SET @SOMA_CAMPANHAS = 0 --ATRIBUINDO UM VALOR INICIAL A VARIÁVEL. 
					SET @CONTADOR_2 = 1	 --ATRIBUINDO UM VALOR INICIAL AO CONTADOR.   
					WHILE @CONTADOR_2 <= (SELECT COUNT(0) FROM #COLUNAS_OP)
					BEGIN	
						
						--É ATRIBUIDO A VARIÁEL @COLUNAS_CMP AS CAMPANHAS QUE CONSTAM NA TABELA #COLUNAS, CONFORME A ORDEM DO CONTADOR. 
						SELECT @COLUNAS_CMP = CAMPANHA FROM #COLUNAS_OP WHERE @CONTADOR_2 = SEQ
						
						--EFETUANDO A CONTAGEM DA OCORRENCIA. 
						SET @CONT_CMP = N'(SELECT CONVERT(VARCHAR, COUNT(0)) FROM TB_FILTRO WITH(NOLOCK) WHERE MAT_OPERADOR <> ''DISCADOR'' AND CAMPANHA = '''+@COLUNAS_CMP+'''AND OCORRENCIA = '''+@LINHAS_OCO +''')'
						--INSERINDO NA TABELA RELATÓRIO A QUANTIDADE DE OCORRENCIAS DE ACORDO A CAMPANHA, QUE SEGUE NA ORDEM DO CONTADOR. 
						SET @SQL_REL = N'UPDATE RELATORIO SET ['+@COLUNAS_CMP+'] = '+@CONT_CMP+' WHERE OCORRENCIA = '''+@LINHAS_OCO+''''	
								
						PRINT(@SQL_REL)
						--EXECUTA A QUERY DINÂMICA.
						EXEC(@SQL_REL)
						
						--EFETUANDO A CONTAGEM DA OCORRENCIA. 
						SET @CONTADOR_CAMPANHAS = (SELECT COUNT(0) FROM TB_FILTRO WITH(NOLOCK) WHERE MAT_OPERADOR <> 'DISCADOR' AND CAMPANHA = @COLUNAS_CMP AND OCORRENCIA = @LINHAS_OCO)
						
						--SOMANDO TODAS A QUANTIDADE DAS OCORRENCIAS DE TODAS AS CAMPANHAS, PORÉM SOMADAS AS QUANTIDADES POR LINHA, OU SEJA SEGUE A ORDEM DO CONTADOR. 							  
						SET @SOMA_CAMPANHAS = @SOMA_CAMPANHAS + @CONTADOR_CAMPANHAS 
						
						--ATUALIZA O CAMPO CAMPO TOTAL COM O TOTAL DE TODAS AS OCORRENCIAS CORRESPONDENTES AS SUAS CAMPANHAS E QUE SEGUEM A ORDEM DO CONTADOR. 														
						UPDATE RELATORIO SET TOTAL = @SOMA_CAMPANHAS WHERE OCORRENCIA = @LINHAS_OCO				
						
						--ATRIBUIDO MAIS UM VALOR AO CONTAOR							    
						SET @CONTADOR_2 = @CONTADOR_2 + 1
							    
					END 
							 --ATRIBUIDO MAIS UM VALOR AO CONTADOR. 
							 SET @CONTADOR = @CONTADOR + 1 
				END
				
				SET @CABECALHO = 'OCORRENCIA;'  --ATRIBUI O NOME DA COLUNA OCORRENCIA DA TABELA RELATÓRIO NA VARIÁVEL, SEPARADOS POR PONTO E VIRGULA.
				SET @SELECIONA_COLUNAS = 'OCORRENCIA +'';''+ ' --ATRIBUI O NOME DA COLUNA OCORRENCIA DA TABELA RELATÓRIO NA VARIÁVEL, SEPARADOS POR PONTO E VIRGULA. 
				SET @TOTAL_CABECALHO = 'TOTAL;'
				SET @TOTAL_OCORRENCIAS = 'TOTAL'--ATRIUBUI O TOTAL DA QUANTIDADE DE TODAS AS OCORRENCIAS. 
				SET @CONT_CABECALHO = 1
				WHILE @CONT_CABECALHO <= (SELECT COUNT(0) FROM #COLUNAS_OP WITH(NOLOCK))
				BEGIN
					--RECEBE AS COLUNAS COM O NOME DAS CAMPANHAS ESCOLHIDAS PELO USUÁRIO. 
					SELECT @AUX_NOMECOLUNA = CAMPANHA FROM #COLUNAS_OP WHERE SEQ = @CONT_CABECALHO
					
					--ARAMAZENA NA VARIÁVEL @CABECALHO AS COLUNAS SEPARADAS POR PONTO E VIRGULA
					SET  @CABECALHO = @CABECALHO+@AUX_NOMECOLUNA+';'
										
					SET @SELECIONA_COLUNAS = @SELECIONA_COLUNAS + '['+@AUX_NOMECOLUNA+']'+'+'';''+'
				 
					--ADICIONA MAIS UM VALOR AO CONTADOR.			
					SET @CONT_CABECALHO = @CONT_CABECALHO + 1
				END
				
				 SET  @CABECALHO = @CABECALHO + @TOTAL_CABECALHO -- ADICIONANDO O TOTAL DAS OCORRENCIAS NO CABEÇALHO. 
				 
				 --INSERE O CABEÇAÇHO NA COLUNA LINHA_ARQUIVO DA TABELA LINHAS_ARQUIVO.
				 INSERT INTO LINHAS_ARQUIVO (LINHA_ARQUIVO)
				 SELECT @CABECALHO
				 
				 --COLUNAS QUE SERÃO CHAMADOS QUANDO RODAR O WHILE.
				 SET @SELECIONA_COLUNAS = @SELECIONA_COLUNAS + CONVERT(VARCHAR,'['+@TOTAL_OCORRENCIAS+']')
				 
				 --NESSE WHILE SERÃO ADICIONADOS OS VALORES DOS CAMPOS. 
				 SET @CONT_LINHAS = 1
				 WHILE @CONT_LINHAS <= (SELECT COUNT(0) FROM RELATORIO WITH(NOLOCK))
				 BEGIN	
					
					
					SET @SQL_LINHAS = 'SELECT '+(@SELECIONA_COLUNAS)+' FROM RELATORIO WHERE CONVERT(VARCHAR, SEQ) = '''+CONVERT(VARCHAR,@CONT_LINHAS)+''''
					PRINT(@SQL_LINHAS)
					
	 				--INSERE NA TABELA LINHAS_ARQUIVO AS LINHAS CORRESPONDENTES A TABELA RELATÓRIO
				    INSERT INTO LINHAS_ARQUIVO (LINHA_ARQUIVO)
				    EXEC(@SQL_LINHAS)
					
					--ADICIONA MAIS UM VALOR AO CONTADOR.
					SET @CONT_LINHAS = @CONT_LINHAS + 1
					
				 END
				  
				 SET @NOME_ARQUIVO_OPERADOR = @ARQUIVO +  '\REL_OCORRENCIAS_OPERADOR' + REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(19),GETDATE(),121),'-',''),':',''),' ','') + '.CSV'                          
                                                              
                 /* EXPORTAÇÃO DO ARQUIVO*/                            
                 SET @TEXTO = ' BCP '                                                                                                          
                 + ' " SELECT LINHA_ARQUIVO FROM TMKT_EASY_REPORT..LINHAS_ARQUIVO" '                                                                 
                 + ' QUERYOUT '                                                                                       
                 + @NOME_ARQUIVO_OPERADOR
                 + ' -c -C1252 '                                                                                                                 
                 + ' -UADM '                                                                                               
                 + ' -STMKT-ZL-DB20 '                                                                                                         
                 + ' -PADMUSR '                                                                                                    
                                                                                                                      
                 EXEC MASTER.DBO.XP_CMDSHELL @TEXTO  			
			END
	   END --QUANDO FOR FAZER TESTES. 
  END--FECHAR A PROCEDURE.



