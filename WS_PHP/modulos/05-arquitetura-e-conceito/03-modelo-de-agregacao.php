<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>WS PHP - Modelo de Agregação</title>
    </head>
    <body>
        <?php
        require('./inc/Config.inc.php');

        $robson = new AssociacaoCliente('Robson', 'campus@upinside.com.br');

        $prophp = new AgregacaoProduto('20', 'Pro PHP', 334.90);
        $wsphp = new AgregacaoProduto('21', 'WS PHP', 289.90);
        $wshtml = new AgregacaoProduto('22', 'WS HTML5', 289.90);

        $outrocurso = new stdClass();
        $outrocurso->Produto = '23';
        $outrocurso->Nome = 'Curso de jQuery';
        $outrocurso->Valor = 400;

        $carrinho = new AgregacaoCarrinho($robson);

        $carrinho->Add($prophp);
        $carrinho->Add($wsphp);
        $carrinho->Add($wshtml);

        $carrinho->Remove($wsphp);

        //$carrinho->Add($outrocurso);


        var_dump($carrinho);
        echo "<hr>";
        var_dump($robson, $prophp, $outrocurso);
        ?>
    </body>
</html>
