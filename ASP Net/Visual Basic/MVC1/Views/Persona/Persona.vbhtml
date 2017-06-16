@ModelType MVC1.Persona

@Code
    Layout = Nothing
End Code

<!DOCTYPE html>

<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>Persona</title>
</head>
<body>
    <div> 
        <label>Mi nombre és: @Model.Nombre <br /></label>
        <label>Mi apellido és: @Model.Apellido <br /></label>
        <label>Mi edad és: @Model.Edad <br /></label>
    </div>
</body>
</html>
