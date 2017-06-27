Imports System.Web.Mvc

Namespace Controllers
    Public Class ProdutoController
        Inherits Controller

        ' GET: Produto
        Public Function Index() As ActionResult
            Dim repository As New ProdutoRepository()
            Return View(repository.ObterProdutos)
        End Function

        'GET: /Produto/id
        Public Function Detalhes(id As Integer) As ActionResult
            Dim repository As New ProdutoRepository()
            Return View(repository.ObterProdutos(id))
        End Function
    End Class
End Namespace