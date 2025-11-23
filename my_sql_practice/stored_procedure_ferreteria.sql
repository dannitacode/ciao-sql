/* Crear procedimiento que permita: 
1. Agregar un proveedor nuevo.
2. Modificar un proveedor.
3. Eliminar un proveedor.
*/

-- 1
DROP PROCEDURE IF EXISTS agregarProveedor;
DELIMITER $$
CREATE PROCEDURE agregarProveedor(p_nombre VARCHAR(100), p_categoria VARCHAR(100), p_ciudad VARCHAR(100))
BEGIN
	INSERT INTO proveedores (
        nombre,
        categoria,
        ciudad
    ) VALUES (
		p_nombre,
		p_categoria,
		p_ciudad
    );
END$$
DELIMITER ;

-- 2
DROP PROCEDURE IF EXISTS modificarProveedor;
DELIMITER $$
CREATE PROCEDURE modificarProveedor(IN p_nombre VARCHAR(100), p_categoria VARCHAR(100), p_ciudad VARCHAR(100), p_nro INT)
BEGIN
	UPDATE proveedores 
    	SET nombre = p_nombre,
        categoria = p_categoria,
        ciudad = p_ciudad
   	WHERE nro = p_nro;
END$$
DELIMITER ;

-- 3
DROP PROCEDURE IF EXISTS eliminarProveedor;
DELIMITER $$
CREATE PROCEDURE eliminarProveedor(IN ped_nro INT, pro_nro INT)
BEGIN
	DELETE FROM pedidos
    	WHERE nrop = ped_nro;
    DELETE FROM proveedores 
    	WHERE nro = pro_nro;
END $$
DELIMITER ;

/* Crear procedimiento que permita: 
1. Agregar un item nuevo.
2. Modificar un item.
3. Eliminar un item.
*/

 -- 1
DROP PROCEDURE IF EXISTS agregarItem;
DELIMITER $$
CREATE PROCEDURE agregarItem(IN i_descripcion VARCHAR(200), i_ciudad VARCHAR(100))
BEGIN
	INSERT INTO items (
	descripcion,
    ciudad
    ) VALUES (
	i_descripcion,
    i_ciudad
    );
END$$
DELIMITER ;

-- 2
DROP PROCEDURE IF EXISTS modificarItem;
DELIMITER $$
CREATE PROCEDURE modificarItem(IN i_descripcion VARCHAR(200), i_ciudad VARCHAR(100), i_nro INT)
BEGIN
	UPDATE items 
	SET descripcion = i_descripcion,
    	ciudad = i_ciudad
	WHERE nro = i_nro;
END $$
DELIMITER ;

-- 3
DROP PROCEDURE IF EXISTS eliminarItem;
DELIMITER $$
CREATE PROCEDURE eliminarItem(IN ped_nro INT, i_nro INT)
BEGIN
	DELETE FROM pedidos
    	WHERE nrop = ped_nro;
    DELETE FROM items
		WHERE nro = i_nro;
END $$
DELIMITER ;

/* Crear procedimiento que permita:
1. Agregar un cliente nuevo.
2. Modificar un cliente.
3. Eliminar un cliente.
*/

 -- 1
DROP PROCEDURE IF EXISTS agregarCliente;
DELIMITER $$
CREATE PROCEDURE agregarCliente(IN c_nombre VARCHAR(100), c_ciudad VARCHAR(100))
BEGIN
	INSERT INTO clientes (
	nombre,
	ciudad
	) VALUES (
	c_nombre,
	c_ciudad
    );
END $$
DELIMITER ;

-- 2
DROP PROCEDURE IF EXISTS modificarCliente;
DELIMITER $$
CREATE PROCEDURE modificarCliente(IN c_nombre VARCHAR(100), c_ciudad VARCHAR(100), c_nro INT)
BEGIN
	UPDATE clientes 
    SET nombre = c_nombre,
    	ciudad = c_ciudad
    WHERE nro = c_nro;
END $$
DELIMITER ;

-- 3
DROP PROCEDURE IF EXISTS eliminarCliente;
DELIMITER $$
CREATE PROCEDURE eliminarCliente(IN ped_nro INT, c_nro INT)
BEGIN
	DELETE FROM pedidos
    	WHERE nrop = ped_nro;
    DELETE FROM clientes
    	WHERE nro = c_nro;
END $$
DELIMITER ;

/* Crear procedimiento que permita:
1. Agregar un pedido nuevo.
2. Modificar un pedido.
3. Eliminar un pedido.
*/

-- 1
DROP PROCEDURE IF EXISTS agregarPedido;
DELIMITER $$
CREATE PROCEDURE agregarPedido(IN pro_nro INT, c_nro INT, i_nro INT, ped_cantidad BIGINT, ped_precio double)
BEGIN
	INSERT INTO pedidos (
        nrop,
        nroc,
        nroi,
        cantidad,
        precio
    ) VALUES (
        pro_nro,
        c_nro,
		i_nro,
		ped_cantidad,
		ped_precio
    );
END $$
DELIMITER ;

-- 2
DROP PROCEDURE IF EXISTS modificarPedido;
DELIMITER $$
CREATE PROCEDURE modificarPedido(IN p_cantidad BIGINT, p_precio double, p_nrop INT, p_nroc INT, p_nroi INT)
BEGIN
    UPDATE pedidos
    SET
    	cantidad = p_cantidad,
        precio = p_precio
    WHERE
        nrop = p_nrop AND
        nroc = p_nroc AND
        nroi = p_nroi;
END $$
DELIMITER ;

-- 3
DROP PROCEDURE IF EXISTS eliminarPedido;
DELIMITER $$
CREATE PROCEDURE eliminarPedido(IN p_nro INT, IN i_nro INT, IN c_nro INT)
BEGIN
	DELETE FROM pedidos
    	WHERE nrop = p_nro;
   	DELETE FROM pedidos
    	WHERE nroc = c_nro;
    DELETE FROM pedidos
    	WHERE nroi = i_nro;
    DELETE FROM proveedores
    	WHERE nro = p_nro;
   	DELETE FROM clientes
    	WHERE nro = c_nro;
	DELETE FROM items
    	WHERE nro = i_nro;
END $$
DELIMITER ;

/* Crear una función que dado un proveedor nos retorne la
cantidad de ventas en las que participaron los ítems que el
provee, en el mes en curso.*/

DELIMITER $$
CREATE OR REPLACE FUNCTION cantidadItems(prov INT) RETURNS INT
BEGIN
DECLARE cantidad_items INT;
SELECT COUNT(nroi) INTO cantidad_items 
FROM pedidos
WHERE pedidos.nrop = prov AND fecha BETWEEN '2025-11-01' AND '2025-11-30';
RETURN cantidad_items;
END$$
DELIMITER ;