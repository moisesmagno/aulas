Public Class frmGastosDiarios
    Private Sub addCantidadDias_Click(sender As Object, e As EventArgs) Handles addCantidadDias.Click
        'Declaración de variables
        Dim vGastos() As Double
        Dim gasto As Double
        Dim totalGasto As Double
        Dim diaMayor As Integer
        Dim gastoMayor As Double
        Dim cantindadDias As Integer

        'Inicializa variábles
        totalGasto = 0
        diaMayor = 1
        gastoMayor = 0

        'Leer gastos
        cantindadDias = Val(txtCantidadDias.Text)

        'Cambiar el tamaño de los indices que tendrá el vector
        ReDim Preserve vGastos(cantindadDias)

        For i As Integer = 0 To (cantindadDias - 1) Step 1
            gasto = InputBox("Ingrese el gasto del día " & (i + 1), "Gastos")
            vGastos(i) = gasto
        Next

        For j As Integer = 0 To (cantindadDias - 1) Step 1
            'Evaluamos el gastro mayor
            If (vGastos(j) > gastoMayor) Then
                gastoMayor = vGastos(j)
                diaMayor = j + 1
            End If

            cbxGastos.Items.Add("Día: " & (j + 1) & " Total: " & vGastos(j))
            totalGasto += vGastos(j)
        Next

        'Salida de información
        txtTotalGastos.Text = totalGasto
        txtGastoMayor.Text = gastoMayor
        txtDiaMayor.Text = "Dia: " & diaMayor

    End Sub
End Class