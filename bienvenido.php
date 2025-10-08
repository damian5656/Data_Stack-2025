<?php
session_start();
// Verificar sesión
if (!isset($_SESSION['usuario'])) {
    header("Location: /IniciarSesion/iniciarsesion.php");
    exit();
}
// Variables de sesión
$nombre = $_SESSION['nombre'] ?? 'Invitado';
$rol_id = $_SESSION['rol'] ?? 0;
$rol_nombre = $_SESSION['rol_nombre'] ?? 'Desconocido';
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Portal estilo CREA 2 — Portada + Foro</title>

</head>
<body>
<!-- Sidebar + Overlay -->
<?php if ($rol_id == 1): ?>
<div class="hamburger" id="hamburger" style="position:absolute;top:20px;left:20px;z-index:1100">
<span></span><span></span><span></span>
</div>
<div class="sidebar" id="sidebar">
<br><br>
<h3>Menú Admin</h3>
<a href="horarios/horarios.php">📊 Horarios</a>
<a href="/Data_Stack-2025/panel/index.php" style="color:blue;">Panel Admin</a>
<a href="#">⚙️ Configuración</a>
</div>
<div class="overlay" id="overlay"></div>
<?php endif; ?>
<!-- Header -->
<header>
<div class="container header-inner">
<div class="brand">
<div class="logo">D.S</div>
<div>
<h1>Data Stack</h1>
<p>ITSP</p>
</div>
</div>
<!-- Navegación para todos los usuarios -->
<nav class="main-nav">
<a href="horarios/ver_horarios.php" class="nav-link">Ver Horarios</a>
</nav>
<div class="user-controls">
<div class="avatar"><?php echo strtoupper(substr($nombre,0,2)); ?></div>
<span><?php echo htmlspecialchars($nombre); ?></span>
</div>
</div>
</header>
<!-- Hero -->
<section class="hero">
<div id="hero-bg" class="hero-bg"></div>
<div class="hero-grad"></div>
<div class="container hero-content" style="display:flex;flex-direction:column;justify-content:end;">
<div class="hero-card">
<h2 class="hero-title">Bienvenido/a <?php echo htmlspecialchars($nombre); ?></h2>
<p class="hero-sub">Recursos, anuncios y espacio de intercambio para la comunidad.</p>
<div id="dots" class="dots"></div>
</div>
</div>
</section>
<!-- Foro -->
<main class="container">
<h3 style="margin:0;font-size:20px;margin-bottom:10px">Foro</h3>
<div class="card">
<form id="post-form">
<textarea id="contenido" placeholder="Escribe tu mensaje para el foro..."></textarea>
<div style="display:flex;justify-content:space-between;align-items:center;margin-top:8px">
<p style="color:var(--muted);font-size:12px">Consejo: sé respetuoso y claro. Usa Shift+Enter para salto de línea.</p>
<button class="btn" type="submit">Publicar</button>
</div>
</form>
</div>
<section id="lista-posts" style="margin-top:16px"></section>
</main>
<footer>
<div class="container footer-inner">
<p>© <span id="anio"></span> OrganizaTs</p>
<p>Demostración sin backend</p>
</div>
</footer>
<?php if ($rol_id == 1): ?>
const hamburger = document.getElementById("hamburger");
const sidebar = document.getElementById("sidebar");
const overlay = document.getElementById("overlay");
if(hamburger){
hamburger.addEventListener("click", ()=>{
sidebar.classList.add("active");
overlay.classList.add("active");
});
overlay.addEventListener("click", ()=>{
sidebar.classList.remove("active");
overlay.classList.remove("active");
});
}
<?php endif; ?>
</body>
</html>
