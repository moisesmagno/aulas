<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>WS HELPERS :: Helper de gestão de upload</title>
        <link rel="stylesheet" href="css/reset.css"/>
    </head>
    <body>
        <?php
            require('./_app/Config.inc.php');
            
            //Limpa qualquer tipo de inserção malisiosa.
            $form = filter_input_array(INPUT_POST, FILTER_DEFAULT);
            
            //Pega as informações do formulário sendImagess
            if($form && $form['sendImage']):
                
                $upload = new Upload;
                $imagem = $_FILES['imagem'];
            
                $upload->Image($imagem);
                
                echo '<pre>';
                var_dump($upload);
                echo '</pre>';
            endif;
        ?>
        
        <form action="" name="fileForm" method="post" enctype="multipart/form-data">
            <label>
                <input type="file" name="imagem">
            </label>
            <input type="submit" name="sendImage" value="Enviar arquivo">
        </form>
    </body>
</html>
