@Code
    ViewData("Title") = "Index"

    Dim produtos = DirectCast(Me.Model, List(Of PrimeiroMVC.Produto))
End Code

<h2>Index</h2>

<table>
    <tr>
        <th>
            Nome
        </th>
        <th>
            Preço
        </th> 
    </tr>

    @For Each item In produtos
        @<tr>
            <td>
                @Html.DisplayFor(Function(modelItem) item.Nome)
            </td>
            <td>
                @Html.DisplayFor(Function(modelItem) item.Preco)
            </td>
        </tr>   
    Next

</table>