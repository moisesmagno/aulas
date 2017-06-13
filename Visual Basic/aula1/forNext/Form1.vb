Public Class Form1
    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        'Declarando o contador que será usado no For..Next
        Dim contador As Integer

        'Limpa a lista simples e a lista de checkboxs
        limpaLista()
        limpaCheckBox()

        For contador = 1 To 20
            lbxLista.Items.Add("Número " & contador.ToString)
            cbxLista.Items.Add("Número " & contador.ToString)
        Next

    End Sub

    'Limpa a lista simples
    Private Sub limpaLista()
        lbxLista.Items.Clear()
    End Sub

    'LImpa a lista de checkbox
    Private Sub limpaCheckBox()
        cbxLista.Items.Clear()
    End Sub
End Class
