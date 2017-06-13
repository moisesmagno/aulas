Public Class Form1
    Private Sub btnVerDados_Click(sender As Object, e As EventArgs) Handles btnVerDados.Click
        Dim idade As Integer = 29
        Dim nome As String = "Moisés"
        Dim altura As Double = 1.65
        Dim filhos As Boolean = False

        MsgBox(nome)
        MsgBox(idade)
        MsgBox(altura)
        MsgBox(filhos)
    End Sub
End Class
