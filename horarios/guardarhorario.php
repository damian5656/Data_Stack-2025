<?php
include __DIR__ . "/../conexion.php";

// 1. Recibe y decodifica el JSON enviado desde JavaScript
$data = json_decode(file_get_contents("php://input"), true);

if (!$data || !is_array($data)) {
    echo "Datos inválidos";
    exit;
}

// Para limpiar el horario antes de insertar el nuevo (Recomendado)
// Si solo estás manejando el horario de un grupo a la vez, necesitarías saber qué ID_Horario borrar. 
// Asumiré que el ID_Horario a modificar es '4' (por ejemplo) o que lo pasas desde JS,
// pero por ahora solo borraremos lo que estamos insertando.

// 2. Procesa cada bloque de clase (item)
foreach ($data as $item) {
    // Estas variables ahora solo se usan para INSERTAR, no para borrar el horario viejo.
    // El $grupo ya no se usa en la consulta INSERT.
    $materia    = (int)$item['materia'];
    $dia        = (int)$item['dia'];
    $hora       = (int)$item['hora'];
    
    // El ID_Horario es una clave foránea a tu tabla 'horarios'. 
    // Debes obtener o saber el ID del horario que estás editando. Usaré un valor fijo (ej. 6) solo como EJEMPLO.
    // **DEBES REEMPLAZAR '6' por la lógica que obtenga el ID_Horario correcto que estás editando.**
    $idHorarioActual = 6; 

    // **CORRECCIÓN CLAVE:**
    // 1. Eliminé 'ID_Grupo' de la consulta.
    // 2. Añadí 'ID_Horario' y la variable $idHorarioActual (asumiendo que editas el ID 6).
    // 3. Cambié el nombre de la tabla de 'horario' a 'horario_detalle' (ajusta el nombre si es diferente).
    $sql = "INSERT INTO horario (ID_Horario, ID_Asignatura, ID_Dia, ID_Hora)
             VALUES (?, ?, ?, ?)
             ON DUPLICATE KEY UPDATE ID_Asignatura = VALUES(ID_Asignatura)";
             
    // Los tipos ahora son: (i) ID_Horario, (i) ID_Asignatura, (i) ID_Dia, (i) ID_Hora
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iiii", $idHorarioActual, $materia, $dia, $hora);
    $stmt->execute();
    $stmt->close();
}

echo "Horario guardado correctamente";
?>