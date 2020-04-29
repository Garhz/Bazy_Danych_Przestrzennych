SELECT count(*) as liczba_budynkow FROM popp, majrivers WHERE Contains(Buffer(majrivers.Geometry,100000), popp.Geometry);

CREATE TABLE tableB AS SELECT popp.PKUID, popp.Geometry, popp.cat, popp.F_CODEDESC, popp.F_CODE, popp.TYPE FROM popp, majrivers WHERE Contains(Buffer(majrivers.Geometry, 100000), popp.Geometry) AND popp.F_CODEDESC='Building'; 

CREATE TABLE airportsNew (
    NAME VARCHAR(80),
    Geometry BLOB,
    ELEV DOUBLE
)

INSERT INTO airportsNEW SELECT NAME, Geometry, ELEV FROM airports;

SELECT MbrMaxY(Geometry), NAME, ELEV FROM airportsNew LIMIT 1;
SELECT MbrMinY(Geometry), NAME, ELEV FROM airportsNew LIMIT 1;

INSERT INTO airportsNEW(NAME, Geometry, ELEV) VALUES('airportB', (0.5*Distance((SELECT Geometry FROM airportsNew WHERE NAME='NOATAK'),(SELECT Geometry FROM airportsNew WHERE NAME='NIKOLSKI AS'))), (SELECT avg(ELEV) FROM airportsNew WHERE NAME="NIKOLSKI AS" OR NAME="NOATAK"));

SELECT Area(Buffer((ShortestLine(lakes.Geometry, airports.Geometry)),1000)) FROM lakes, airports WHERE lakes.NAMES='Iliamma Lake' AND airports.NAME='AMBLER';


SELECT SUM(Area(Intersection(tundra.Geometry, trees.Geometry))) as "tundra", SUM(Area(Intersection(swamp.Geometry, trees.Geometry))) AS "bagna", VEGDESC FROM swamp, trees, tundra GROUP BY  VEGDESC;