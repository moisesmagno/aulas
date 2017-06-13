<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class formAula1
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
        Me.Label1 = New System.Windows.Forms.Label()
        Me.btn_ver_nome = New System.Windows.Forms.Button()
        Me.btn_sair = New System.Windows.Forms.Button()
        Me.txtNome = New System.Windows.Forms.TextBox()
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 9)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(86, 13)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Digite seu nome:"
        '
        'btn_ver_nome
        '
        Me.btn_ver_nome.Location = New System.Drawing.Point(15, 226)
        Me.btn_ver_nome.Name = "btn_ver_nome"
        Me.btn_ver_nome.Size = New System.Drawing.Size(75, 23)
        Me.btn_ver_nome.TabIndex = 1
        Me.btn_ver_nome.Text = "Ver nome"
        Me.btn_ver_nome.UseVisualStyleBackColor = True
        '
        'btn_sair
        '
        Me.btn_sair.Location = New System.Drawing.Point(197, 226)
        Me.btn_sair.Name = "btn_sair"
        Me.btn_sair.Size = New System.Drawing.Size(75, 23)
        Me.btn_sair.TabIndex = 2
        Me.btn_sair.Text = "Sair"
        Me.btn_sair.UseVisualStyleBackColor = True
        '
        'txtNome
        '
        Me.txtNome.Location = New System.Drawing.Point(15, 25)
        Me.txtNome.Name = "txtNome"
        Me.txtNome.Size = New System.Drawing.Size(257, 20)
        Me.txtNome.TabIndex = 3
        '
        'formAula1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(284, 261)
        Me.Controls.Add(Me.txtNome)
        Me.Controls.Add(Me.btn_sair)
        Me.Controls.Add(Me.btn_ver_nome)
        Me.Controls.Add(Me.Label1)
        Me.Name = "formAula1"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Aula 1"
        Me.UseWaitCursor = True
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents Label1 As Label
    Friend WithEvents btn_ver_nome As Button
    Friend WithEvents btn_sair As Button
    Friend WithEvents txtNome As TextBox
End Class
