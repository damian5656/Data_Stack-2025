

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="diseño.css">
</head>
<body><!--Contiene todo lo que se muestra en nuestra Pagina-->
<div class="login-container"><!--Se crea un Div con la clase login-container para poder identificarlo 
    en el css ponerle un estilo luego -->
    <form method="POST" action="inicio.php" class="login-form">
        <!-- Logo superior con la clase Logo para agregarle luego un estilo y diseño -->
        <img src="../Imagenes/logo.png" alt="Logo" class="logo">

        <!-- Inputs -->
        <label>   <!-- Los labels son etiquetas de html para formularios, sirven para identificar campos 
                    de una interfaz de usuario -->
            <input type="text" name="usuario" placeholder="Documento" required><!-- Inputs o Entradas en 
                         español, sirven para que el usario ingrese informacion -->
        </label>
        <label>
            <input type="password" name="contrasena" placeholder="Contraseña" required>
        </label>

        <!-- Botón azul con mismo ancho que inputs -->
        <button type="submit" name="login" class="btn">Ingresar</button>

        <!-- Enlace para ingresar como invitado -->
        <div class="forgot-password">
            <a href="invitado.php">Ingresar como invitado</a>
        </div>

        <!--Si existe un fallo,osea la variable error, mostrara un mensaje proveniente de un archivo 
                            exterior que en este caso es inicio.php  -->
        <?php if(isset($error)) echo "<p class='login-error'>$error</p>"; ?>
    </form>
</div>
</body>
</html>
