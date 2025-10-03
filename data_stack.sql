-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-08-2025 a las 23:28:41
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `data_stack`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `adscripto`
--

CREATE TABLE `adscripto` (
  `ID_Adscripto` int(11) NOT NULL,
  `ID_Usuario` int(11) DEFAULT NULL,
  `ID_Grupo` int(11) DEFAULT NULL,
  `Turno` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE `alumno` (
  `ID_Alumno` int(11) NOT NULL,
  `Cédula` int(11) NOT NULL,
  `ID_Grupo` int(11) DEFAULT NULL,
  `ID_Usuario` int(11) DEFAULT NULL,
  `Turno` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignatura`
--

CREATE TABLE `asignatura` (
  `ID_Asignatura` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Año` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `codigos_admin`
--

CREATE TABLE `codigos_admin` (
  `ID_Codigo` int(11) NOT NULL,
  `Codigo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `codigos_admin`
--

INSERT INTO `codigos_admin` (`ID_Codigo`, `Codigo`) VALUES
(2, '1234');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `ID_Curso` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso_tiene_asignaturas`
--

CREATE TABLE `curso_tiene_asignaturas` (
  `ID_Asignatura` int(11) NOT NULL,
  `ID_Curso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docente`
--

CREATE TABLE `docente` (
  `ID_Docente` int(11) NOT NULL,
  `ID_Usuario` int(11) DEFAULT NULL,
  `ID_Asignatura` int(11) DEFAULT NULL,
  `Fecha_Ingreso` date DEFAULT NULL,
  `ID_Grupo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `espacio`
--

CREATE TABLE `espacio` (
  `ID_Espacio` int(11) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Capacidad` int(11) DEFAULT NULL,
  `Ubicacion` varchar(100) DEFAULT NULL,
  `ID_Tipo_Espacio` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evento`
--

CREATE TABLE `evento` (
  `ID_Evento` varchar(50) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `ID_Horario` int(11) DEFAULT NULL,
  `ID_Reserva` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo`
--

CREATE TABLE `grupo` (
  `ID_Grupo` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `ID_Curso` int(11) DEFAULT NULL,
  `ID_Horario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_de_limpieza`
--

CREATE TABLE `historial_de_limpieza` (
  `ID_Historial_Limpieza` int(11) NOT NULL,
  `Fecha_Hora_Inicio` datetime NOT NULL,
  `Fecha_Hora_Finalizacion` datetime NOT NULL,
  `Estado_De_Limpieza` varchar(50) NOT NULL,
  `Observaciones` text DEFAULT NULL,
  `ID_Usuario` int(11) NOT NULL,
  `ID_Tipo_Limpieza` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horario`
--

CREATE TABLE `horario` (
  `ID_Horario` int(11) NOT NULL,
  `Dia_Semana` varchar(20) NOT NULL,
  `Hora_Inicio` time NOT NULL,
  `Hora_Fin` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `ID_Permiso` int(11) NOT NULL,
  `Nombre_Permiso` varchar(100) NOT NULL,
  `ID_Rol` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recursos`
--

CREATE TABLE `recursos` (
  `ID_Recurso` int(11) NOT NULL,
  `Nombre` varchar(130) NOT NULL,
  `Ubicacion` varchar(130) DEFAULT NULL,
  `Estado` varchar(130) DEFAULT NULL,
  `Descripcion` text DEFAULT NULL,
  `Ultimo_Mantenimiento` date DEFAULT NULL,
  `ID_Tipo_Recurso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reporte`
--

CREATE TABLE `reporte` (
  `ID_Reporte` int(11) NOT NULL,
  `Fecha_Reporte` date NOT NULL,
  `Estado_Reporte` varchar(130) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `ID_Usuario` int(11) NOT NULL,
  `ID_Tipo_Reporte` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE `reserva` (
  `ID_Reserva` int(11) NOT NULL,
  `Fecha_Creada` datetime NOT NULL,
  `Hora_Inicio` time NOT NULL,
  `Estado` varchar(50) NOT NULL,
  `Descripcion_Motivo` text DEFAULT NULL,
  `ID_Usuario` int(11) DEFAULT NULL,
  `ID_Espacio` int(11) DEFAULT NULL,
  `ID_Recurso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `ID_Rol` int(11) NOT NULL,
  `Nombre_Rol` varchar(255) NOT NULL,
  `ID_Tipo_Rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`ID_Rol`, `Nombre_Rol`, `ID_Tipo_Rol`) VALUES
(1, 'Administrador', 1),
(2, 'Profesor', 2),
(3, 'Estudiante', 2),
(4, 'Adscripto', 3),
(5, 'Auxiliar', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_de_limpieza`
--

CREATE TABLE `tipo_de_limpieza` (
  `ID_Tipo_Limpieza` int(11) NOT NULL,
  `Nombre_Tipo_Limpieza` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_de_reporte`
--

CREATE TABLE `tipo_de_reporte` (
  `ID_Tipo_Reporte` int(11) NOT NULL,
  `Nombre_Tipo_Reporte` varchar(130) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_de_rol`
--

CREATE TABLE `tipo_de_rol` (
  `ID_Tipo_Rol` int(11) NOT NULL,
  `Nombre_Tipo_Rol` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_de_rol`
--

INSERT INTO `tipo_de_rol` (`ID_Tipo_Rol`, `Nombre_Tipo_Rol`) VALUES
(1, 'Administrativo'),
(2, 'Académico'),
(3, 'Auxiliar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_espacio`
--

CREATE TABLE `tipo_espacio` (
  `ID_Tipo_Espacio` int(11) NOT NULL,
  `Nombre_Tipo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_recursos`
--

CREATE TABLE `tipo_recursos` (
  `ID_Tipo_Recurso` int(11) NOT NULL,
  `Nombre_Tipo_Recurso` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `ID_Usuario` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Documento` int(15) NOT NULL,
  `Apellido` varchar(255) NOT NULL,
  `Correo` varchar(255) NOT NULL,
  `Contrasena` varchar(255) NOT NULL,
  `ID_Rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`ID_Usuario`, `Nombre`, `Documento`, `Apellido`, `Correo`, `Contrasena`, `ID_Rol`) VALUES
(11, 'Damian', 56567557, 'Luberiaga', 'damian@gmail.com', '$2y$10$GG./mXps9wQ.6AcAblo81e2B09lRHNo8j7giAgBVAfeSQilhvGHj2', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `adscripto`
--
ALTER TABLE `adscripto`
  ADD PRIMARY KEY (`ID_Adscripto`),
  ADD KEY `ID_Usuario` (`ID_Usuario`),
  ADD KEY `ID_Grupo` (`ID_Grupo`);

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`ID_Alumno`),
  ADD KEY `ID_Grupo` (`ID_Grupo`),
  ADD KEY `ID_Usuario` (`ID_Usuario`);

--
-- Indices de la tabla `asignatura`
--
ALTER TABLE `asignatura`
  ADD PRIMARY KEY (`ID_Asignatura`);

--
-- Indices de la tabla `codigos_admin`
--
ALTER TABLE `codigos_admin`
  ADD PRIMARY KEY (`ID_Codigo`),
  ADD UNIQUE KEY `Codigo` (`Codigo`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`ID_Curso`);

--
-- Indices de la tabla `curso_tiene_asignaturas`
--
ALTER TABLE `curso_tiene_asignaturas`
  ADD PRIMARY KEY (`ID_Asignatura`,`ID_Curso`),
  ADD KEY `ID_Curso` (`ID_Curso`);

--
-- Indices de la tabla `docente`
--
ALTER TABLE `docente`
  ADD PRIMARY KEY (`ID_Docente`);

--
-- Indices de la tabla `espacio`
--
ALTER TABLE `espacio`
  ADD PRIMARY KEY (`ID_Espacio`),
  ADD KEY `ID_Tipo_Espacio` (`ID_Tipo_Espacio`);

--
-- Indices de la tabla `evento`
--
ALTER TABLE `evento`
  ADD PRIMARY KEY (`ID_Evento`),
  ADD KEY `ID_Horario` (`ID_Horario`),
  ADD KEY `ID_Reserva` (`ID_Reserva`);

--
-- Indices de la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD PRIMARY KEY (`ID_Grupo`),
  ADD KEY `ID_Curso` (`ID_Curso`),
  ADD KEY `ID_Horario` (`ID_Horario`);

--
-- Indices de la tabla `historial_de_limpieza`
--
ALTER TABLE `historial_de_limpieza`
  ADD PRIMARY KEY (`ID_Historial_Limpieza`),
  ADD KEY `ID_Usuario` (`ID_Usuario`),
  ADD KEY `ID_Tipo_Limpieza` (`ID_Tipo_Limpieza`);

--
-- Indices de la tabla `horario`
--
ALTER TABLE `horario`
  ADD PRIMARY KEY (`ID_Horario`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`ID_Permiso`),
  ADD KEY `ID_Rol` (`ID_Rol`);

--
-- Indices de la tabla `recursos`
--
ALTER TABLE `recursos`
  ADD PRIMARY KEY (`ID_Recurso`),
  ADD KEY `ID_Tipo_Recurso` (`ID_Tipo_Recurso`);

--
-- Indices de la tabla `reporte`
--
ALTER TABLE `reporte`
  ADD PRIMARY KEY (`ID_Reporte`),
  ADD KEY `ID_Usuario` (`ID_Usuario`),
  ADD KEY `ID_Tipo_Reporte` (`ID_Tipo_Reporte`);

--
-- Indices de la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`ID_Reserva`),
  ADD KEY `ID_Usuario` (`ID_Usuario`),
  ADD KEY `ID_Espacio` (`ID_Espacio`),
  ADD KEY `ID_Recurso` (`ID_Recurso`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`ID_Rol`),
  ADD KEY `ID_Tipo_Rol` (`ID_Tipo_Rol`);

--
-- Indices de la tabla `tipo_de_limpieza`
--
ALTER TABLE `tipo_de_limpieza`
  ADD PRIMARY KEY (`ID_Tipo_Limpieza`);

--
-- Indices de la tabla `tipo_de_reporte`
--
ALTER TABLE `tipo_de_reporte`
  ADD PRIMARY KEY (`ID_Tipo_Reporte`);

--
-- Indices de la tabla `tipo_de_rol`
--
ALTER TABLE `tipo_de_rol`
  ADD PRIMARY KEY (`ID_Tipo_Rol`);

--
-- Indices de la tabla `tipo_espacio`
--
ALTER TABLE `tipo_espacio`
  ADD PRIMARY KEY (`ID_Tipo_Espacio`);

--
-- Indices de la tabla `tipo_recursos`
--
ALTER TABLE `tipo_recursos`
  ADD PRIMARY KEY (`ID_Tipo_Recurso`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`ID_Usuario`),
  ADD KEY `ID_Rol` (`ID_Rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `adscripto`
--
ALTER TABLE `adscripto`
  MODIFY `ID_Adscripto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `alumno`
--
ALTER TABLE `alumno`
  MODIFY `ID_Alumno` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `asignatura`
--
ALTER TABLE `asignatura`
  MODIFY `ID_Asignatura` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `codigos_admin`
--
ALTER TABLE `codigos_admin`
  MODIFY `ID_Codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `curso`
--
ALTER TABLE `curso`
  MODIFY `ID_Curso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `docente`
--
ALTER TABLE `docente`
  MODIFY `ID_Docente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `espacio`
--
ALTER TABLE `espacio`
  MODIFY `ID_Espacio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `grupo`
--
ALTER TABLE `grupo`
  MODIFY `ID_Grupo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial_de_limpieza`
--
ALTER TABLE `historial_de_limpieza`
  MODIFY `ID_Historial_Limpieza` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `horario`
--
ALTER TABLE `horario`
  MODIFY `ID_Horario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `ID_Permiso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `recursos`
--
ALTER TABLE `recursos`
  MODIFY `ID_Recurso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reporte`
--
ALTER TABLE `reporte`
  MODIFY `ID_Reporte` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reserva`
--
ALTER TABLE `reserva`
  MODIFY `ID_Reserva` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `ID_Rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tipo_de_limpieza`
--
ALTER TABLE `tipo_de_limpieza`
  MODIFY `ID_Tipo_Limpieza` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_de_reporte`
--
ALTER TABLE `tipo_de_reporte`
  MODIFY `ID_Tipo_Reporte` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_de_rol`
--
ALTER TABLE `tipo_de_rol`
  MODIFY `ID_Tipo_Rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_espacio`
--
ALTER TABLE `tipo_espacio`
  MODIFY `ID_Tipo_Espacio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_recursos`
--
ALTER TABLE `tipo_recursos`
  MODIFY `ID_Tipo_Recurso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `ID_Usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `adscripto`
--
ALTER TABLE `adscripto`
  ADD CONSTRAINT `adscripto_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuario` (`ID_Usuario`),
  ADD CONSTRAINT `adscripto_ibfk_2` FOREIGN KEY (`ID_Grupo`) REFERENCES `grupo` (`ID_Grupo`);

--
-- Filtros para la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD CONSTRAINT `alumno_ibfk_1` FOREIGN KEY (`ID_Grupo`) REFERENCES `grupo` (`ID_Grupo`),
  ADD CONSTRAINT `alumno_ibfk_2` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuario` (`ID_Usuario`);

--
-- Filtros para la tabla `curso_tiene_asignaturas`
--
ALTER TABLE `curso_tiene_asignaturas`
  ADD CONSTRAINT `curso_tiene_asignaturas_ibfk_1` FOREIGN KEY (`ID_Asignatura`) REFERENCES `asignatura` (`ID_Asignatura`),
  ADD CONSTRAINT `curso_tiene_asignaturas_ibfk_2` FOREIGN KEY (`ID_Curso`) REFERENCES `curso` (`ID_Curso`);

--
-- Filtros para la tabla `espacio`
--
ALTER TABLE `espacio`
  ADD CONSTRAINT `espacio_ibfk_1` FOREIGN KEY (`ID_Tipo_Espacio`) REFERENCES `tipo_espacio` (`ID_Tipo_Espacio`);

--
-- Filtros para la tabla `evento`
--
ALTER TABLE `evento`
  ADD CONSTRAINT `evento_ibfk_1` FOREIGN KEY (`ID_Horario`) REFERENCES `horario` (`ID_Horario`),
  ADD CONSTRAINT `evento_ibfk_2` FOREIGN KEY (`ID_Reserva`) REFERENCES `reserva` (`ID_Reserva`);

--
-- Filtros para la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD CONSTRAINT `grupo_ibfk_1` FOREIGN KEY (`ID_Curso`) REFERENCES `curso` (`ID_Curso`),
  ADD CONSTRAINT `grupo_ibfk_2` FOREIGN KEY (`ID_Horario`) REFERENCES `horario` (`ID_Horario`);

--
-- Filtros para la tabla `historial_de_limpieza`
--
ALTER TABLE `historial_de_limpieza`
  ADD CONSTRAINT `historial_de_limpieza_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuario` (`ID_Usuario`),
  ADD CONSTRAINT `historial_de_limpieza_ibfk_2` FOREIGN KEY (`ID_Tipo_Limpieza`) REFERENCES `tipo_de_limpieza` (`ID_Tipo_Limpieza`);

--
-- Filtros para la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD CONSTRAINT `permisos_ibfk_1` FOREIGN KEY (`ID_Rol`) REFERENCES `rol` (`ID_Rol`);

--
-- Filtros para la tabla `recursos`
--
ALTER TABLE `recursos`
  ADD CONSTRAINT `recursos_ibfk_1` FOREIGN KEY (`ID_Tipo_Recurso`) REFERENCES `tipo_recursos` (`ID_Tipo_Recurso`);

--
-- Filtros para la tabla `reporte`
--
ALTER TABLE `reporte`
  ADD CONSTRAINT `reporte_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuario` (`ID_Usuario`),
  ADD CONSTRAINT `reporte_ibfk_2` FOREIGN KEY (`ID_Tipo_Reporte`) REFERENCES `tipo_de_reporte` (`ID_Tipo_Reporte`);

--
-- Filtros para la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD CONSTRAINT `reserva_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuario` (`ID_Usuario`),
  ADD CONSTRAINT `reserva_ibfk_2` FOREIGN KEY (`ID_Espacio`) REFERENCES `espacio` (`ID_Espacio`),
  ADD CONSTRAINT `reserva_ibfk_3` FOREIGN KEY (`ID_Recurso`) REFERENCES `recursos` (`ID_Recurso`);

--
-- Filtros para la tabla `rol`
--
ALTER TABLE `rol`
  ADD CONSTRAINT `rol_ibfk_1` FOREIGN KEY (`ID_Tipo_Rol`) REFERENCES `tipo_de_rol` (`ID_Tipo_Rol`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`ID_Rol`) REFERENCES `rol` (`ID_Rol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
