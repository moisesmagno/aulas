@Code
    ViewData("Title") = "Detalhes"

    Dim produto = DirectCast(Model, PrimeiroMVC.Produto)
End Code

<h2>Detalhes</h2>

<fielset>
    <legent>Produtos</legent>
    <div>
        <b>ID: </b>@produto.ID.ToString()
    </div>
    <div>
        <b>Nome: </b>@produto.Nome
    </div>
    <div>
        <b>Descrição: </b>@produto.Descricao
    </div>
</fielset>

