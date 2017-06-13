Public Class Form1
    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim mensagem As String = "Seja bem vindo"
        Dim nome As String = "Moisés"

        concatenarBemVida(mensagem, nome)

    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        Dim n1 As Integer = 2
        Dim n2 As Integer = 2

        MessageBox.Show(Soma(n1, n2))

    End Sub
End Class
