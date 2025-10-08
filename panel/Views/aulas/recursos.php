<?php
session_start();
require "conexion.php"; // Se asume que este archivo proporciona la variable $conn (objeto mysqli)

// =========================================================
// 0. SEGURIDAD INICIAL Y CONFIGURACIÓN DE MENSAJES (Sin cambios en PHP)
// =========================================================
$id_aula = $_GET['id'] ?? null;
$message_text = '';
$message_type = '';
$aula_nombre = 'Cargando...';

// Función para mostrar mensajes de sesión (PRG)
if (isset($_SESSION['message'])) {
    $message_text = $_SESSION['message']['text'];
    $message_type = $_SESSION['message']['type'];
    unset($_SESSION['message']);
}

// 0.1. Validar y sanitizar el ID del aula
if (!$id_aula || !is_numeric($id_aula) || $id_aula <= 0) {
    die("❌ Error: ID de aula no válido o no especificado.");
}
$id_aula = intval($id_aula); // Asegurarse de que es un entero

// 0.2. Obtener el nombre del aula de forma segura (Sentencia preparada)
$stmt_aula = $conn->prepare("SELECT Nombre FROM espacio WHERE ID_Espacio = ?");
if ($stmt_aula) {
    $stmt_aula->bind_param("i", $id_aula);
    $stmt_aula->execute();
    $result_aula = $stmt_aula->get_result();
    
    if ($result_aula->num_rows > 0) {
        $aula = $result_aula->fetch_assoc();
        $aula_nombre = htmlspecialchars($aula['Nombre']);
    } else {
        die("❌ Error: Aula no encontrada.");
    }
    $stmt_aula->close();
} else {
    die("❌ Error al preparar la consulta del aula: " . $conn->error);
}

// =========================================================
// 1. PROCESAMIENTO: INSERTAR RECURSO (POST SEGURO) (Sin cambios en PHP)
// =========================================================
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    
    $nombre = trim($_POST['nombre'] ?? '');
    $cantidad = intval($_POST['cantidad'] ?? 0);
    $tiene_disponibilidad = isset($_POST['tiene_disponibilidad']) ? 1 : 0; 
    $disponible = ($tiene_disponibilidad && isset($_POST['disponible'])) ? intval($_POST['disponible']) : 1; 

    // Validación básica en el servidor
    if (empty($nombre) || $cantidad <= 0) {
        $message_text = "❌ Error: Debe especificar un nombre y una cantidad válida (mínimo 1).";
        $message_type = 'error';
    } else {
        // 1.1. Sentencia preparada para SEGURIDAD (vs Inyección SQL)
        $sql = "INSERT INTO recursos (Nombre, id_aula, cantidad, tiene_disponibilidad, disponible)
                VALUES (?, ?, ?, ?, ?)";
        
        if ($stmt_insert = $conn->prepare($sql)) {
            $stmt_insert->bind_param("siiii", $nombre, $id_aula, $cantidad, $tiene_disponibilidad, $disponible);

            if ($stmt_insert->execute()) {
                // 1.2. Patrón PRG: Configurar mensaje de éxito y redireccionar
                $_SESSION['message'] = [
                    'text' => "✅ Recurso **" . htmlspecialchars($nombre) . "** agregado con éxito al aula **" . $aula_nombre . "**.",
                    'type' => 'success'
                ];
                header("Location: recursos.php?id=$id_aula"); 
                exit();
            } else {
                $message_text = "❌ Error al insertar el recurso: " . $stmt_insert->error;
                $message_type = 'error';
            }
            $stmt_insert->close();
        } else {
            $message_text = "❌ Error al preparar la inserción: " . $conn->error;
            $message_type = 'error';
        }
    }
}

// =========================================================
// 2. OBTENER DATOS: MOSTRAR RECURSOS (GET SEGURO) (Sin cambios en PHP)
// =========================================================
$recursos = [];
$sql_select = "SELECT * FROM recursos WHERE id_aula = ?";

if ($stmt_select = $conn->prepare($sql_select)) {
    $stmt_select->bind_param("i", $id_aula);
    $stmt_select->execute();
    $result = $stmt_select->get_result();

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $recursos[] = $row;
        }
    }
    $stmt_select->close();
} else {
    $message_text = "❌ Error al preparar la consulta de recursos: " . $conn->error;
    $message_type = 'error';
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Recursos del Aula: <?php echo $aula_nombre; ?></title>
    <style>
        /* Variables y Reset Básico */
        :root {
            --primary-color: #007bff; /* Azul primario */
            --primary-dark: #0056b3;
            --bg-color: #f7f9fc; /* Fondo muy claro */
            --card-bg: #ffffff;
            --text-color: #343a40; /* Texto oscuro */
            --border-color: #e9ecef;
            --success-bg: #d4edda;
            --success-text: #155724;
            --error-bg: #f8d7da;
            --error-text: #721c24;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--bg-color);
            padding: 20px;
            color: var(--text-color);
            line-height: 1.6;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        /* Títulos */
        h1 {
            color: var(--primary-dark);
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 10px;
            margin-bottom: 20px;
            text-align: center;
        }

        h2 {
            color: var(--text-color);
            margin-top: 30px;
            margin-bottom: 15px;
            font-size: 1.5em;
        }

        /* Mensajes de Estado */
        .message {
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 6px;
            font-weight: 600;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .success {
            background: var(--success-bg);
            color: var(--success-text);
            border: 1px solid #c3e6cb;
        }

        .error {
            background: var(--error-bg);
            color: var(--error-text);
            border: 1px solid #f5c6cb;
        }

        /* Lista de Recursos */
        .recurso-list {
            display: grid;
            gap: 15px;
        }

        .recurso {
            background: var(--card-bg);
            padding: 20px;
            border-radius: 8px;
            box-shadow: var(--shadow);
            border-left: 5px solid var(--primary-color);
            transition: transform 0.2s;
        }

        .recurso:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.1);
        }

        .recurso strong {
            font-size: 1.1em;
            color: var(--primary-dark);
            display: inline-block;
            margin-right: 10px;
        }

        .disponible {
            color: #1e7e34; /* Verde */
            font-weight: 700;
        }

        .no-disponible {
            color: #dc3545; /* Rojo */
            font-weight: 700;
        }

        /* Formulario de Agregar Recurso */
        form {
            background: var(--card-bg);
            padding: 30px;
            border-radius: 8px;
            box-shadow: var(--shadow);
            margin-top: 30px;
        }

        input[type="text"], 
        input[type="number"], 
        select {
            display: block;
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        select:focus {
            border-color: var(--primary-color);
            outline: none;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #5a6268;
        }
        
        /* Checkbox y su div de estado */
        #estado label {
            font-weight: normal;
        }
        
        #chkDisponibilidad {
            width: auto;
            display: inline;
            margin-right: 8px;
        }

        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
            font-weight: 600;
            transition: background 0.3s, transform 0.1s;
            margin-top: 10px;
        }

        button[type="submit"]:hover {
            background: var(--primary-dark);
            transform: translateY(-1px);
        }

        /* Link de regreso */
        .back-link {
            display: inline-block;
            margin-top: 30px;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            padding: 8px 15px;
            border-radius: 4px;
            border: 1px solid var(--primary-color);
            transition: background 0.3s;
        }

        .back-link:hover {
            background: var(--primary-color);
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        
        <h1>Recursos del aula: <?php echo $aula_nombre; ?></h1>

        <?php 
        // Mostrar Mensajes de Sesión/Error
        if ($message_text): 
        ?>
            <div class="message <?php echo htmlspecialchars($message_type); ?>">
                <?php echo $message_text; ?>
            </div>
        <?php 
        endif; 
        ?>

        <?php
        // Mostrar recursos del aula
        if (count($recursos) > 0) {
            echo "<h2>Lista de recursos</h2>";
            echo "<div class='recurso-list'>";
            foreach ($recursos as $row) {
                echo "<div class='recurso'>";
                echo "<strong>" . htmlspecialchars($row['Nombre']) . "</strong> — Cantidad: " . intval($row['cantidad']);
                
                if ($row['tiene_disponibilidad']) {
                    $estado = $row['disponible'] ? "disponible" : "no-disponible";
                    $texto = $row['disponible'] ? "✅ Disponible" : "❌ No disponible";
                    echo " — <span class='$estado'>$texto</span>";
                }
                // Aquí se podría agregar un botón de "Eliminar" o "Editar"
                echo "</div>";
            }
            echo "</div>"; // Cierre de .recurso-list
        } else {
            echo "<p>No hay recursos en esta aula. Agrega uno nuevo a continuación.</p>";
        }
        ?>

        <form method="POST" action="recursos.php?id=<?php echo $id_aula; ?>">
            <h2>Agregar Nuevo Recurso</h2>
            <div class="form-group">
                <label for="nombre">Nombre del Recurso</label>
                <input type="text" name="nombre" id="nombre" placeholder="Ej: Proyector, Sillas, Pizarrón" required maxlength="100">
            </div>
            
            <div class="form-group">
                <label for="cantidad">Cantidad</label>
                <input type="number" name="cantidad" id="cantidad" placeholder="Cantidad" min="1" value="1" required>
            </div>
            
            <div class="form-group">
               
    
            
            <button type="submit">➕ Agregar Recurso</button>
        </form>

        <script>
        function toggleDisponibilidad() {
            const check = document.getElementById('chkDisponibilidad');
            document.getElementById('estado').style.display = check.checked ? 'block' : 'none';
        }
        // Asegurarse de que el estado inicial se aplique si hay un error y el checkbox estaba marcado
        document.addEventListener('DOMContentLoaded', toggleDisponibilidad);
        </script>

        <a href="aulas.php" class="back-link">⬅ Volver a Aulas</a>
    </div>
</body>
</html>