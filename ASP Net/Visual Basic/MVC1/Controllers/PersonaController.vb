Imports System.Web.Mvc

Namespace Controllers
    Public Class PersonaController
        Inherits Controller

        Function Index() As ActionResult
            Return View()
        End Function

        ' GET: Persona
        Function Persona() As ActionResult

            Dim objPersona As New Persona()
            objPersona.Nombre = Request.Form("nombres").ToString
            objPersona.Apellido = Request.Form("apellidos").ToString
            objPersona.Edad = Convert.ToInt32(Request.Form("edad"))

            Return View(objPersona)
        End Function

    End Class
End Namespace