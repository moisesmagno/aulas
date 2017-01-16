<?php

/**
 *<b>Create.class</b>
 * Classe responsável por cadastros genéricos no banco de dados.
 * @copyright (c) year, Moisés Salvador Escurra Aguilar
 */
class Create extends Conn{

    private $Tabela;
    private $Dados;
    private $Result;

    /** @var PDOStatement */
    private $Create;

    /** @var PDO */
    private $Conn;

    /**
     * <b>ExeCreate:</b> Executa um cadastro simplificado no banco de dados utilizando prepared statements.
     * Basta informar o nome da tabela e um array atribuitivo com nome da coluna e valor!
     * 
     * @param STRING $Tabela = Informe o nome da tabela no banco!
     * @param ARRAY $Dados = Informe um array atribuitivo. ( Nome Da Coluna => Valor ).
     */
    public function ExeCreate($Tabela, array $Dados) {
        $this->Tabela = (string) $Tabela; // Recebe o nome da tabela
        $this->Dados = $Dados; //Recebe valores como: ('col1'=>'valor', 'col2'=>'valor', 'col3'=>'valor')

        $this->getSyntax();
        $this->Execute();
    }

    /**
     * <b>Obter resultado:</b> Retorna o ID do registro inserido ou FALSE caso nem um registro seja inserido! 
     * @return INT $Variavel = lastInsertId OR FALSE
     */
    public function getResult() {
        return $this->Result;
    }
    
    /**
     * ****************************************
     * *********** PRIVATE METHODS ************
     * ****************************************
     */
    
    //Cria a sintaxe da query para Prepared Statements
    private function getSyntax(){
        $Fileds = implode(',', array_keys($this->Dados)); //Pega o indice do array Dados. Ex: (col1,col2,col3)
        $Places = ':' . implode(', :', array_keys($this->Dados)); //Adiciona dois pontos nos indices do array Dados. Ex: (:link1, :link2, :link3)
        $this->Create = "INSERT INTO {$this->Tabela} ({$Fileds}) VALUES ({$Places})";
    }
    
    //Obtém o PDO e Prepara a query
    private function connect(){
        $this->Conn = parent::getConn();
        
        //Realiza o prepare Statement com a query montada no getSyntax e armazenada no $this->Create.
        $this->Create = $this->Conn->prepare($this->Create); 
    }
    
    //Obtém a Conexão e a Syntax, executa a query!
    private function Execute(){
        $this->connect(); //Faz a conexão com o banco.
        try {
            $this->Create->execute($this->Dados);
            $this->Result = $this->Conn->lastInsertId();
        } catch (PDOException $e) {
            $this->Result = null;
            WSErro("<b>Erro ao cadastrar: </b> {$e->getMessage()}", $e->getCode());
        }
    }
}
