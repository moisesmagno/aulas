<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>WS PHP - Acesso Privado</title>
    </head>
    <body>
        <?php
        require('./inc/Config.inc.php');

        $robson = new AcessoPrivado('Robson', 'contato@upinside.com', 89787634598);
//        $robson->

        var_dump($robson);
        
        ?>
    </body>
</html>
