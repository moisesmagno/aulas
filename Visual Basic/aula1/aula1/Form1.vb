Public Class formAula1
    Private Sub btn_ver_nome_Click(sender As Object, e As EventArgs) Handles btn_ver_nome.Click
        MessageBox.Show("Olá " & txtNome.Text() & ", seja bem vindo ao curso de Visual basic." _
                        , "Mensagem de boas vindas")
    End Sub

    Private Sub btn_sair_Click(sender As Object, e As EventArgs) Handles btn_sair.Click
        Me.Close()
    End Sub
End Class
