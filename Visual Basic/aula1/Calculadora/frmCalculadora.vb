Public Class frmCalculadora

    Dim variavel1 As Double
    Dim variavel2 As Double
    Dim resultado As Double
    Dim numero As String
    Dim operador As String

    Private Sub frmCalculadora_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        variavel1 = 0
        variavel2 = 0
        resultado = 0
        numero = ""
        operador = ""
    End Sub

    Private Sub btn9_Click(sender As Object, e As EventArgs) Handles btn9.Click
        numero += btn9.Text
        txtVisor.Text = numero
    End Sub

    Private Sub btn8_Click(sender As Object, e As EventArgs) Handles btn8.Click
        numero += btn8.Text
        txtVisor.Text = numero
    End Sub

    Private Sub btn7_Click(sender As Object, e As EventArgs) Handles btn7.Click
        numero += btn7.Text
        txtVisor.Text = numero
    End Sub

    Private Sub btn6_Click(sender As Object, e As EventArgs) Handles btn6.Click
        numero += btn6.Text
        txtVisor.Text = numero
    End Sub

    Private Sub btn5_Click(sender As Object, e As EventArgs) Handles btn5.Click
        numero += btn5.Text
        txtVisor.Text = numero
    End Sub

    Private Sub btn4_Click(sender As Object, e As EventArgs) Handles btn4.Click
        numero += btn4.Text
        txtVisor.Text = numero
    End Sub

    Private Sub btn3_Click(sender As Object, e As EventArgs) Handles btn3.Click
        numero += btn3.Text
        txtVisor.Text = numero
    End Sub

    Private Sub btn2_Click(sender As Object, e As EventArgs) Handles btn2.Click
        numero += btn2.Text
        txtVisor.Text = numero
    End Sub

    Private Sub btn1_Click(sender As Object, e As EventArgs) Handles btn1.Click
        numero += btn1.Text
        txtVisor.Text = numero
    End Sub

    Private Sub btn0_Click(sender As Object, e As EventArgs) Handles btn0.Click
        numero += btn0.Text
        txtVisor.Text = numero
    End Sub

    Private Sub btnVirgula_Click(sender As Object, e As EventArgs) Handles btnVirgula.Click
        numero += btnVirgula.Text
        txtVisor.Text = numero
    End Sub

    Private Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        txtVisor.Text = ""
    End Sub

    Private Sub btnSoma_Click(sender As Object, e As EventArgs) Handles btnSoma.Click
        If txtVisor.Text <> "" Then

            'Convertendo valores String em double
            variavel1 = System.Convert.ToDouble(numero)

            operador = "+"
            numero = ""
        End If
    End Sub

    Private Sub btnIgual_Click(sender As Object, e As EventArgs) Handles btnIgual.Click
        Dim valores As String

        'Convertendo valores string em double
        variavel2 = System.Convert.ToDouble(numero)

        Select Case operador
            Case "+"
                resultado = variavel1 + variavel2

            Case "*"
                resultado = variavel1 * variavel2

            Case "/"
                resultado = variavel1 / variavel2

            Case "-"
                resultado = variavel1 - variavel2

        End Select

        txtVisor.Text = resultado
        numero = ""
    End Sub

    Private Sub btnSubstrair_Click(sender As Object, e As EventArgs) Handles btnSubstrair.Click
        'Convertendo valores String em double
        variavel1 = System.Convert.ToDouble(numero)

        operador = "-"
        numero = ""
    End Sub

    Private Sub btnMultiplicar_Click(sender As Object, e As EventArgs) Handles btnMultiplicar.Click
        'Convertendo valores String em double
        variavel1 = System.Convert.ToDouble(numero)

        operador = "*"
        numero = ""
    End Sub

    Private Sub btnDivisao_Click(sender As Object, e As EventArgs) Handles btnDivisao.Click
        'Convertendo valores String em double
        variavel1 = System.Convert.ToDouble(numero)

        operador = "/"
        numero = ""
    End Sub
End Class
