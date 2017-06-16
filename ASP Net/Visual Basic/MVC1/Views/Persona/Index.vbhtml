
@Code
    Layout = Nothing
End Code

<!DOCTYPE html>

<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>Index</title>
</head>
<body>
    <div> 
        <h3>Datos personales</h3>
        <form action="Persona/Persona" method="post">
            <label>Nombres: <input type="text" name="nombres" value="" /></label><br />
            <label>Apellidos: <input type="text" name="apellidos" value="" /></label><br />
            <label>Edad: <input type="text" name="edad" value="" /></label><br />
            <input type="submit" name="enviar" value="Enviar" />
        </form>
    </div>
</body>
</html>
