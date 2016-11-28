<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <?php
            require('./_app/Config.inc.php');
            $PDO = new Conn;
            
            $name = "firefox";
            $views = '128';
            
            try{
                $QRCreate = "INSERT INTO ws_siteviews_agent (agent_name, agent_views) VALUES (?, ?)";
                $create = $PDO->getConn()->prepare($QRCreate);
                $create->bindValue(1, 'Chrome', PDO::PARAM_STR);
                $create->bindValue(2, '123', PDO::PARAM_INT);
                $create->execute();
               
                if($create->rowCount()):
                    echo "{$PDO->getConn()->lastInsertId()} inserido com sucesso!";
                endif;
                
            }catch(PDOException $e){
                PHPErro($e->getCode(), $e->getMessage(), $e->getFile(), $e->getLine());;
            }
        ?>
    </body>
</html>
