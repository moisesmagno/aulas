Public Class MyCompanyInitializer
    Inherits System.Data.Entity.DropCreateDatabaseIfModelChanges(Of MyCompanyContext)

    Protected Overrides Sub Seed(context As MyCompanyContext)
        Dim produtos As New List(Of Produto)() From
            {
                New Produto() With {
                    .ID = 1,
                    .Nome = "Mouse",
                    .Preco = 50.9,
                    .DataCriacao = DateTime.Now,
                    .Descricao = "Mouse Microsoft"
                },
                New Produto() With {
                    .ID = 2,
                    .Nome = "Monitor",
                    .Preco = 760.9,
                    .DataCriacao = DateTime.Now,
                    .Descricao = "Monitor LG"
                },
                New Produto() With {
                    .ID = 3,
                    .Nome = "Teclado",
                    .Preco = 100,
                    .DataCriacao = DateTime.Now,
                    .Descricao = "Teclado Razer"
                },
                New Produto() With {
                    .ID = 4,
                    .Nome = "Impressora",
                    .Preco = 468.8,
                    .DataCriacao = DateTime.Now,
                    .Descricao = "Impressora HP"
                }
            }

        produtos.ForEach(Sub(s) context.Produtos.Add(s))

        context.SaveChanges()
    End Sub

End Class