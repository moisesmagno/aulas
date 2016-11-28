<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>WS PHP - Modelo de Associação</title>
    </head>
    <body>
        <?php
        require('./inc/Config.inc.php');

        $robson = new AssociacaoCliente("Robson V. leite", 'campus@upinside.com.br');

//        $robson = new stdClass();
//        $robson->Nome = 'Robson';
//        $robson->Email = 'contato';
        
        $login = new AssociaoLogin($robson);

        if ($login->getLogin()):
            echo "Gerenciando o cliente id: {$login->getCliente()->getCliente()}<br>";
            echo "{$login->getCliente()->getNome()} logou com sucesso usando o e-mail {$login->getCliente()->getEmail()}<hr>";
        else:
            echo 'Erro ao logar!';
        endif;

        var_dump($robson, $login);
        ?>
    </body>
</html>
