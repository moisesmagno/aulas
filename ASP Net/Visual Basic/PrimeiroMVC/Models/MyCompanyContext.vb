Imports System.Data.Entity

Public Class MyCompanyContext
    Inherits DbContext

    Public Property Produtos As DbSet(Of Produto)
End Class
