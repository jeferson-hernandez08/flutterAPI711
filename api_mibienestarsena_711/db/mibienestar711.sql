-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-08-2025 a las 04:17:59
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
-- Base de datos: `mibienestar711`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `image`, `createdAt`, `updatedAt`) VALUES
(1, 'Tecnología e Innovación', 'Eventos relacionados con avances tecnológicos, innovación y nuevas tendencias digitales.', 'https://example.com/tecnologia.jpg', '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(2, 'Deportes', 'Actividades deportivas, torneos, competencias y jornadas de bienestar físico.', 'https://example.com/deportes.jpg', '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(3, 'Cultura y Arte', 'Eventos culturales, muestras artísticas, teatro, música y danza.', 'https://example.com/cultura.jpg', '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(4, 'Emprendimiento', 'Espacios para la creación de ideas de negocio, startups y proyectos innovadores.', 'https://example.com/emprendimiento.jpg', '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(5, 'Ciencia', 'Charlas y exposiciones relacionadas con investigación científica y descubrimientos.', 'https://example.com/ciencia.jpg', '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(6, 'Medio Ambiente', 'Iniciativas sobre sostenibilidad, reciclaje y cuidado del entorno natural.', 'https://example.com/medioambiente.jpg', '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(7, 'Salud y Bienestar', 'Talleres y campañas enfocadas en la salud física y mental.', 'https://example.com/salud.jpg', '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(8, 'Educación y Formación', 'Actividades académicas, capacitaciones, cursos y formación continua.', 'https://example.com/educacion.jpg', '2025-08-24 17:04:41', '2025-08-24 17:04:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `starDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `maxCapacity` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `events`
--

INSERT INTO `events` (`id`, `name`, `description`, `starDate`, `endDate`, `categoryId`, `state`, `maxCapacity`, `userId`, `createdAt`, `updatedAt`) VALUES
(1, 'Hackathon 2025', 'Competencia de programación e innovación tecnológica.', '2025-10-05 13:00:00', '2025-10-07 01:00:00', 1, 'activo', 150, 3, '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(2, 'Torneo Intercentros de Fútbol', 'Campeonato entre diferentes equipos de los centros educativos.', '2025-09-20 19:00:00', '2025-09-20 23:00:00', 2, 'activo', 22, 4, '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(3, 'Festival de Música y Danza', 'Presentaciones artísticas y muestras culturales.', '2025-09-25 23:00:00', '2025-09-26 03:00:00', 3, 'activo', 300, 5, '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(4, 'ExpoStartups 2025', 'Feria de emprendimiento y networking para jóvenes empresarios.', '2025-10-12 14:00:00', '2025-10-12 22:00:00', 4, 'activo', 120, 1, '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(5, 'Congreso de Innovación Científica', 'Charlas y ponencias de investigadores destacados.', '2025-10-18 13:00:00', '2025-10-18 23:00:00', 5, 'activo', 250, 2, '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(6, 'Jornada de Reforestación', 'Actividad para sembrar árboles y promover la sostenibilidad.', '2025-09-28 12:00:00', '2025-09-28 18:00:00', 6, 'activo', 100, 3, '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(7, 'Feria de la Salud 2025', 'Charlas médicas, chequeos gratuitos y promoción de hábitos saludables.', '2025-09-30 14:00:00', '2025-09-30 20:00:00', 7, 'activo', 200, 4, '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(8, 'Taller de Liderazgo y Motivación', 'Un espacio para fortalecer habilidades blandas y liderazgo personal.', '2025-09-10 14:00:00', '2025-09-10 17:00:00', 7, 'activo', 50, 1, '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(9, 'Semana Académica 2025', 'Conferencias, talleres y capacitaciones en distintas áreas del conocimiento.', '2025-10-01 13:00:00', '2025-10-05 23:00:00', 8, 'activo', 400, 5, '2025-08-24 17:04:41', '2025-08-24 17:04:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rols`
--

CREATE TABLE `rols` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rols`
--

INSERT INTO `rols` (`id`, `name`, `createdAt`, `updatedAt`) VALUES
(1, 'Admin', '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(2, 'Coordinador', '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(3, 'Instructor', '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(4, 'Aprendiz', '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(5, 'Profesional Bienestar', '2025-08-24 17:04:41', '2025-08-24 17:04:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sequelizemeta`
--

CREATE TABLE `sequelizemeta` (
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `sequelizemeta`
--

INSERT INTO `sequelizemeta` (`name`) VALUES
('20250819011000-create-rols.js'),
('20250819012000-create-users.js'),
('20250819013000-create-categories.js'),
('20250819014000-create-events.js');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `document` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `rolId` int(11) DEFAULT NULL,
  `passwordResetToken` varchar(255) DEFAULT NULL,
  `passwordResetExpires` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `userName`, `email`, `password`, `phone`, `birthdate`, `document`, `gender`, `state`, `rolId`, `passwordResetToken`, `passwordResetExpires`, `createdAt`, `updatedAt`) VALUES
(1, 'admin_master', 'admin@sistema.com', '123456', '3001234567', '1990-01-01', '1002003001', 'M', '1', 1, NULL, NULL, '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(2, 'coordinador_01', 'coordinador@sistema.com', '123456', '3012345678', '1985-05-10', '1002003002', 'F', '1', 2, NULL, NULL, '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(3, 'instructor_01', 'instructor@sistema.com', '123456', '3023456789', '1992-03-15', '1002003003', 'M', '1', 3, NULL, NULL, '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(4, 'aprendiz_01', 'aprendiz@sistema.com', '123456', '3034567890', '2002-07-20', '1002003004', 'F', '1', 4, NULL, NULL, '2025-08-24 17:04:41', '2025-08-24 17:04:41'),
(5, 'bienestar_01', 'bienestar@sistema.com', '123456', '3045678901', '1988-11-11', '1002003005', 'F', '1', 5, NULL, NULL, '2025-08-24 17:04:41', '2025-08-24 17:04:41');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoryId` (`categoryId`),
  ADD KEY `userId` (`userId`);

--
-- Indices de la tabla `rols`
--
ALTER TABLE `rols`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sequelizemeta`
--
ALTER TABLE `sequelizemeta`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rolId` (`rolId`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `rols`
--
ALTER TABLE `rols`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `events_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`rolId`) REFERENCES `rols` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
