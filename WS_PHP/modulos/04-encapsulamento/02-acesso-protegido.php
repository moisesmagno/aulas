<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>WS PHP - Acesso Protegido</title>
    </head>
    <body>
        <?php
        require('./inc/Config.inc.php');
        
        $maria = new AcessoProtegido('Maria', 'maria@server.com');
        $maria->Nome = 'Maria Santos';
        //$maria->Email = 'mariasanto@server.com';
        
        $maria->setEmail('mariasantos@email.com');
        //$maria->setNome('Pablo');
        
        var_dump($maria);        
        echo "<hr>";
        
        $pablo = new AcessoProtegidoFilha('Pablo', 'pablo@email.com');
        //$pablo->setNome();
        
        $pablo->AddCpf('Pabblo Silva', '09845634587');
               
        
        var_dump($pablo);
        
        ?>
    </body>
</html>
