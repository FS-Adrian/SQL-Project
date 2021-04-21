USE PeliculasSalas
--Unidad 4 
/*
	REQUISITOS:
	-Dejar unas cuantas peliculas sin calificar
	-Dejar salas sin peliculas
	-Las calificaciones son numericas y tiene que tener minimo una edad por ejemplo 7, 13, 0 */
CREATE TABLE PELICULAS(
						Codigo INT IDENTITY PRIMARY KEY,
						Nombre NVARCHAR(100),
						CalificacionEdad INT
						);

CREATE TABLE SALAS(
					Codigo INT IDENTITY PRIMARY KEY,
					Nombre NVARCHAR(100),
					Pelicula INT
					FOREIGN KEY (Pelicula) REFERENCES PELICULAS(Codigo)
					);


INSERT INTO PELICULAS VALUES ('Rise of the Planet of the Apes',0),
							 ('Minions',0),
							 ('The Snowman',8),
							 ('Iron Man',8),
							 ('Me Before You',13),
							 ('Justice League',13),
							 ('Naked',15),
							 ('Psycho',15),
							 ('Daddys Home',18),
							 ('It',18)

INSERT INTO SALAS VALUES 	 ('Sala1',1),
							 ('Sala2',2),
							 ('Sala3',3),
							 ('Sala4',4),
							 ('Sala5',5),
							 ('Sala6',6),
							 ('Sala7',7),
							 ('Sala8',8),
							 ('Sala9',9)
INSERT INTO PELICULAS VALUES ('HarryPotter',NULL)
INSERT INTO SALAS VALUES ('Sala10',Null)

SELECT * FROM SALAS
SELECT * FROM PELICULAS

--4.1 Mostrar el nombre de todas las peliculas
SELECT Nombre FROM PELICULAS

--4.2 Mostrar las distintas calificaciones de edad que existen
SELECT DISTINCT CalificacionEdad FROM PELICULAS

--4.3 Mostrar todas las peliculas que no han sido calificadas
SELECT * FROM PELICULAS WHERE CalificacionEdad IS NULL
--Nota: Todas estan calificadas no se puede dejar con valores vacios porque al subirla a la tabla te da error, hay que poner Null para que lo tome sin calificacion 

--4.4 Mostrar todas las salas que no proyectan ni una pelicula, pasa lo mismo que arriba
SELECT * FROM SALAS WHERE Pelicula IS NULL

--4.5 Mostrar la informacion de todas las salas y si se proyecta alguna pelicula en la sala, mostrar tambien la informacion de la pelicula
SELECT * FROM SALAS LEFT JOIN PELICULAS ON SALAS.Pelicula = PELICULAS.Codigo

--4.6 Mostrar la informacion de todas las peliculas y si se proyecta en alguna sala mostrar tambien la informacion de la sala
SELECT * FROM SALAS RIGHT JOIN PELICULAS ON SALAS.Pelicula = PELICULAS.Codigo
--4.7 Mostrar los nombres de las peliculas que no se proyectan en ninguna sala Con JOIN Y Subconsulta respectivamente
SELECT PELICULAS.Nombre FROM SALAS RIGHT JOIN PELICULAS ON SALAS.Pelicula = PELICULAS.Codigo WHERE SALAS.Pelicula IS NULL

SELECT Nombre FROM PELICULAS WHERE Codigo NOT IN (SELECT Pelicula FROM SALAS WHERE Pelicula IS NOT NULL)

--4.8 Añadir una nueva pelicula 'Uno, Dos, Tres' para mayores de 7 años
INSERT INTO PELICULAS(Nombre,CalificacionEdad) VALUES('Un, Deux,Trois', 7) 

--4.9 Hacer Constar que todas las peliculas no calificadas han sido calificadas como no recomendables para menores de 13 años
UPDATE PELICULAS SET CalificacionEdad=13 WHERE CalificacionEdad IS NULL

--4.10 Eliminar todas las salas que proyectan peliculas recomendadas para todos los publicos
DELETE FROM SALAS WHERE Pelicula IN (SELECT Codigo FROM PELICULAS WHERE CalificacionEdad = 0)

