@ModelType MVC3.Datos

@Code
    Layout = Nothing
End Code

<!DOCTYPE html>

<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>MostrarProducto</title>
</head>
<body>
    <div> 
        <h3>Productos</h3>
        <label>Descripción: @Model.descripcion</label><br>
        <label>Descripción: @Model.cantindad</label><br>
        <label>Descripción: @Model.precio</label><br>
    </div>
</body>
</html>
