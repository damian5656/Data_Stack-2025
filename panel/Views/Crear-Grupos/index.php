<h1>Grupos</h1>

<?php if (!empty($grupos)): ?>
    <ul>
        <?php foreach($grupos as $grupo): ?>
            <li><?= htmlspecialchars($grupo['nombre']) ?></li>
        <?php endforeach; ?>
    </ul>
<?php else: ?>
    <p>No hay grupos cargados.</p>
<?php endif; ?>
