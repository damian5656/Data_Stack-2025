<?php
include("conexion.php"); // conexión a la base de datos

if (isset($_POST['send'])) {

    if (!empty($_POST['nombre']) && !empty($_POST['apellido']) && !empty($_POST['usuario']) &&
        !empty($_POST['correo']) && !empty($_POST['contraseña']) && !empty($_POST['rol'])) {

        $nombre = mysqli_real_escape_string($conn, trim($_POST['nombre']));
        $apellido = mysqli_real_escape_string($conn, trim($_POST['apellido']));
        $usuario = mysqli_real_escape_string($conn, trim($_POST['usuario']));
        $correo = mysqli_real_escape_string($conn, trim($_POST['correo']));
        $rol_nombre = mysqli_real_escape_string($conn, trim($_POST['rol']));
        $password = trim($_POST['contraseña']);
        $codigo_ingresado = isset($_POST['codigoVerificacion']) ? trim($_POST['codigoVerificacion']) : null;

        
        $query_rol = "SELECT ID_Rol FROM rol WHERE Nombre_Rol = '$rol_nombre' LIMIT 1";
        $resultado_rol = mysqli_query($conn, $query_rol);

        if (!$resultado_rol || mysqli_num_rows($resultado_rol) == 0) {
            echo "<h3 class='error'>Rol inválido</h3>";
            exit();
        }

        $fila_rol = mysqli_fetch_assoc($resultado_rol);
        $id_rol = $fila_rol['ID_Rol'];

        // Verificar código si es administrador
            if (strtolower($rol_nombre) === 'administrador') {
            $consulta_codigo = "SELECT codigo FROM codigos_admin WHERE codigo = '$codigo_ingresado' LIMIT 1";
            $resultado_codigo = mysqli_query($conn, $consulta_codigo);

            if (!$resultado_codigo || mysqli_num_rows($resultado_codigo) == 0) {
                echo "<h3 class='error'>Código de verificación incorrecto</h3>";
                exit();
            }
        }

        // Hashear la contraseña
        $password_hash = password_hash($password, PASSWORD_DEFAULT);

        // Insertar usuario con ID_Rol
        $consulta = "INSERT INTO usuario (nombre, apellido, documento, contrasena, correo, ID_Rol)
                     VALUES ('$nombre', '$apellido', '$usuario', '$password_hash', '$correo', '$id_rol')";
        $resultado = mysqli_query($conn, $consulta);

        if ($resultado) {
            echo "<h3 class='success'>Registro completado</h3>";
        } else {
            echo "<h3 class='error'>Error al registrar: " . mysqli_error($conn) . "</h3>";
        }

    } else {
        echo "<h3 class='error'>Completa todos los campos</h3>";
    }
}
?>
