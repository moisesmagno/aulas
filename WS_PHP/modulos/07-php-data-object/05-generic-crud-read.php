<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <?php
            require('./_app/Config.inc.php');

            $termos = 'WHERE agent_name = :name AND agent_views > :views LIMIT :limit';
            $parseString = 'name=firefox&views=10&limit=3';
            
            $read = new Read;
            $read->ExeRead('ws_siteviews_agent', $termos, $parseString);
            
            $parseString = 'name=firefox&views=10&limit=5';
            $read->setPlaces($parseString);  
            
            if($read->getRowCount()):
                echo "<pre>";
                var_dump($read->getResult());
                echo "</pre> <hr>";
            endif;
            
            
            $read->FullRead('SELECT * FROM ws_siteviews_agent LIMIT :limit', 'limit=5');
            
            
            echo "<pre>";
            var_dump($read);
            echo "</pre>";
        ?>
    </body>
</html>
