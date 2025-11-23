-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla clientes
--

DROP TABLE IF EXISTS clientes;
CREATE TABLE IF NOT EXISTS clientes (
  nro int NOT NULL AUTO_INCREMENT,
  nombre varchar(100) NOT NULL,
  ciudad varchar(100) NOT NULL,
  PRIMARY KEY (nro)
) ENGINE=InnoDB AUTO_INCREMENT=999;

--
-- Volcado de datos para la tabla clientes
--

INSERT INTO clientes (nro, nombre, ciudad) VALUES
(1, 'Raul', 'Cordoba'),
(2, 'pepito', 'San luis'),
(3, 'Juan Martinez', 'San miguel'),
(4, 'Carlos Perez', 'La punta'),
(5, 'Maria Pia', 'Cordoba'),
(6, 'Kevin ', 'Rosario'),
(7, 'Juan Martinez ch', 'Rosario'),
(8, 'Maria Pia  ch', 'San Luis'),
(9, 'Pepe ch', 'Rosario'),
(10, 'Maxi ch', 'Mendoza'),
(98, 'Juana', 'Mza');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla items
--

DROP TABLE IF EXISTS items;
CREATE TABLE IF NOT EXISTS items (
  nro int NOT NULL AUTO_INCREMENT,
  descripcion varchar(200) NOT NULL,
  ciudad varchar(100) NOT NULL,
  PRIMARY KEY (nro)
) ENGINE=InnoDB AUTO_INCREMENT=12;

--
-- Volcado de datos para la tabla items
--

INSERT INTO items (nro, descripcion, ciudad) VALUES
(1, 'Pinzas', 'Mendoza'),
(2, 'Caños', 'Salta'),
(3, 'Teflon', 'Mendoza'),
(4, 'Martillos', 'Buenos aires'),
(5, 'caños pvc', 'Mendoza'),
(6, 'Membrana', 'Carlos paz'),
(7, 'pinzasR ch', 'Rosario'),
(8, 'pinzasSL ch', 'San Luis'),
(9, 'pinzasM ch', 'mendoza'),
(10, 'MartilloSL ch', 'San Luis'),
(11, 'MartilloM ch', 'Mendoza');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

DROP TABLE IF EXISTS pedidos;
CREATE TABLE IF NOT EXISTS pedidos (
  nrop int NOT NULL,
  nroc int NOT NULL,
  nroi int NOT NULL,
  fecha timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  cantidad bigint NOT NULL,
  precio double NOT NULL,
  PRIMARY KEY (nrop,nroc,fecha,nroi),
  KEY nroi (nroi),
  KEY nroc (nroc),
  KEY nrop (nrop)
) ENGINE=InnoDB;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO pedidos (nrop, nroc, nroi, fecha, cantidad, precio) VALUES
(1, 2, 4, '2022-10-17 03:04:46', 1, 1400),
(1, 2, 4, '2022-10-17 03:04:47', 1, 1400),
(1, 2, 1, '2022-10-18 01:32:29', 5, 12351),
(1, 3, 1, '2022-10-18 02:04:37', 10, 15000),
(2, 1, 2, '2022-10-18 00:53:29', 10, 45000),
(2, 6, 3, '2022-10-18 01:54:30', 2, 1100),
(3, 4, 3, '2022-10-18 01:33:53', 7, 6400),
(3, 5, 4, '2022-10-18 01:32:34', 1, 1000),
(4, 3, 4, '2022-10-18 02:03:49', 2, 6525),
(5, 7, 3, '2022-10-11 03:00:00', 9, 105),
(6, 10, 1, '2022-10-07 03:00:00', 8, 110),
(7, 7, 2, '2022-10-11 03:00:00', 9, 105),
(7, 8, 2, '2022-10-10 03:00:00', 10, 300),
(7, 10, 4, '2022-10-03 03:00:00', 8, 110);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla proveedores
--

DROP TABLE IF EXISTS proveedores;
CREATE TABLE IF NOT EXISTS proveedores (
  nro int NOT NULL AUTO_INCREMENT,
  nombre varchar(100) NOT NULL,
  categoria varchar(100) NOT NULL,
  ciudad varchar(100) NOT NULL,
  PRIMARY KEY (`nro`)
) ENGINE=InnoDB AUTO_INCREMENT=11;

--
-- Volcado de datos para la tabla proveedores
--

INSERT INTO proveedores (nro, nombre, categoria, ciudad) VALUES
(1, 'Williams', 'Herramientas', 'San luis'),
(2, 'Aylin', 'Cloacas', 'Mendoza'),
(3, 'Mario Pastore', 'Herramientas', 'San juan'),
(4, 'juan', 'PINTURA', 'LA TOMA'),
(5, 'Mario Pastore ch', 'Herramientas', 'San Luis'),
(6, 'Pepe Herramientas ch', 'Herramientas', 'Mendoza'),
(7, 'juana', ':p_categoria', ':p_ciudad'),
(9, 'AS', ':p_categoria', ':p_ciudad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla tbl_error
--

DROP TABLE IF EXISTS tbl_error;
CREATE TABLE IF NOT EXISTS tbl_error (
  error_id int NOT NULL AUTO_INCREMENT,
  codigo varchar(2000) NOT NULL,
  mensaje varchar(2000) NOT NULL,
  programa varchar(2000) NOT NULL,
  fecha datetime NOT NULL,
  usuario varchar(2000) NOT NULL,
  PRIMARY KEY (`error_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6;

--
-- Volcado de datos para la tabla tbl_error
--

INSERT INTO tbl_error (error_id, codigo, mensaje, programa, fecha, usuario) VALUES
(1, '12', 'msn', 'prg', '2025-06-13 23:05:14', 'root@localhost'),
(2, 'NO_EXISTE', 'Proveedor no encontrado', 'EliminarProveedor', '2025-06-13 23:41:17', 'root@localhost'),
(3, 'PEDIDOS_ASOCIADOS', 'Proveedor tiene pedidos asociados', 'EliminarProveedor', '2025-06-13 23:42:37', 'root@localhost'),
(4, 'EXITO', 'Proveedor \"Ferretería La Llave\" agregado correctamente', 'AgregarProveedor', '2025-06-13 23:56:10', 'root@localhost'),
(5, 'EXITO', 'Proveedor ID 8 modificado correctamente', 'ModificarProveedor', '2025-06-13 23:58:16', 'root@localhost');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla pedidos
--
ALTER TABLE pedidos
  ADD CONSTRAINT pedidos_ibfk_1 FOREIGN KEY (nroi) REFERENCES items (nro),
  ADD CONSTRAINT pedidos_ibfk_2 FOREIGN KEY (nroc) REFERENCES clientes (nro),
  ADD CONSTRAINT pedidos_ibfk_3 FOREIGN KEY (nrop) REFERENCES proveedores (nro);
