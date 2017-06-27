Public Class ProdutoRepository
    Public Function ObterProdutos() As List(Of Produto)
        Using db As New MyCompanyContext()
            Return db.Produtos.ToList()
        End Using
    End Function

    Public Function ObterProduto(id As Integer) As Produto
        Using db As New MyCompanyContext()
            Dim model As Produto = db.Produtos.Find(id)
            Return model
        End Using
    End Function
End Class
