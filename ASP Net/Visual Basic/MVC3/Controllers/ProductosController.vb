Imports System.Web.Mvc

Namespace Controllers
    Public Class ProductosController
        Inherits Controller

        'Criar um objeto do tipo List, que irá depender dos valores dos atributos do model Datos.
        Dim producto As New List(Of Datos)

        Sub New()
            Dim obj1 As New Datos()
            obj1.descripcion = "Notebooks"
            obj1.cantindad = 10
            obj1.precio = 1000.5
            producto.Add(obj1)

            Dim obj2 As New Datos()
            obj2.descripcion = "Monitores"
            obj2.cantindad = 15
            obj2.precio = 800.5
            producto.Add(obj2)

            Dim obj3 As New Datos()
            obj3.descripcion = "Teclados"
            obj3.cantindad = 7
            obj3.precio = 10.0
            producto.Add(obj3)

            Dim obj4 As New Datos()
            obj4.descripcion = "Mouses"
            obj4.cantindad = 50
            obj4.precio = 100.5
            producto.Add(obj4)

        End Sub

        ' GET: Productos
        Function MostrarProducto(id As Integer) As ViewResult
            Dim obj3 As New Datos()
            obj3 = producto(id)
            Return View(obj3)
        End Function
    End Class
End Namespace