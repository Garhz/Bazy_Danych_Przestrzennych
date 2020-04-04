

create database s299650;


CREATE SCHEMA firma;


CREATE ROLE ksiegowosc;
GRANT USAGE ON SCHEMA firma TO ksiegowosc;
GRANT SELECT on all tables in SCHEMA "firma" TO ksiegowosc;


CREATE TABLE firma.pracownicy (
    id_pracownika SERIAL,
    imie varchar(20)  NOT NULL,
    nazwisko varchar(40)  NOT NULL,
    adres varchar(60)  NOT NULL,
    telefon varchar(20)  NOT NULL,
    CONSTRAINT pracownicy_pk PRIMARY KEY (id_pracownika)
);


CREATE INDEX id_index ON firma.pracownicy (nazwisko);

CREATE TABLE firma.godziny (
    id_godziny SERIAL,
    data date  NOT NULL,
    liczba_godzin int  NOT NULL,
    id_pracownika int  NOT NULL,
    CONSTRAINT godziny_pk PRIMARY KEY (id_godziny)
);

ALTER TABLE firma.godziny ADD CONSTRAINT godziny_pracownicy
    FOREIGN KEY (id_pracownika)
    REFERENCES firma.pracownicy (id_pracownika)  
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

CREATE TABLE firma.pensja_stanowisko (
    id_pensji serial  NOT NULL,
    stanowisko varchar(30)  NOT NULL,
    kwota decimal(6,2)  NOT NULL,
    CONSTRAINT pensja_stanowisko_pk PRIMARY KEY (id_pensji)
);

CREATE TABLE firma.premia (
    id_premii serial  NOT NULL,
    rodzaj varchar(30)  NOT NULL,
    kwota decimal(6,2)  NOT NULL,
    CONSTRAINT premia_pk PRIMARY KEY (id_premii)
);

CREATE TABLE firma.wynagrodzenie (
    id_wynagrodzenia serial  NOT NULL,
    data date  NOT NULL,
    id_pracownika int  NOT NULL,
    id_godziny int  NOT NULL,
    id_pensji int  NOT NULL,
    id_premii int  NOT NULL,
    CONSTRAINT wynagrodzenie_pk PRIMARY KEY (id_wynagrodzenia)
);

ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT wynagrodzenie_godziny
    FOREIGN KEY (id_godziny)
    REFERENCES firma.godziny (id_godziny)  
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT wynagrodzenie_pensja_stanowisko
    FOREIGN KEY (id_pensji)
    REFERENCES firma.pensja_stanowisko (id_pensji)  
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT wynagrodzenie_pracownicy
    FOREIGN KEY (id_pracownika)
    REFERENCES firma.pracownicy (id_pracownika)  
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT wynagrodzenie_premia
    FOREIGN KEY (id_premii)
    REFERENCES firma.premia (id_premii)  
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

COMMENT ON TABLE firma.godziny
   IS 'Ile pracownik przepracowa³ godzin'

COMMENT ON TABLE firma.pensja_stanowisko 
   IS 'Pensja pracownika bez premii'

COMMENT ON TABLE firma.pracownicy
   IS 'Spis pracowników firmy'

COMMENT ON TABLE firma.premia
   IS 'Spis premii'

COMMENT ON TABLE firma.wynagrodzenie 
   IS 'Wynagrodzenie pracowników'






ALTER TABLE firma.godziny ADD miesiac int4 NOT NULL;
ALTER TABLE firma.godziny ADD tydzien int4 NOT NULL;



ALTER TABLE firma.wynagrodzenie ALTER COLUMN "data" TYPE varchar(20) USING "data"::varchar;



ALTER TABLE firma.premia ALTER COLUMN rodzaj DROP NOT NULL;
ALTER TABLE firma.wynagrodzenie ALTER COLUMN id_premii DROP NOT NULL;

INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Jan', 'Nowak', 'ul. Sloneczna 2', '689325673');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Wojciech', 'Kowalski', 'ul. Krakowska 61', '546865239');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Nikodem', 'Czech', 'ul. Sloneczna 21', '54523164543');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Aleksandra', 'Pietrzak', 'ul. Sloneczna 36', '6432464345');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Greta', 'Duch', 'ul. Mickiewicza 34', '586468653');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Janusz', 'Nowak', 'ul. Mickiewicza 342', '426897546');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Pawel', 'Wysocki', 'ul. Krakowska 12', '346776542');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Justyna', 'Luczak', 'ul. Dabrowska 43', '579435786');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Gabriela', 'Lesniak', 'ul. Obroncow Warszawy 56', '575325677');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Katarzyna', 'Czech', 'ul. Mickiewicza 56', '543126867');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Justyna', 'Nowak', 'ul. Krakowska 43', '764257234');

INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-17', 150, 11, extract(month from DATE '2020-03-17'), extract(week from DATE '2020-03-17'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-25', 160, 2, extract(month from DATE '2020-03-25'), extract(week from DATE '2020-03-25'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-02', 150, 5, extract(month from DATE '2020-03-02'), extract(week from DATE '2020-03-02'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-11', 145, 7, extract(month from DATE '2020-03-11'), extract(week from DATE '2020-03-11'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-06', 151, 1, extract(month from DATE '2020-03-06'), extract(week from DATE '2020-03-06'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-24', 120, 3, extract(month from DATE '2020-03-24'), extract(week from DATE '2020-03-24'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-19', 120, 9, extract(month from DATE '2020-03-19'), extract(week from DATE '2020-03-19'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-09', 110, 10, extract(month from DATE '2020-03-09'), extract(week from DATE '2020-03-09'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-07', 180, 4, extract(month from DATE '2020-03-07'), extract(week from DATE '2020-03-07'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-13', 130, 6, extract(month from DATE '2020-03-13'), extract(week from DATE '2020-03-13'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-12', 200, 8, extract(month from DATE '2020-03-12'), extract(week from DATE '2020-03-12'));


INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Prezes', 8000);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Kierownik', 7000);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Programista', 6100);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Konsultant', 3200);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Sekretarka', 1900);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Sprzataczka', 1700);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Tester', 2900);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Mlodszy Konsultant', 2500);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Praktykany', 500);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Asystent Programisty', 4500);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Starszy Konsultant', 4800);


INSERT INTO firma.premia (rodzaj, kwota) VALUES('Miesieczna', 500);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('Tygodniowa', 200);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('Dzienna', 50);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('Kwartalna', 1000);

INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-04-01', 1, 11, 1, 1);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-04-01', 2, 10, 11, 3);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-04-01', 3, 9, 2, 2);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-04-01', 4, 8, 10, 4);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-04-01', 5, 7, 3, 4);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-04-01', 6, 6, 9, 2);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-04-01', 7, 5, 4, 3);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-04-01', 8, 4, 8, 1);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-04-01', 9, 3, 5, 2);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-04-01', 10, 2, 7, 4);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-04-01', 11, 1, 6, 1);







SELECT id_pracownika, nazwisko FROM firma.pracownicy;



select firma.wynagrodzenie.id_pracownika from firma.wynagrodzenie join firma.pensja_stanowisko on firma.pensja_stanowisko.id_pensji = firma.wynagrodzenie.id_pensji join firma.premia on firma.premia.id_premii = firma.wynagrodzenie.id_premii where firma.premia.kwota+firma.pensja_stanowisko.kwota >1000;



select firma.wynagrodzenie.id_pracownika from firma.wynagrodzenie join firma.pensja_stanowisko on firma.pensja_stanowisko.id_pensji = firma.wynagrodzenie.id_pensji join firma.premia on firma.premia.id_premii = firma.wynagrodzenie.id_premii where firma.premia.kwota = 0 and firma.pensja_stanowisko.kwota > 2000;



select imie from firma.pracownicy where imie like 'J%';



select * from firma.pracownicy where nazwisko like '%n%' or nazwisko like '%N%' and imie like '%a';



select prac.imie, prac.nazwisko , case when god.liczba_godzin<160 then 0 else god.liczba_godzin-160 end as "nadgodziny" from firma.pracownicy prac join firma.godziny god on prac.id_pracownika = god.id_pracownika;



select prac.imie, prac.nazwisko from firma.pracownicy prac join firma.wynagrodzenie wyn on wyn.id_pracownika = prac.id_pracownika join firma.pensja_stanowisko pensja on wyn.id_pensji = pensja.id_pensji where pensja.kwota >= 1500 and pensja.kwota <= 3000;



select prac.imie, prac.nazwisko from firma.pracownicy prac join firma.godziny god on prac.id_pracownika = god.id_pracownika join firma.wynagrodzenie wyn on prac.id_pracownika = wyn.id_pracownika join firma.premia premia on wyn.id_premii = premia.id_premii where premia.kwota = 0 and god.liczba_godzin > 160;





select prac.*, pensja.kwota from firma.pracownicy prac join firma.wynagrodzenie wyn on prac.id_pracownika = wyn.id_pracownika join firma.pensja_stanowisko pensja on pensja.id_pensji = wyn.id_pensji order by pensja.kwota;



select prac.*, pen.kwota+pre.kwota as "wyplata" from firma.pracownicy prac join firma.wynagrodzenie wyn on prac.id_pracownika = wyn.id_pracownika join firma.pensja_stanowisko pen on pen.id_pensji = wyn.id_pensji join firma.premia pre on pre.id_premii = wyn.id_premiiorder by pen.kwota+pre.kwota desc;



select pen.stanowisko, count(pen.stanowisko) from firma.pensja_stanowisko pen join firma.wynagrodzenie wyn on pen.id_pensji = wyn.id_pensji join firma.pracownicy prac on prac.id_pracownika = wyn.id_pracownika group by pen.stanowisko;



select pen.stanowisko, avg(pen.kwota+pre.kwota), min(pen.kwota+pre.kwota), max(pen.kwota+pre.kwota) from firma.pensja_stanowisko pen join firma.wynagrodzenie wyn on pen.id_pensji = wyn.id_pensji join firma.premia pre on pre.id_premii = wyn.id_premii where pen.stanowisko = 'Prezes' group by pen.stanowisko;



select sum(pen.kwota+pre.kwota) as "Suma wynagrodzeñ" from firma.wynagrodzenie wyn join firma.pensja_stanowisko pen on wyn.id_pensji = pen.id_pensji join firma.premia pre on wyn.id_premii = pre.id_premii;



select pen.stanowisko, sum(pen.kwota+pre.kwota) as "Suma wynagrodzeñ" from firma.wynagrodzenie wyn join firma.pensja_stanowisko pen on wyn.id_pensji = pen.id_pensji join firma.premia pre on wyn.id_premii = pre.id_premii group by pen.stanowisko;



select pen.stanowisko, count(pre.kwota>0) as "Liczba premii" from firma.pensja_stanowisko pen join firma.wynagrodzenie wyn on pen.id_pensji = wyn.id_pensji join firma.premia pre on pre.id_premii = wyn.id_premii where pre.kwota > 0 group by pen.stanowisko;



delete from firma.pracownicy prac using firma.wynagrodzenie wyn, firma.pensja_stanowisko pen where prac.id_pracownika = wyn.id_pracownika and pen.id_pensji = wyn.id_pensji and pen.kwota < 1200;





UPDATE firma.pracownicy SET telefon=CONCAT('(+48) ', telefon);


UPDATE firma.pracownicy SET telefon=CONCAT(SUBSTRING(telefon, 1, 9), '-', substring(telefon, 10, 3), '-', substring(telefon, 13, 3));



select imie, upper(nazwisko) as "nazwisko", adres, telefon from firma.pracownicy where length(nazwisko) = (select max(length(nazwisko)) from firma.pracownicy);



select md5(prac.imie) as "imie", md5(prac.nazwisko) as "nazwisko", md5(prac.adres) as "adres", md5(prac.telefon) as "telefon", md5(cast(pen.kwota as varchar(20))) as "pensja" from firma.pracownicy prac join firma.wynagrodzenie wyn on wyn.id_pracownika = prac.id_pracownika join firma.pensja_stanowisko pen on pen.id_pensji = wyn.id_pensji;



select concat('Pracownik ', prac.imie, ' ', prac.nazwisko, ', w dniu ', wyn."data", ' otrzymal pensje calkowita na kwote ', pen.kwota+pre.kwota,'zl, gdzie wynagrodzenie zasadnicze wynosilo: ', pen.kwota, 'zl, premia: ', pre.kwota, 'zl. Liczba nadgodzin: ') as "raport" from firma.pracownicy prac join firma.wynagrodzenie wyn on prac.id_pracownika = wyn.id_pracownika join firma.pensja_stanowisko pen on pen.id_pensji = wyn.id_pensji join firma.premia pre on pre.id_premii = wyn.id_premii;
