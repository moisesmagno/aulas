Public Class Form1
    Private Sub btnIngresar_Click(sender As Object, e As EventArgs) Handles btnIngresar.Click
        'Declaración de edades
        Dim edades(7) As Integer

        'Adicionar datos al vector Edades
        edades(0) = 10
        edades(1) = 12
        edades(2) = 18
        edades(3) = 22
        edades(4) = 25
        edades(5) = 29
        edades(6) = 35

        Dim suma As Integer = 0
        Dim promedio As Double

        For i As Integer = 0 To 6 Step 1
            cbxEdades.Items.Add(edades(i))
            suma += edades(i)
        Next

        promedio = suma / 7
        txtPromedio.Text = promedio
    End Sub

    Private Sub btnNuevo_Click(sender As Object, e As EventArgs) Handles btnNuevo.Click
        cbxEdades.Items.Clear()
        txtPromedio.Clear()
    End Sub

    Private Sub btnSalir_Click(sender As Object, e As EventArgs) Handles btnSalir.Click
        End
    End Sub
End Class
