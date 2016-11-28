<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>WS PHP - Modelo de Agregação</title>
    </head>
    <body>
        <?php
        require('./inc/Config.inc.php');
        
        $robson = new ComposicaoUsuario('Robson V. Leite', 'campus@upinside.com.br');
        $robson->CadastrarEndereco('Soledade', 'RS');
        
        echo "O email de {$robson->Nome} é {$robson->Email}<br>";
        echo "{$robson->Nome} mora em {$robson->getEndereco()->getCidade()}/{$robson->getEndereco()->getEstado()}";
        
        var_dump($robson);
        
        ?>
    </body>
</html>
