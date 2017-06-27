Imports System.Web.Mvc

Namespace Controllers
    Public Class ProductosController
        Inherits Controller

        ' GET: Productos
        Function Index() As ActionResult
            Return View()
        End Function

        Function Buscar() As ActionResult
            'RouteData.values é tipo o $_Get['parametro'] do php.
            Dim nombreProducto As String = RouteData.Values("nombreProducto").ToString

            'Transforma o parâmetro pasado a html'
            nombreProducto = Server.HtmlEncode(nombreProducto)
            Dim resultado As String = String.Empty

            Select Case nombreProducto
                Case "pc"
                    resultado = "Disponível 4 produtos"
                Case "mouse"
                    resultado = "Disponível 2 produtos"
                Case Else
                    resultado = String.Format("O Produto {0}, não está disponível!", nombreProducto)
            End Select

            Return Content("<p>" & resultado & "</p>")
        End Function
    End Class
End Namespace