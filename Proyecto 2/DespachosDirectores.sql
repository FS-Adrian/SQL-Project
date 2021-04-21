USE Directores
/*
	Requisitos:
	-Dejar un DNIJefe como Null
	-Llenar un despacho dandole poca capacidad y muchos directores
	-Darle apellido Perez a varios Directores
	-Dejar un despacho vacio
*/

CREATE TABLE DESPACHOS(
						Numero INT PRIMARY KEY,
						Capacidad INT
						);

CREATE TABLE DIRECTORES(
						DNI VARCHAR(8) PRIMARY KEY,
						NomApels NVARCHAR(255),
						DNIJefe VARCHAR(8),
						FOREIGN KEY (DNIJefe) REFERENCES DIRECTORES(DNI),
						Despacho INT,
						FOREIGN KEY (Despacho) REFERENCES DESPACHOS(Numero) 
						);


INSERT INTO DESPACHOS VALUES (1,2),
							 (2,4),
							 (3,6),
							 (4,8),
							 (5,10),
							 (6,12),
							 (7,NULL),
							 (124,1)

INSERT INTO DIRECTORES VALUES ('25157751','Valero Perez',NULL,1),
							  ('27786855','Odalys Perez','88536599',1),
							  ('88536599','Modesta Wilfredo','68744175',2),
							  ('68744175','Mireia Perez','78259625',1),
							  ('78259625','Ercilia Teodosio',NULL,2),
							  ('82216186','Asunción Roque','25157751',2),
							  ('93165647','Tomasa Jimena',NULL,2),
							  ('18774865','Olimpia Roberta','93165647',3),
							  ('13318784','Milagros Gloria','93165647',3),
							  ('56621624','Teodoro Candelario','56621624',4),
							  ('97726429','Rogelio Dorotea',NULL,4),
							  ('29766373','Augusto Maximino','26744964',5),
							  ('26744964','Perpetua Cruz',NULL,5),
							  ('19933652','Eutimio Tadeo','11752315',6),
							  ('11752315','Patricio Adelaida',NULL,6),
							  ('74568521','Missael Rivera',NULL,124)

--5.1 Mostrar DNI Nombre y Apellidos de todos los directores
SELECT DNI, NomApels FROM DIRECTORES

--5.2 Mostrar los datos de los directores que no tienen jefes
SELECT * FROM DIRECTORES WHERE DNIJefe IS NULL

--5.3 Mostrar el nombre y apellidos de cada director junto con la capacidad del despacho en el que se encuentra 
SELECT NomApels, Despacho, Capacidad FROM DIRECTORES INNER JOIN DESPACHOS ON Directores.Despacho = DESPACHOS.Numero

--5.4 Mostrar el numero de directores que hay en cada despacho
--Ignorando despachos vacios
SELECT Despacho, COUNT(*) FROM DIRECTORES GROUP BY Despacho
--Tomando en cuenta despachos vacios
SELECT Numero, COUNT(DNI) FROM DESPACHOS LEFT JOIN DIRECTORES ON DESPACHOS.Numero = DIRECTORES.Despacho GROUP BY Numero


--5.5 Mostrar los datos de los directores cuyos jefes no tienen jefes
SELECT * FROM DIRECTORES WHERE DNIJefe IN (SELECT DNI FROM DIRECTORES WHERE DNIJefe IS NULL)

--5.6 Mostrar los nombres y apellidos de los directores junto con los de su jefe
--Con INNER JOIN
SELECT d1.NomApels, d2.NomApels FROM DIRECTORES d1 INNER JOIN DIRECTORES d2 ON d1.DNIJefe = d2.DNI
--Recuerdas la llave foranea que aplicamos a la llave primaria de la misma tabla, al parecer se usa aqui 
--SIN INNER JOIN
SELECT d1.NomApels, d2.NomApels FROM DIRECTORES d1 LEFT JOIN DIRECTORES d2 ON d1.DNIJEFE = d2.DNI

--5.7 Mostrar el numero de despachos que estan sobreutilizados
SELECT Numero FROM DESPACHOS WHERE Capacidad < (SELECT COUNT(*) FROM DIRECTORES WHERE Despacho = Numero)
--Solo dejamos el despacho numero 1 sobrepoblado

--5.8 Añadir un nuevo director llamado Paco Perez con DNI 28301700 sin jefe y en el despacho 124 
INSERT INTO DIRECTORES VALUES('28301700','Paco Perez',NULL,124)
--Me daba error porque intentaba meterlo a un despacho que no existia

--5.9 Asignar a los Perez un jefe con DNI 74568521
UPDATE DIRECTORES SET DNIJefe = '74568521'	WHERE NomApels LIKE '%Perez%'
--Daba error, una vez mas: No puedes jugar con valores que no tienes. Primero se tienen que añadir todos los registros a la taba y luego modificarlos
SELECT * FROM DIRECTORES
--5.10 Despedir a todos los directores que no tienen jefe
DELETE FROM DIRECTORES WHERE DNIJefe IS NOT NULL

