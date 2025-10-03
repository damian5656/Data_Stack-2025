
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>Login</title>
  <script src="script.js"></script>
  <link rel="stylesheet" href="estilos.css" />
</head>
<body>

  <form class="login-form" action="send.php" method="POST">
    <img src="https://i.postimg.cc/vBmRpy7D/Captura-de-pantalla-2025-07-12-212358.png" alt="Captura-de-pantalla-2025-07-12-212358"class="logo"/>
 <label>
      <input type="text" name="nombre" placeholder="Ingrese su Nombre" required />
    </label>
     <label>
      <input type="text" name="apellido" placeholder="Ingrese su apellido" required />
    </label>
    <label>
      <input type="text" name="usuario" placeholder="Documento 👤" required />
    </label>
    <label>
      <input type="email" name="correo" placeholder="Ingrese su correo ✉️" required />
    </label>
    <label>
    <input type="password" name="contraseña" placeholder="Contraseña 🔒" required />
    </label>


     <div class="input-group">
                <select id="rolSelect" name="rol" required aria-placeholder="Elige tu Rol">
                    <option value="" disabled selected hidden>Seleccione su Rol</option>
                     <option value="profesor">Profesor 👨‍🏫</option>
<option value="Auxiliar">Auxiliar 🧑‍💼</option>
<option value="Administrador"> Administrador 👨‍💻</option>
<option value="alumno">Alumno 🎓</option>

                </select>
            </div>

            <div class="input-group" id="codigo-verificacion-group" style="display:none;">
                <input type="text" id="codigoVerificacion" name="codigoVerificacion" placeholder="Ingrese codigo"/>
            </div>

      

   <button type="submit" name="send" class="btn">logearse</button>


  </form>

</body>
</html>