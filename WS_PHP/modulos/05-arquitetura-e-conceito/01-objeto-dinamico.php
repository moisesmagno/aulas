<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>WS PHP - Objeto Dinâmico</title>
    </head>
    <body>
        <?php
        require('./inc/Config.inc.php');
        
        $cliente = new ObjetoDinamico;
        
        $robson = new stdClass();
        $robson->Nome = 'Robson';
        $robson->Email = 'contato@upinside.com.br';
        
        $cliente->Novo($robson);
        
        $marcos = clone($robson);
        $marcos->Nome = "Marcos";
        $marcos->Email = 'banana';
        
        
        var_dump($cliente, $robson, $marcos);
        
        ?>
    </body>
</html>
