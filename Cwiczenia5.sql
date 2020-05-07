CREATE database 299650cw5;
CREATE EXTENSION postgis;

CREATE TABLE obiekty(
geometria GEOMETRY NOT NULL,
nazwa varchar(50),
);
CREATE INDEX id ON obiekty (nazwa);

INSERT INTO obiekty(geometria, nazwa) 
VALUES(ST_GeomFromText('COMPOUNDCURVE(LINESTRING(0 1, 1 1), CIRCULARSTRING(1 1, 2 0, 3 1), CIRCULARSTRING(3 1, 4 2, 5 1), LINESTRING(5 1, 6 1))', -1), 'obiekt1');
INSERT INTO obiekty(geometria, nazwa) 
VALUES(ST_GeomFromText('CURVEPOLYGON(COMPOUNDCURVE(LINESTRING(10 6, 14 6), CIRCULARSTRING(14 6, 16 4, 14 2), CIRCULARSTRING(14 2, 12 0, 10 2), LINESTRING(10 2, 10 6)),CIRCULARSTRING(11 2, 12 1, 13 2, 12 3, 11 2))', -1),'obiekt2');
INSERT INTO obiekty(geometria, nazwa) 
VALUES(ST_GeomFromText('POLYGON((7 15, 10 17, 12 13, 7 15))',-1),'obiekt3');
INSERT INTO obiekty(geometria, nazwa) 
VALUES(ST_GeomFromText('LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)',-1),'obiekt4');
INSERT INTO obiekty(geometria, nazwa) 
VALUES(ST_GeomFromText('MULTIPOINT(30 30 59, 38 32 234)',-1),'obiekt5');
INSERT INTO obiekty(geometria, nazwa) 
VALUES(ST_GeomFromText('GEOMETRYCOLLECTION(POINT(4 2), LINESTRING(1 1, 3 2))',-1),'obiekt6');

SELECT ST_Area(ST_Buffer(ST_ShortestLine(obj0.geometria, obj1.geometria), 5)) 
FROM obiekty obj0, obiekty obj1 WHERE obj0.nazwa='obiekt3' AND obj1.nazwa='obiekt4';

SELECT ST_MakePolygon(ST_AddPoint(geometria, ST_StartPoint(geometria))) 
FROM obiekty WHERE nazwa='obiekt4';

INSERT INTO obiekty 
VALUES (ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(7 15, 10 17),LINESTRING(10 17, 12 13),LINESTRING(12 13, 7 15),LINESTRING(20 20, 25 25),LINESTRING(25 25, 27 24),LINESTRING(27 24, 25 22), LINESTRING(25 22, 26 21),LINESTRING(26 21, 22 19),LINESTRING(22 19, 20.5 19.5))', -1), 'obiekt7');

SELECT ST_Area(ST_Buffer(geometria, 5)) 
FROM obiekty WHERE ST_HasArc(geometria)=false;