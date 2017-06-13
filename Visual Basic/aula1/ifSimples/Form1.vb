Public Class Form1
    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim idade As Integer = 27
        If idade = 27 Then
            MessageBox.Show("A idade de Moisés é " & idade.ToString, "Idade do Moisés")
        ElseIf idade = 29 Then
            MessageBox.Show("A idade de Moisés é " & idade.ToString, "Idade do Moisés")
        Else
            MessageBox.Show("Você não acertou a idade do Moisés!", "Idade do Moisés")
        End If

    End Sub
End Class
