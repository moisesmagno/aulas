<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>WSPHP - Personalizando Erros</title>
        <link rel="stylesheet" href="css/reset.css"/>
    </head>
    <body>
        <?php
            require('./_app/Config.inc.php');
            
            trigger_error('Esta é uma NOTICE', E_USER_NOTICE);
            trigger_error('Esta é um ALERT', E_USER_WARNING);
            trigger_error('EstE é uma ERROR', E_USER_ERROR);
        ?>
    </body>
</html>
