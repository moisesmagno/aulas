<?php
session_start();

require('../_app/Config.inc.php');

var_dump($_SESSION);

?>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="mit" content="2017-02-26T18:18:33-03:00+36567">
        <title>Site Admin</title>

        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,800' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="css/reset.css" />
        <link rel="stylesheet" href="css/admin.css" />

    </head>
    <body class="login">

        <div id="login">
            <div class="boxin">
                <h1>Administrar Site</h1>

                <?php
                //WSErro("Os dados não conferem. Favor informe seu e-mail e senha!", WS_ERROR);

                $login = new Login(3);


                $dataLogin = filter_input_array(INPUT_POST, FILTER_DEFAULT);
                if(!empty($dataLogin['AdminLogin'])){
                  $login->exeLogin($dataLogin);
                  var_dump($login);
                }
                ?>

                <form name="AdminLoginForm" action="" method="post">
                    <label>
                        <span>E-mail:</span>
                        <input type="email" name="user" />
                    </label>

                    <label>
                        <span>Senha:</span>
                        <input type="password" name="pass" />
                    </label>

                    <input type="submit" name="AdminLogin" value="Logar" class="btn blue" />

                </form>
            </div>
        </div>

    </body>
</html>
