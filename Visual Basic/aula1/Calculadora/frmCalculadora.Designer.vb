<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmCalculadora
    Inherits System.Windows.Forms.Form

    'Descartar substituições de formulário para limpar a lista de componentes.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Exigido pelo Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'OBSERVAÇÃO: o procedimento a seguir é exigido pelo Windows Form Designer
    'Pode ser modificado usando o Windows Form Designer.  
    'Não o modifique usando o editor de códigos.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.txtVisor = New System.Windows.Forms.TextBox()
        Me.grpNumeros = New System.Windows.Forms.GroupBox()
        Me.btn7 = New System.Windows.Forms.Button()
        Me.btn8 = New System.Windows.Forms.Button()
        Me.btn9 = New System.Windows.Forms.Button()
        Me.btn6 = New System.Windows.Forms.Button()
        Me.btn5 = New System.Windows.Forms.Button()
        Me.btn4 = New System.Windows.Forms.Button()
        Me.btn3 = New System.Windows.Forms.Button()
        Me.btn2 = New System.Windows.Forms.Button()
        Me.btn1 = New System.Windows.Forms.Button()
        Me.btn0 = New System.Windows.Forms.Button()
        Me.btnVirgula = New System.Windows.Forms.Button()
        Me.btnSoma = New System.Windows.Forms.Button()
        Me.btnDivisao = New System.Windows.Forms.Button()
        Me.btnMultiplicar = New System.Windows.Forms.Button()
        Me.btnSubstrair = New System.Windows.Forms.Button()
        Me.btnIgual = New System.Windows.Forms.Button()
        Me.btnClear = New System.Windows.Forms.Button()
        Me.grxOperadores = New System.Windows.Forms.GroupBox()
        Me.grpNumeros.SuspendLayout()
        Me.grxOperadores.SuspendLayout()
        Me.SuspendLayout()
        '
        'txtVisor
        '
        Me.txtVisor.Location = New System.Drawing.Point(12, 12)
        Me.txtVisor.Name = "txtVisor"
        Me.txtVisor.Size = New System.Drawing.Size(402, 20)
        Me.txtVisor.TabIndex = 0
        '
        'grpNumeros
        '
        Me.grpNumeros.Controls.Add(Me.btnVirgula)
        Me.grpNumeros.Controls.Add(Me.btn3)
        Me.grpNumeros.Controls.Add(Me.btn2)
        Me.grpNumeros.Controls.Add(Me.btn1)
        Me.grpNumeros.Controls.Add(Me.btn6)
        Me.grpNumeros.Controls.Add(Me.btn5)
        Me.grpNumeros.Controls.Add(Me.btn4)
        Me.grpNumeros.Controls.Add(Me.btn9)
        Me.grpNumeros.Controls.Add(Me.btn8)
        Me.grpNumeros.Controls.Add(Me.btn7)
        Me.grpNumeros.Location = New System.Drawing.Point(12, 49)
        Me.grpNumeros.Name = "grpNumeros"
        Me.grpNumeros.Size = New System.Drawing.Size(227, 270)
        Me.grpNumeros.TabIndex = 1
        Me.grpNumeros.TabStop = False
        Me.grpNumeros.Text = "Valores"
        '
        'btn7
        '
        Me.btn7.Location = New System.Drawing.Point(28, 29)
        Me.btn7.Name = "btn7"
        Me.btn7.Size = New System.Drawing.Size(50, 50)
        Me.btn7.TabIndex = 0
        Me.btn7.Text = "7"
        Me.btn7.UseVisualStyleBackColor = True
        '
        'btn8
        '
        Me.btn8.Location = New System.Drawing.Point(84, 29)
        Me.btn8.Name = "btn8"
        Me.btn8.Size = New System.Drawing.Size(50, 50)
        Me.btn8.TabIndex = 1
        Me.btn8.Text = "8"
        Me.btn8.UseVisualStyleBackColor = True
        '
        'btn9
        '
        Me.btn9.Location = New System.Drawing.Point(140, 29)
        Me.btn9.Name = "btn9"
        Me.btn9.Size = New System.Drawing.Size(50, 50)
        Me.btn9.TabIndex = 2
        Me.btn9.Text = "9"
        Me.btn9.UseVisualStyleBackColor = True
        '
        'btn6
        '
        Me.btn6.Location = New System.Drawing.Point(140, 85)
        Me.btn6.Name = "btn6"
        Me.btn6.Size = New System.Drawing.Size(50, 50)
        Me.btn6.TabIndex = 5
        Me.btn6.Text = "6"
        Me.btn6.UseVisualStyleBackColor = True
        '
        'btn5
        '
        Me.btn5.Location = New System.Drawing.Point(84, 85)
        Me.btn5.Name = "btn5"
        Me.btn5.Size = New System.Drawing.Size(50, 50)
        Me.btn5.TabIndex = 4
        Me.btn5.Text = "5"
        Me.btn5.UseVisualStyleBackColor = True
        '
        'btn4
        '
        Me.btn4.Location = New System.Drawing.Point(28, 85)
        Me.btn4.Name = "btn4"
        Me.btn4.Size = New System.Drawing.Size(50, 50)
        Me.btn4.TabIndex = 3
        Me.btn4.Text = "4"
        Me.btn4.UseVisualStyleBackColor = True
        '
        'btn3
        '
        Me.btn3.Location = New System.Drawing.Point(140, 141)
        Me.btn3.Name = "btn3"
        Me.btn3.Size = New System.Drawing.Size(50, 50)
        Me.btn3.TabIndex = 8
        Me.btn3.Text = "3"
        Me.btn3.UseVisualStyleBackColor = True
        '
        'btn2
        '
        Me.btn2.Location = New System.Drawing.Point(84, 141)
        Me.btn2.Name = "btn2"
        Me.btn2.Size = New System.Drawing.Size(50, 50)
        Me.btn2.TabIndex = 7
        Me.btn2.Text = "2"
        Me.btn2.UseVisualStyleBackColor = True
        '
        'btn1
        '
        Me.btn1.Location = New System.Drawing.Point(28, 141)
        Me.btn1.Name = "btn1"
        Me.btn1.Size = New System.Drawing.Size(50, 50)
        Me.btn1.TabIndex = 6
        Me.btn1.Text = "1"
        Me.btn1.UseVisualStyleBackColor = True
        '
        'btn0
        '
        Me.btn0.Location = New System.Drawing.Point(40, 246)
        Me.btn0.Name = "btn0"
        Me.btn0.Size = New System.Drawing.Size(106, 50)
        Me.btn0.TabIndex = 9
        Me.btn0.Text = "0"
        Me.btn0.UseVisualStyleBackColor = True
        '
        'btnVirgula
        '
        Me.btnVirgula.Location = New System.Drawing.Point(140, 197)
        Me.btnVirgula.Name = "btnVirgula"
        Me.btnVirgula.Size = New System.Drawing.Size(50, 50)
        Me.btnVirgula.TabIndex = 9
        Me.btnVirgula.Text = ","
        Me.btnVirgula.UseVisualStyleBackColor = True
        '
        'btnSoma
        '
        Me.btnSoma.Location = New System.Drawing.Point(32, 29)
        Me.btnSoma.Name = "btnSoma"
        Me.btnSoma.Size = New System.Drawing.Size(50, 50)
        Me.btnSoma.TabIndex = 10
        Me.btnSoma.Text = "+"
        Me.btnSoma.UseVisualStyleBackColor = True
        '
        'btnDivisao
        '
        Me.btnDivisao.Location = New System.Drawing.Point(88, 85)
        Me.btnDivisao.Name = "btnDivisao"
        Me.btnDivisao.Size = New System.Drawing.Size(50, 50)
        Me.btnDivisao.TabIndex = 11
        Me.btnDivisao.Text = "/"
        Me.btnDivisao.UseVisualStyleBackColor = True
        '
        'btnMultiplicar
        '
        Me.btnMultiplicar.Location = New System.Drawing.Point(32, 85)
        Me.btnMultiplicar.Name = "btnMultiplicar"
        Me.btnMultiplicar.Size = New System.Drawing.Size(50, 50)
        Me.btnMultiplicar.TabIndex = 12
        Me.btnMultiplicar.Text = "*"
        Me.btnMultiplicar.UseVisualStyleBackColor = True
        '
        'btnSubstrair
        '
        Me.btnSubstrair.Location = New System.Drawing.Point(88, 29)
        Me.btnSubstrair.Name = "btnSubstrair"
        Me.btnSubstrair.Size = New System.Drawing.Size(50, 50)
        Me.btnSubstrair.TabIndex = 13
        Me.btnSubstrair.Text = "-"
        Me.btnSubstrair.UseVisualStyleBackColor = True
        '
        'btnIgual
        '
        Me.btnIgual.Location = New System.Drawing.Point(32, 141)
        Me.btnIgual.Name = "btnIgual"
        Me.btnIgual.Size = New System.Drawing.Size(106, 50)
        Me.btnIgual.TabIndex = 14
        Me.btnIgual.Text = "="
        Me.btnIgual.UseVisualStyleBackColor = True
        '
        'btnClear
        '
        Me.btnClear.Location = New System.Drawing.Point(32, 197)
        Me.btnClear.Name = "btnClear"
        Me.btnClear.Size = New System.Drawing.Size(106, 50)
        Me.btnClear.TabIndex = 15
        Me.btnClear.Text = "Clear"
        Me.btnClear.UseVisualStyleBackColor = True
        '
        'grxOperadores
        '
        Me.grxOperadores.Controls.Add(Me.btnSoma)
        Me.grxOperadores.Controls.Add(Me.btnClear)
        Me.grxOperadores.Controls.Add(Me.btnDivisao)
        Me.grxOperadores.Controls.Add(Me.btnIgual)
        Me.grxOperadores.Controls.Add(Me.btnMultiplicar)
        Me.grxOperadores.Controls.Add(Me.btnSubstrair)
        Me.grxOperadores.Location = New System.Drawing.Point(245, 49)
        Me.grxOperadores.Name = "grxOperadores"
        Me.grxOperadores.Size = New System.Drawing.Size(169, 270)
        Me.grxOperadores.TabIndex = 16
        Me.grxOperadores.TabStop = False
        Me.grxOperadores.Text = "Operadores"
        '
        'frmCalculadora
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(427, 331)
        Me.Controls.Add(Me.grxOperadores)
        Me.Controls.Add(Me.btn0)
        Me.Controls.Add(Me.grpNumeros)
        Me.Controls.Add(Me.txtVisor)
        Me.Name = "frmCalculadora"
        Me.Text = "Calculadora"
        Me.grpNumeros.ResumeLayout(False)
        Me.grxOperadores.ResumeLayout(False)
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents txtVisor As TextBox
    Friend WithEvents grpNumeros As GroupBox
    Friend WithEvents btnVirgula As Button
    Friend WithEvents btn3 As Button
    Friend WithEvents btn2 As Button
    Friend WithEvents btn1 As Button
    Friend WithEvents btn6 As Button
    Friend WithEvents btn5 As Button
    Friend WithEvents btn4 As Button
    Friend WithEvents btn9 As Button
    Friend WithEvents btn8 As Button
    Friend WithEvents btn7 As Button
    Friend WithEvents btn0 As Button
    Friend WithEvents btnSoma As Button
    Friend WithEvents btnDivisao As Button
    Friend WithEvents btnMultiplicar As Button
    Friend WithEvents btnSubstrair As Button
    Friend WithEvents btnIgual As Button
    Friend WithEvents btnClear As Button
    Friend WithEvents grxOperadores As GroupBox
End Class
