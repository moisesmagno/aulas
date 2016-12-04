<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title>07-generic-crud-delete</title>
    </head>
    <body>
        <?php
            require('./_app/Config.inc.php');
            
            $delete = new Delete;
            $delete->ExeDelete('ws_siteviews_agent', "WHERE agent_id = :id", "id=4");
            
            if($delete->getResult()){
                echo "{$delete->getRowCount()} Registro(s) removidos com sucesso!<hr>";
            }
            
            echo "<pre>";
            echo var_dump($delete);
            echo "</pre>";
            
        ?>
    </body>
</html>
