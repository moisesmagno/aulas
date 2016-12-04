<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>06-generic-crud-update</title>
    </head>
    <body>
        <?php
            require('./_app/Config.inc.php');
            
            $dados = ['agent_name'=>'safari', 'agent_views'=>'100'];
            
            $update = new Update;
            $update->ExeUpdate('ws_siteviews_agent', $dados, "WHERE agent_id = :id", 'id=5');
            
            if($update->getResult()){
                echo "{$update->getRowCount()} dado(s) atualiados.<hr>";
            }
            
            
            $update->setPlaces("id=2");
            $update->setPlaces("id=3");
            $update->setPlaces("id=4");

                    
                    
            echo "<pre>";
            echo var_dump($update);
            echo "</pre>";
        ?>
    </body>
</html>
