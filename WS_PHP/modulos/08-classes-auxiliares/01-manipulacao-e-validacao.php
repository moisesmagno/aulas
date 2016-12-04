<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>WS PHP Helpers - Manipulação e validação</title>
    </head>
    <body>
        <?php
            require('./_app/Config.inc.php');
            
            //Valida e-mail
            $email = 'moisesmagno@gmail.com';
            if(Check::Email($email)){
                echo "E-mail válido! <hr>";
            }else{
                echo "E-mail inválido! <hr>";
            }
            
            
            //Transforma uma string em url amigável
            $nome = 'Moisés Salvador Escurra Aguilar';
            echo Check::Name($nome)."<hr>";
            
            
            //Formata a data
            $data = '22/11/1987 11:45:00';
            $data = '22/11/1987';
            echo Check::Data($data)."<hr>";
            
            //Limita quantidade de palavras.
            $string = 'Estudando php na upinside treinamentos.';
            echo Check::Words($string, 3, '<small>Continue lendo...</small>').'<hr>';
            
            //Trás o id da categoria.
            echo Check::CatByName('artigos')."<br>";
            echo Check::CatByName('esportes')."<hr>";
            
            //Trás a quantidade de usuários online e exclui os que já expiraram.
            echo Check::UserOnline()."<hr>";
            
            //Checa e retorna a imagem dimensionada dinamicamente.
            echo Check::Image("google.jpg", 'Imgem da google','300','300');
            
        ?>
    </body>
</html>