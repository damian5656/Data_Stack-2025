<?php
// index.php
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bienvenidos a OrganizaT</title>
  <link rel="stylesheet" href="css/style.css"> <!-- CSS externo -->
  <style>
    /* Reset básico */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
      background: #f4f6f9;
      color: #333;
      min-height: 100vh;
      margin: 0;
    }

    /* Header fijo */
    header {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      background-color: #2c3e50;
      color: white;
      padding: 15px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      z-index: 1000;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    header .logo a {
      color: white;
      text-decoration: none;
      font-size: 1.5rem;
      font-weight: bold;
    }

    nav ul {
      list-style: none;
      display: flex;
      gap: 20px;
    }

    nav ul li a {
      color: white;
      text-decoration: none;
      padding: 5px 10px;
      border-radius: 5px;
      transition: background 0.3s;
    }

    nav ul li a:hover {
      background-color: #34495e;
    }

    /* Contenedor principal */
    .container {
      max-width: 800px;
      margin: 130px auto 50px; /* espacio para header */
      background: #fff;
      padding: 40px 30px;
      border-radius: 12px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.1);
      text-align: center;
      animation: fadeIn 0.6s ease;
    }

    h1 {
      font-size: 2rem;
      color: #2c3e50;
      margin-bottom: 20px;
    }

    p {
      font-size: 1.1rem;
      color: #555;
      margin-bottom: 25px;
      line-height: 1.6;
    }

    /* Botones */
    .btn {
      display: inline-block;
      background: #2980b9;
      color: white;
      text-decoration: none;
      padding: 12px 25px;
      border-radius: 8px;
      font-weight: 600;
      margin: 10px;
      transition: background 0.3s;
    }

    .btn:hover {
      background: #1f6391;
    }

    /* Animación de entrada */
    @keyframes fadeIn {
      from {
        opacity: 0;
        transform: translateY(15px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    /* Responsive */
    @media (max-width: 600px) {
      .container {
        padding: 30px 20px;
        margin: 120px 20px 30px;
      }

      h1 {
        font-size: 1.6rem;
      }

      p {
        font-size: 1rem;
      }

      nav ul {
        gap: 10px;
      }
    }
  </style>
</head>
<body>

  <!-- Header -->
  <header>
    <div class="logo">
      <a href="index.php">OrganizaT</a>
    </div>
    <nav>
      <ul>
        <li><a href="IniciarSesion/invitado.php">Entrar</a></li>
        <li><a href="IniciarSesion/iniciarsesion.php">Iniciar Sesión</a></li>
        <li><a href="Crear-Admin/login.php">Crear Administrador</a></li>
      </ul>
    </nav>
  </header>

  <!-- Contenido principal -->
  <div class="container">
    <h1>Bienvenido a OrganizaT</h1>
    <p>
      Este sitio web tiene como objetivo ayudar a administrar la Institución ITSP de manera más rápida y segura, evitando errores y redundancias. 
      Si eres un alumno o visitante, toca "Entrar". Si eres profesor o administrador, haz clic en "Iniciar Sesión". 
      Para registrarte como administrador, toca "Crear Administrador" y solicita el código al dueño del sitio.
    </p>
    
   
  </div>

</body>
</html>
