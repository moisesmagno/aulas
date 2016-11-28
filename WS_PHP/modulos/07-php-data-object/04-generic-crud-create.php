<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <?php
            require('./_app/Config.inc.php');
            
            $dados = ['agent_name'=>'fiferox', 'agent_views'=>'1234'];
            
            $cadastra = new Create;
            $cadastra->ExeCreate('ws_siteviews_agent', $dados);
            
            if($cadastra->getResult()){
                echo $cadastra->getResult() . ' é o id do novo registro!';
                echo "<br>";
            }
            echo "<pre>";
            var_dump($cadastra);
            echo "</pre>";
        ?>
    </body>
</html>
