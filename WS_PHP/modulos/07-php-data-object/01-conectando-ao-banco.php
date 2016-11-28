<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title>Conectando ao banco de dados</title>
    </head>
    <body>
        <?php
            require('./_app/Config.inc.php');
            
            $conn = new Conn;
            $conn->getConn();
            
            var_dump($conn);
        ?>
    </body>
</html>
