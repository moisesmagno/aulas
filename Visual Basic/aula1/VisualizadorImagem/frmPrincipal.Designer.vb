<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmPrincipal
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
        Me.btnSobre = New System.Windows.Forms.Button()
        Me.SuspendLayout()
        '
        'btnSobre
        '
        Me.btnSobre.Location = New System.Drawing.Point(370, 12)
        Me.btnSobre.Name = "btnSobre"
        Me.btnSobre.Size = New System.Drawing.Size(75, 23)
        Me.btnSobre.TabIndex = 0
        Me.btnSobre.Text = "Sobre"
        Me.btnSobre.UseVisualStyleBackColor = True
        '
        'frmPrincipal
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(457, 261)
        Me.Controls.Add(Me.btnSobre)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Name = "frmPrincipal"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = " Visualizador de Imagens"
        Me.ResumeLayout(False)

    End Sub

    Friend WithEvents btnSobre As Button
End Class
