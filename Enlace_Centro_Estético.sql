--Proyecto Enlace de Datos de BD Y POO--
/* 
Integrantes:
Bryan Daniel Cordova Alay
Ruth Pilar Jacome Icaza
*/

create database Enlace_Centro_Estético
go
use Enlace_Centro_Estético
go
-- Tabla 1 --
create table Centro_estetico
(idcent int primary key identity,
nombre_cent varchar(50),
direccion_cent varchar(50))
go
-- Procedimientos almacenados --
create procedure Insertar_Centro
@nombre_cent varchar(50), @direccion_cent varchar(50)
as
insert Centro_estetico(nombre_cent, direccion_cent)
	values (@nombre_cent, @direccion_cent)
go
insert Centro_estetico (nombre_cent, direccion_cent)
values ('OASIS','LOS SAUCES')
execute Insertar_Centro 'LAS MARIANAS','AV CASTRO'
execute Insertar_Centro 'LAURA SA','LOS CEIVOS'
Select * from Centro_estetico
go
create procedure Modificar_Centro
@idcent int, @nombre_cent varchar(50),
@direccion_cent varchar(50)
as
UPDATE [dbo].[Centro_estetico]
	SET [nombre_cent] = @nombre_cent,
		[direccion_cent] = @direccion_cent
	WHERE idcent = @idcent
go
create procedure Consultar_Centro
@nombre_cent varchar(50)
as
select * from Centro_estetico
where nombre_cent like '%'+@nombre_cent+'%'
go 
create procedure Eliminar_Centro
@idcent int
as
delete from Centro_estetico where idcent = @idcent
go
-- Tabla 2 --
create table Tipo
(idtipo int primary key identity,
idcent int references Centro_estetico(idcent),
tipo varchar(50))
go
-- Procedimientos almacenados --
create procedure Insertar_Tipo
@idcent int, @tipo varchar(50)
as
insert Tipo(idcent, tipo)
	values (@idcent, @tipo)
go
create procedure Modificar_Tipo
@idtipo int, @idcent int, @tipo varchar(50)
as
UPDATE [dbo].[Tipo]
	SET [idcent] = @idcent,
		[tipo] = @tipo
	WHERE idtipo = @idtipo
go
create procedure Consultar_Tipo
@tipo varchar(50)
as
select idtipo,tipo,nombre_cent
from Tipo T, Centro_estetico C
where tipo like '%'+@tipo+'%'
and T.idcent = C.idcent  
select * from Tipo
where tipo like '%'+@tipo+'%'
go 
create procedure Eliminar_Tipo
@idtipo int
as
delete from Tipo where idtipo = @idtipo
go
execute Consultar_Tipo ''
go
-- Tabla 3 --
create table Empleado
(
idemple int primary key identity,
idcent int references Centro_estetico(idcent),
nombre_emple varchar(50),
direccion_emple varchar(50),
telefono_emple int
)
go
-- Procedimientos almacenados --
create procedure Insertar_Empleado
@idcent int, @nombre_emple varchar(50), @direccion_emple varchar(50), 
@telefono_emple int
as
insert Empleado(idcent, nombre_emple, direccion_emple, telefono_emple)
	values (@idcent, @nombre_emple, @direccion_emple, @telefono_emple)
go
create procedure Modificar_Empleado
@idemple int, @idcent int, @nombre_emple varchar(50),
@direccion_emple varchar(50), @telefono_emple int
as
UPDATE [dbo].[Empleado]
	SET [idcent] = @idcent,
		[nombre_emple] = @nombre_emple,
		[direccion_emple] = @direccion_emple,
		[telefono_emple] = @telefono_emple
	WHERE idemple = @idemple
go
create procedure Consultar_Empleado
@nombre_emple varchar(50)
as
select idemple,nombre_cent,nombre_emple,direccion_emple,telefono_emple
from Empleado E, Centro_estetico C
where nombre_emple like '%'+@nombre_emple+'%'
and E.idcent = C.idcent
go 
create procedure Eliminar_Empleado
@idemple int
as
delete from Empleado where idemple = @idemple
go
execute Consultar_Empleado ''
go
-- Tabla 4 --
create table Pago_Empleado
(
idpago int primary key identity,
idemple int references Empleado(idemple),
pago real, fecha_pago date
)
go
-- Procedimientos almacenados --
create procedure Insertar_Pago_Empleado
@idemple int, @pago real, @fecha_pago date
as
insert Pago_Empleado (idemple, pago, fecha_pago)
	values (@idemple, @pago, @fecha_pago)
go
create procedure Modificar_Pago_Empleado
@idpago int, @idemple int, @pago real, @fecha_pago date
as
UPDATE [dbo].[Pago_Empleado]
	SET [idemple] = @idemple,
		[pago] = @pago,
		[fecha_pago] = @fecha_pago
	WHERE idpago = @idpago
go
create procedure Consultar_Pago_Empleado
@nombre_emple varchar(50)
as
select idpago,nombre_emple,pago, fecha_pago
from Pago_Empleado, Empleado
where nombre_emple like '%'+@nombre_emple+'%'
and Pago_Empleado.idemple = Empleado.idemple  
go 
create procedure Eliminar_Pago_Empleado
@idpago int
as
delete from Pago_Empleado where idpago = @idpago
go
execute Consultar_Pago_Empleado ''
go
-- Tabla 5 --
create table Cliente
(
idclien int primary key identity,
idcent int references Centro_estetico(idcent),
nombre_clien varchar(50),
numero_clien int,
direccion_clien varchar(50)
)
go
-- Procedimientos almacenados --
create procedure Insertar_Cliente
@idcent int, @nombre_clien varchar(50), @numero_clien int, 
@direccion_clien varchar(50)
as
insert Cliente(idcent, nombre_clien, numero_clien, direccion_clien)
	values (@idcent, @nombre_clien, @numero_clien, @direccion_clien)
go
create procedure Modificar_Cliente
@idclien int, @idcent int, @nombre_clien varchar(50), 
@numero_clien int,@direccion_clien varchar(50)
as
UPDATE [dbo].[Cliente]
	SET [idcent] = @idcent,
		[nombre_clien] = @nombre_clien,
		[numero_clien] = @numero_clien,
		[direccion_clien] = @direccion_clien
	WHERE idclien = @idclien
go
create procedure Consultar_Cliente
@nombre_clien varchar(50)
as
select idclien,nombre_cent,nombre_clien,numero_clien,direccion_clien
from Cliente CL, Centro_estetico C
where nombre_clien like '%'+@nombre_clien+'%'
and CL.idcent = C.idcent
go 
create procedure Eliminar_Cliente
@idclien int
as
delete from Cliente where idclien = @idclien
go
execute Consultar_Cliente ''
go
-- Tabla 6 --
create table Atencion
(
idaten int primary key identity,
idclien int references Cliente(idclien),
atencion varchar(50),
costo_aten real,
metodo_pago bit
)
go
-- Procedimientos almacenados --
create procedure Insertar_Atencion
@idclien int, @atencion varchar(50),
@costo_aten real, @metodo_pago bit
as
insert Atencion(idclien, atencion, costo_aten, metodo_pago)
	values (@idclien, @atencion, @costo_aten, @metodo_pago)
go
create procedure Modificar_Atencion
@idaten int, @idclien int, @atencion varchar(50),
@costo_aten real, @metodo_pago bit
as
UPDATE [dbo].[Atencion]
	SET [idclien] = @idclien,
		[atencion] = @atencion,
		[costo_aten] = @costo_aten,
		[metodo_pago] = @metodo_pago
	WHERE idaten = @idaten
go
create procedure Consultar_Atencion
@nombre_clien varchar(50)
as
select idaten,nombre_clien,atencion,costo_aten,metodo_pago 
from Atencion, Cliente
where nombre_clien like '%'+@nombre_clien+'%'
and Atencion.idclien = Cliente.idclien
go 
create procedure Eliminar_Atencion
@idaten int
as
delete from Atencion where idaten = @idaten
go
execute Consultar_Atencion ''
go
-- Tabla 7 --
create table Articulo
(
idart int primary key identity,
idtipo int references Tipo(idtipo),
articulo varchar(50)
)
go
-- Procedimientos almacenados --
create procedure Insertar_Articulo
@idtipo int, @articulo varchar(50)
as
insert Articulo(idtipo, articulo)
	  values (@idtipo, @articulo)
go
create procedure Modificar_Articulo
@idart int, @idtipo int, @articulo varchar(50)
as
UPDATE [dbo].[Articulo]
	SET [idtipo] = @idtipo,
		[articulo] = @articulo
	WHERE idart = @idart
go
create procedure Consultar_Articulo
@articulo varchar(50)
as
select idart,articulo,tipo
from Articulo A, Tipo T
where articulo like '%'+@articulo+'%'
and A.idtipo = T.idtipo
go 
create procedure Eliminar_Articulo
@idart int
as
delete from Articulo where idart = @idart
go
execute Consultar_Articulo ''
go
-- Tabla 8 --
create table Proveedor
(
idprov int primary key identity,
idart int references Articulo(idart),
nombre_prov varchar(50),
direccion_prov varchar(50)
)
go
-- Procedimientos almacenados --
create procedure Insertar_Proveedor
@idart int, @nombre_prov varchar(50), @direccion_prov varchar(50)
as
insert Proveedor(idart, nombre_prov, direccion_prov)
	values (@idart, @nombre_prov, @direccion_prov)
go
create procedure Modificar_Proveedor
@idprov int, @idart int, @nombre_prov varchar(50), 
@direccion_prov varchar(50)
as
UPDATE [dbo].[Proveedor]
	SET [idart] = @idart,
		[nombre_prov] = @nombre_prov,
		[direccion_prov] = @direccion_prov
	WHERE idprov = @idprov
go
create procedure Consultar_Proveedor
@nombre_prov varchar(50)
as
select idprov,nombre_prov,direccion_prov,articulo
from Proveedor P, Articulo A
where nombre_prov like '%'+@nombre_prov+'%'
and P.idart = A.idart
go 
create procedure Eliminar_Proveedor
@idprov int
as
delete from Proveedor where idprov = @idprov
go
execute Consultar_Proveedor ''
go
-- Tabla 9 --
create table Compra
(
idcom int primary key identity,
idart int references Articulo(idart),
precio real,cantidad int
)
go
-- Procedimientos almacenados --
create procedure Insertar_Compra
@idart int, @precio real, @cantidad int
as
insert Compra(idart, precio, cantidad)
	values (@idart, @precio, @cantidad)
go
create procedure Modificar_Compra
@idcom int, @idart int, @precio real, @cantidad int
as
UPDATE [dbo].[Compra]
	SET [idart] = @idart,
		[precio] = @precio,
		[cantidad] = @cantidad
	WHERE idcom = @idcom
go
create procedure Consultar_Compra
@articulo varchar(50)
as
select idcom,articulo,precio,cantidad
from Compra, Articulo
where articulo like '%'+@articulo+'%'
and Compra.idart = Articulo.idart
go 
create procedure Eliminar_Compra
@idcom int
as
delete from Compra where idcom = @idcom
go
execute Consultar_Compra ''
go
-- Tabla 10 --
create table Detalle_Compra
(
iddetalle int primary key identity,
idcom int references Compra(idcom),
descripcion varchar(50),
fecha_compra date
)
go
-- Procedimientos almacenados --
create procedure Insertar_Detalle_Compra
@idcom int, @descripcion varchar(50), @fecha_compra date
as
insert Detalle_Compra(idcom, descripcion, fecha_compra)
	       values(@idcom, @descripcion, @fecha_compra)
go
create procedure Modificar_Detalle_Compra
@iddetalle int, @idcom int,@descripcion varchar(90),@fecha_compra date
as
UPDATE [dbo].[Detalle_Compra]
	SET [idcom] = @idcom,
		[descripcion] = @descripcion,
		[fecha_compra] = @fecha_compra
	WHERE iddetalle = @iddetalle
go
create procedure Consultar_Detalle_Compra
@descripcion varchar(90)
as
select iddetalle,descripcion,precio,total=(precio*cantidad),fecha_compra
from Detalle_Compra DC, Compra C, Articulo A
where descripcion like '%'+@descripcion+'%'
and DC.idcom = C.idcom
go 
create procedure Eliminar_Detalle_Compra
@iddetalle int
as
delete from Detalle_Compra where iddetalle = @iddetalle
go
execute Consultar_Detalle_Compra ''