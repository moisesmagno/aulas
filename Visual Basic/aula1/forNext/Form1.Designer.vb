<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form1
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
        Me.lbxLista = New System.Windows.Forms.ListBox()
        Me.cbxLista = New System.Windows.Forms.CheckedListBox()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.SuspendLayout()
        '
        'lbxLista
        '
        Me.lbxLista.FormattingEnabled = True
        Me.lbxLista.Location = New System.Drawing.Point(0, 0)
        Me.lbxLista.Name = "lbxLista"
        Me.lbxLista.Size = New System.Drawing.Size(214, 290)
        Me.lbxLista.TabIndex = 0
        '
        'cbxLista
        '
        Me.cbxLista.CheckOnClick = True
        Me.cbxLista.FormattingEnabled = True
        Me.cbxLista.Location = New System.Drawing.Point(248, 1)
        Me.cbxLista.Name = "cbxLista"
        Me.cbxLista.Size = New System.Drawing.Size(216, 289)
        Me.cbxLista.TabIndex = 1
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(112, 325)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(267, 39)
        Me.Button1.TabIndex = 2
        Me.Button1.Text = "Gerar Listas"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(476, 376)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.cbxLista)
        Me.Controls.Add(Me.lbxLista)
        Me.Name = "Form1"
        Me.Text = "Form1"
        Me.ResumeLayout(False)

    End Sub

    Friend WithEvents lbxLista As ListBox
    Friend WithEvents cbxLista As CheckedListBox
    Friend WithEvents Button1 As Button
End Class
