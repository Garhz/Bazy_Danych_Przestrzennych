--1
select sum(AREA_KM2) from trees where VEGDESC="Mixed Trees";
--3
select sum(cat) from railroads;
--4
select AVG(ELEV), COUNT(ID) from airports where USE="Military";
select COUNT(ID) from airports where USE="Military" AND ELEV>1400;
--5
select count(cat) from poppBristolBay;
--9
select sum(swamp.AREAKM2), sum(UproszczonaGeometriaSwamp.AREAKM2) from UproszczonaGeometriaSwamp, swamp;