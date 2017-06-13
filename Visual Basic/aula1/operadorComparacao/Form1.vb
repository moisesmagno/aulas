Public Class Form1
    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim idade As Integer = 29
        Dim input As Integer

        Try
            input = txtInput.Text

            If idade = input Then
                MessageBox.Show("Você acertou a idade do Moisés", "Idade")
            Else
                MessageBox.Show("Não acertou a idade do Moisés", "Idade")
            End If

        Catch ex As Exception
            Exit Sub
        End Try
    End Sub
End Class
