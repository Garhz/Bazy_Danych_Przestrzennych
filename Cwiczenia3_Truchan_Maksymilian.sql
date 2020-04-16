create database cw3;
CREATE EXTENSION postgis;
CREATE TABLE budynki
(
    id serial,
    geometria geometry,
    nazwa varchar(20),
    wysokosc double precision,
    CONSTRAINT budynki_id PRIMARY KEY (id)
);



CREATE TABLE drogi
(
    id serial,
    geometria geometry,
    nazwa varchar(20),
    CONSTRAINT drogi_pk PRIMARY KEY (id)
);



CREATE TABLE pktinfo
(
    id serial,
    geometria geometry,
    nazwa varchar(20),
    liczprac integer,
    CONSTRAINT pktinfo_pk PRIMARY KEY (id)
);

insert into budynki (geometria , nazwa , wysokosc ) values (ST_GeomFromText('Polygon((8 4, 10.5 4, 10.5 1.5, 8 1.5, 8 4))'), 'Building A' , 20);
insert into budynki (geometria, nazwa, wysokosc) values (ST_GeomFromText('Polygon((6 7, 6 5, 4 5, 4 7, 6 7))'), 'Building B' , 18);
insert into budynki (geometria, nazwa, wysokosc) values (ST_GeomFromText('Polygon((3 8, 5 8, 5 6, 3 6, 3 8))'), 'Building C' , 10);
insert into budynki (geometria, nazwa, wysokosc) values (ST_GeomFromText('Polygon((9 9, 10 9, 10 8, 9 8, 9 9))'), 'Building D' , 5);
insert into budynki (geometria, nazwa, wysokosc) values (ST_GeomFromText('Polygon((1 2, 2 2, 2 1, 1 1, 1 2))'), 'Building F' , 6);

insert into drogi(geometria, nazwa) values (ST_GeomFromText('LineString(0 4.5, 12 4.5)'), 'Road X');
insert into drogi(geometria, nazwa) values (ST_GeomFromText('LineString(7.5 0, 7.5 10.5)'), 'Road Y');

insert into pktinfo (geometria, nazwa, liczprac) values (ST_GeomFromText('Point(1 3.5)'), 'G', 3);
insert into pktinfo (geometria, nazwa, liczprac) values (ST_GeomFromText('Point(5.5 1.5)'), 'H', 4);
insert into pktinfo (geometria, nazwa, liczprac) values (ST_GeomFromText('Point(9.5 6)'), 'I', 5);
insert into pktinfo (geometria, nazwa, liczprac) values (ST_GeomFromText('Point(6.5 6)'), 'J', 3);
insert into pktinfo (geometria, nazwa, liczprac) values (ST_GeomFromText('Point(6 9.5)'), 'K', 4);

SELECT sum(ST_Length(ST_Intersection(geometria,geometria)))
FROM drogi
WHERE ST_Intersects(geometria,geometria) ;

select geometria as WTK, St_area(geometria) as pole, st_perimeter(geometria) as obwod 
from budynki
where nazwa='Building A';

select nazwa, St_area(geometria) as pole 
from budynki
order by nazwa;

select nazwa, St_perimeter(geometria) as obwod
from budynki
order by st_area(geometria) desc 
limit 2;

select st_distance(pktinfo.geometria, budynki.geometria) as Odleglosc
from budynki, pktinfo
where budynki.nazwa='Building C' and pktinfo.nazwa='G';

select st_area(geometria) - st_area(St_Intersection(geometria, St_buffer('Polygon((6 7, 6 5, 4 5, 4 7, 6 7))', 0.5, 'join=mitre')))
from budynki
where nazwa='Building C';

select budynki.nazwa
from budynki , drogi
where st_y(st_centroid(budynki.geometria))>st_y(st_centroid(drogi.geometria)) and drogi.nazwa='Road X';

select st_area(geometria) - 2* st_area(st_intersection(geometria, 'Polygon((4 7, 6 7, 6 8, 4 8, 4 7))')) + st_area('Polygon((4 7, 6 7, 6 8, 4 8, 4 7))') as pole
from budynki
where nazwa='Building C';
