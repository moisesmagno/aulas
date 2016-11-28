<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>WS PHP - Acesso Publico</title>
    </head>
    <body>
        <?php
        require('./inc/Config.inc.php');  
        
        $robson = new AcessoPublico('Robson', 'campus@upinside.com');
        $robson->Nome = 'Marcos';
        $robson->Email = 'marcos@email.com';
        
        $robson->Email = 'banana';
        
        var_dump($robson);
        
        ?>
    </body>
</html>
