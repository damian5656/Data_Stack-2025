document.addEventListener("DOMContentLoaded", function () {
    const agregarBtn = document.getElementById("agregarBtn");
    const guardarBtn = document.getElementById("guardarBtn");
    const tabla = document.getElementById("horario");
    const grupoSelect = document.getElementById("grupo");
    const materiaSelect = document.getElementById("materia");
    const diaSelect = document.getElementById("dia");
    const bloqueSelect = document.getElementById("bloque");

    // --- Carga de Materias al cambiar grupo (Sin cambios) ---
    grupoSelect.addEventListener("change", function () {
        const grupoId = this.value;
        materiaSelect.innerHTML = "<option value=''>Cargando...</option>";

        if (!grupoId) {
            materiaSelect.innerHTML = "<option value=''>Seleccione un grupo primero</option>";
            return;
        }

        fetch("get_materias.php?id_grupo=" + encodeURIComponent(grupoId)) 
            .then(res => {
                if (!res.ok) {
                    throw new Error('Error de red o archivo PHP fallido: Código ' + res.status);
                }
                return res.json();
            })
            .then(data => {
                const materiasArray = data.ok && Array.isArray(data.materias) ? data.materias : [];

                materiaSelect.innerHTML = "<option value=''>-- Seleccione --</option>";
                
                if (materiasArray.length === 0) {
                    materiaSelect.innerHTML = "<option value=''>No hay materias o el grupo no tiene curso asignado</option>";
                    return;
                }
                
                materiasArray.forEach(m => {
                    const option = document.createElement("option");
                    option.value = m.id; 
                    option.textContent = m.nombre;
                    materiaSelect.appendChild(option);
                });
            })
            .catch(err => {
                console.error("Error al traer materias:", err);
                materiaSelect.innerHTML = `<option value=''>Error al cargar: ${err.message || 'Respuesta inválida'}</option>`;
            });
    });

    // --- EVENTO CLAVE: Doble Clic para Borrar Contenido de la Celda ---
    function setupDeleteOnDoubleClick() {
        // Seleccionamos todas las celdas que potencialmente pueden tener una materia asignada
        const celdasMateria = tabla.querySelectorAll("td[data-dia][data-hora]");
        
        celdasMateria.forEach(celda => {
            celda.addEventListener('dblclick', function() {
                // Solo borrar si la celda tiene una materia y un grupo asignado (es decir, fue llenada)
                if (this.hasAttribute('data-materia')) {
                    const confirmDelete = confirm("¿Estás seguro de que quieres eliminar esta materia de la celda?");
                    
                    if (confirmDelete) {
                        this.textContent = ""; // Borra el texto visible
                        this.style.backgroundColor = ""; // Restaura el color de fondo
                        
                        // Elimina los atributos de la materia y grupo para que no se guarden
                        this.removeAttribute('data-materia');
                        this.removeAttribute('data-grupo');
                        
                        console.log("Materia borrada de la celda:", {
                            dia: this.getAttribute('data-dia'),
                            hora: this.getAttribute('data-hora')
                        });

                        // Muestra el botón de guardar para que el usuario pueda persistir el cambio
                        guardarBtn.style.display = "inline-block";
                    }
                }
            });
        });
        console.log("Funcionalidad de doble clic activada.");
    }

    // Llamar a la función al inicio para aplicar el evento a todas las celdas
    setupDeleteOnDoubleClick();
    // --- FIN EVENTO DOBLE CLIC ---
    
    // --- evento AGREGAR: encuentra la celda y escribe (Sin cambios) ---
    agregarBtn.addEventListener("click", function () {
        const grupo = grupoSelect.value;
        const materia = materiaSelect.value;
        const materiaNombre = materiaSelect.options[materiaSelect.selectedIndex]?.text || "";
        const dia = Number(diaSelect.value); // 1..5
        
        const idHoraBD = Number(bloqueSelect.value); 
        const indiceFila = bloqueSelect.selectedIndex + 1; 

        if (!grupo || !materia || !dia || !idHoraBD) {
            alert("Complete todos los campos (grupo, dia, hora, materia).");
            return;
        }

        console.log(`Intentando colocar materia: ID_BD=${idHoraBD}, Día=${dia}, Índice de Fila=${indiceFila}`);

        let celda = tabla.querySelector(`td[data-dia="${dia}"][data-indice-fila="${indiceFila}"]`);
        
        if (!celda) {
            console.error(`No se encontró celda para data-dia=${dia} y data-indice-fila=${indiceFila}.`);
            alert("No se encontró la celda. Verifica que 'horarios.php' esté generando correctamente 'data-indice-fila'.");
            return;
        }

        // ESCRIBIR en la celda
        celda.textContent = materiaNombre;
        celda.setAttribute("data-materia", String(materia)); 
        celda.setAttribute("data-grupo", String(grupo));
        celda.setAttribute("data-dia", String(dia));
        celda.setAttribute("data-hora", String(idHoraBD)); 
        celda.style.backgroundColor = "#d0f0d0"; // visual

        console.log("Materia colocada en celda:", {
            celda,
            attrs: {
                dia: celda.getAttribute("data-dia"),
                hora: celda.getAttribute("data-hora"), 
                materia: celda.getAttribute("data-materia"),
                grupo: celda.getAttribute("data-grupo"),
                indiceFila: celda.getAttribute("data-indice-fila")
            }
        });

        guardarBtn.style.display = "inline-block";
    });

    // --- evento GUARDAR: toma todas las celdas con data-materia (Sin cambios) ---
    guardarBtn.addEventListener("click", function () {
        const celdas = tabla.querySelectorAll("td[data-materia][data-dia][data-hora][data-grupo]");
        const datos = [];

        celdas.forEach(celda => {
            const horaParaGuardar = Number(celda.getAttribute("data-hora")); 
            
            datos.push({
                grupo: Number(celda.getAttribute("data-grupo")),
                materia: Number(celda.getAttribute("data-materia")),
                dia: Number(celda.getAttribute("data-dia")),
                hora: horaParaGuardar
            });
        });

        if (datos.length === 0) {
            alert("No hay nada para guardar.");
            return;
        }

        console.log("Enviando al servidor estos items:", datos);

        fetch("guardarHorario.php", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(datos)
        })
        .then(res => res.text())
        .then(msg => {
            alert("Respuesta servidor: " + msg);
            guardarBtn.style.display = "none";
        })
        .catch(err => {
            console.error("Error guardando:", err);
            alert("Error al guardar, ver consola.");
        });
    });
});