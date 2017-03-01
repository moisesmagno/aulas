<?php
  /**
  * Login.class [Model]
  * Responsável por autenticar, validar e checar usuário do sistema de login.
  */

  class Login{
    private $level;
    private $email;
    private $senha;
    private $error;
    private $result;

    function __construct($level){
          $this->level = (int) $level;
    }

    public function exeLogin(array $userData){
      $this->email = (string) $userData['user'];
      $this->senha = (string) $userData['pass'];
      $this->setLogin();
    }

    public function getResult(){
      return $this->result;
    }

    public function getError(){
      return $this->error;
    }

    //PRIVATES
    private function setLogin(){
        if(!$this->email || !$this->senha || !Check::Email($this->email)){
            $this->error = ['Informe E-mail e Senha para efetuar login!', WS_ALERT];
        }elseif(!$this->getuser()){
            $this->error = ['Os dados informados não são compatíveis!', WS_ALERT];
        }elseif($this->result['user_level'] < $this->level){
            $this->error = ["Desculpe {$this->result['username']}, você não tem permissão para acessar esta área!", WS_ALERT];
        }else{
            $this->execute();
        }
    }

    private function getUser(){
      $read = new Read;
      $read->ExeRead("ws_users", "WHERE user_email = :e AND user_password = :p", "e={$this->email}&p={$this->senha}");

      if($read->getResult()){
          $this->result = $read->getResult()[0];
          return true;
      }else{
        return false;
      }
    }

    private function execute(){
      if(!session_id()){
        session_start();
      }

      $_SESSION['userlogin'] = $this->result;
      $this->error  = ["Olá {$this->result['user_name']}, seja bem vindo(a). Aguarde o redirecionamento!", WS_ACCEPT];
      $this->result = true;
    }
  }
?>
