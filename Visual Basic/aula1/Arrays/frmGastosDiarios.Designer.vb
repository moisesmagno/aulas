<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmGastosDiarios
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
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.GroupBox2 = New System.Windows.Forms.GroupBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.txtCantidadDias = New System.Windows.Forms.TextBox()
        Me.addCantidadDias = New System.Windows.Forms.Button()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.txtDiaMayor = New System.Windows.Forms.TextBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.txtGastoMayor = New System.Windows.Forms.TextBox()
        Me.cbxGastos = New System.Windows.Forms.ComboBox()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.txtTotalGastos = New System.Windows.Forms.TextBox()
        Me.btnSalir = New System.Windows.Forms.Button()
        Me.btnNuevo = New System.Windows.Forms.Button()
        Me.GroupBox1.SuspendLayout()
        Me.GroupBox2.SuspendLayout()
        Me.SuspendLayout()
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.addCantidadDias)
        Me.GroupBox1.Controls.Add(Me.txtCantidadDias)
        Me.GroupBox1.Controls.Add(Me.Label1)
        Me.GroupBox1.Location = New System.Drawing.Point(12, 12)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(302, 100)
        Me.GroupBox1.TabIndex = 0
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Ingresos datos"
        '
        'GroupBox2
        '
        Me.GroupBox2.Controls.Add(Me.btnNuevo)
        Me.GroupBox2.Controls.Add(Me.btnSalir)
        Me.GroupBox2.Controls.Add(Me.txtTotalGastos)
        Me.GroupBox2.Controls.Add(Me.cbxGastos)
        Me.GroupBox2.Controls.Add(Me.Label4)
        Me.GroupBox2.Controls.Add(Me.txtGastoMayor)
        Me.GroupBox2.Controls.Add(Me.txtDiaMayor)
        Me.GroupBox2.Controls.Add(Me.Label3)
        Me.GroupBox2.Controls.Add(Me.Label2)
        Me.GroupBox2.Location = New System.Drawing.Point(12, 131)
        Me.GroupBox2.Name = "GroupBox2"
        Me.GroupBox2.Size = New System.Drawing.Size(302, 198)
        Me.GroupBox2.TabIndex = 1
        Me.GroupBox2.TabStop = False
        Me.GroupBox2.Text = "Resultados"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(17, 46)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(89, 13)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Cantidad de dias:"
        '
        'txtCantidadDias
        '
        Me.txtCantidadDias.Location = New System.Drawing.Point(107, 43)
        Me.txtCantidadDias.Name = "txtCantidadDias"
        Me.txtCantidadDias.Size = New System.Drawing.Size(94, 20)
        Me.txtCantidadDias.TabIndex = 1
        '
        'addCantidadDias
        '
        Me.addCantidadDias.Location = New System.Drawing.Point(209, 40)
        Me.addCantidadDias.Name = "addCantidadDias"
        Me.addCantidadDias.Size = New System.Drawing.Size(75, 23)
        Me.addCantidadDias.TabIndex = 2
        Me.addCantidadDias.Text = "Adicionar"
        Me.addCantidadDias.UseVisualStyleBackColor = True
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(17, 72)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(67, 13)
        Me.Label2.TabIndex = 3
        Me.Label2.Text = "Total Gastos"
        '
        'txtDiaMayor
        '
        Me.txtDiaMayor.Location = New System.Drawing.Point(109, 103)
        Me.txtDiaMayor.Name = "txtDiaMayor"
        Me.txtDiaMayor.Size = New System.Drawing.Size(79, 20)
        Me.txtDiaMayor.TabIndex = 6
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(17, 106)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(72, 13)
        Me.Label3.TabIndex = 5
        Me.Label3.Text = "Mayor Gastos"
        '
        'txtGastoMayor
        '
        Me.txtGastoMayor.Location = New System.Drawing.Point(206, 103)
        Me.txtGastoMayor.Name = "txtGastoMayor"
        Me.txtGastoMayor.Size = New System.Drawing.Size(78, 20)
        Me.txtGastoMayor.TabIndex = 7
        '
        'cbxGastos
        '
        Me.cbxGastos.FormattingEnabled = True
        Me.cbxGastos.Location = New System.Drawing.Point(109, 32)
        Me.cbxGastos.Name = "cbxGastos"
        Me.cbxGastos.Size = New System.Drawing.Size(175, 21)
        Me.cbxGastos.TabIndex = 10
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(17, 35)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(40, 13)
        Me.Label4.TabIndex = 9
        Me.Label4.Text = "Gastos"
        '
        'txtTotalGastos
        '
        Me.txtTotalGastos.Location = New System.Drawing.Point(109, 69)
        Me.txtTotalGastos.Name = "txtTotalGastos"
        Me.txtTotalGastos.Size = New System.Drawing.Size(175, 20)
        Me.txtTotalGastos.TabIndex = 11
        '
        'btnSalir
        '
        Me.btnSalir.Location = New System.Drawing.Point(209, 156)
        Me.btnSalir.Name = "btnSalir"
        Me.btnSalir.Size = New System.Drawing.Size(75, 23)
        Me.btnSalir.TabIndex = 3
        Me.btnSalir.Text = "Salir"
        Me.btnSalir.UseVisualStyleBackColor = True
        '
        'btnNuevo
        '
        Me.btnNuevo.Location = New System.Drawing.Point(113, 156)
        Me.btnNuevo.Name = "btnNuevo"
        Me.btnNuevo.Size = New System.Drawing.Size(75, 23)
        Me.btnNuevo.TabIndex = 12
        Me.btnNuevo.Text = "Nuevo"
        Me.btnNuevo.UseVisualStyleBackColor = True
        '
        'frmGastosDiarios
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(324, 341)
        Me.Controls.Add(Me.GroupBox2)
        Me.Controls.Add(Me.GroupBox1)
        Me.Name = "frmGastosDiarios"
        Me.Text = "Gastos diários"
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.GroupBox2.ResumeLayout(False)
        Me.GroupBox2.PerformLayout()
        Me.ResumeLayout(False)

    End Sub

    Friend WithEvents GroupBox1 As GroupBox
    Friend WithEvents addCantidadDias As Button
    Friend WithEvents txtCantidadDias As TextBox
    Friend WithEvents Label1 As Label
    Friend WithEvents GroupBox2 As GroupBox
    Friend WithEvents btnNuevo As Button
    Friend WithEvents btnSalir As Button
    Friend WithEvents txtTotalGastos As TextBox
    Friend WithEvents cbxGastos As ComboBox
    Friend WithEvents Label4 As Label
    Friend WithEvents txtGastoMayor As TextBox
    Friend WithEvents txtDiaMayor As TextBox
    Friend WithEvents Label3 As Label
    Friend WithEvents Label2 As Label
End Class
