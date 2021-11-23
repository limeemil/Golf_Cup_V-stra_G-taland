drop database Golf_Cup_Västra_Götaland;
create database Golf_Cup_Västra_Götaland;
use Golf_Cup_Västra_Götaland;



create table spelare(
	personnr char(13),
    namn varchar(20),
    ålder int,
    primary key(personnr)
)engine=InnoDB;

create table tävling(
	tävlingsnamn varchar(30),
    datum date,
    primary key(tävlingsnamn)
)engine=InnoDB;

create table regn(
	typ varchar(20),
    vindstyrka double,
    primary key(typ)
)engine=InnoDB;

create table konstruktion(
	serienr char(13),
    hårdhet int,
    primary key(serienr)
)engine=InnoDB;

create table jacka(
	modell varchar(20),
    storlek char(13),
    material varchar(20),
    s_personnr char(13),
    primary key(s_personnr, modell),
    foreign key(s_personnr) references spelare(personnr)
    on delete cascade
)engine=InnoDB;

create table klubba(
	klubbnr char(13),
    material varchar(20),
    s_personnr char(13),
    k_serienr char(13) null unique,
    primary key(klubbnr, s_personnr),
    foreign key(s_personnr) references spelare(personnr)
    on delete cascade
)engine=InnoDB;

create table deltagande(
	s_personnr char(13),
    tävlingsnamn varchar(30),
    primary key(s_personnr, tävlingsnamn),
    foreign key(s_personnr) references spelare(personnr)
    on delete cascade,
    foreign key(tävlingsnamn) references tävling(tävlingsnamn)
    on delete cascade
)engine=InnoDB;

create table tävlingsväder(
	tävlingsnamn varchar(30),
    regntyp varchar(20),
    tidpunkt datetime,
    primary key(tävlingsnamn, regntyp),
    foreign key(tävlingsnamn) references tävling(tävlingsnamn)
    on delete cascade,
    foreign key(regntyp) references regn(typ)
    on delete cascade
)engine=InnoDB;

insert into `golf_cup_västra_götaland`.`spelare` (`personnr`, `namn`, `ålder`) values ('199603142554', 'Johan Andersson', '25');
insert into `golf_cup_västra_götaland`.`spelare` (`personnr`, `namn`, `ålder`) values ('198609282574', 'Nicklas Jansson', '35');
insert into `golf_cup_västra_götaland`.`spelare` (`personnr`, `namn`, `ålder`) values ('199110014343', 'Annika Persson', '30');

insert into `golf_cup_västra_götaland`.`tävling` (`tävlingsnamn`, `datum`) values ('Big Golf Cup Skövde', '2021-06-10');

insert into `golf_cup_västra_götaland`.`deltagande` (`s_personnr`, `tävlingsnamn`) values ('199603142554', 'Big Golf Cup Skövde');
insert into `golf_cup_västra_götaland`.`deltagande` (`s_personnr`, `tävlingsnamn`) values ('198609282574', 'Big Golf Cup Skövde');
insert into `golf_cup_västra_götaland`.`deltagande` (`s_personnr`, `tävlingsnamn`) values ('199110014343', 'Big Golf Cup Skövde');

insert into `golf_cup_västra_götaland`.`regn` (`typ`, `vindstyrka`) values ('hagel', '10');

insert into `golf_cup_västra_götaland`.`tävlingsväder` (`tävlingsnamn`, `regntyp`, `tidpunkt`) 
	values ('Big Golf Cup Skövde', 'hagel', '2021-06-10 12:00:00');

insert into `golf_cup_västra_götaland`.`jacka` (`modell`, `storlek`, `material`, `s_personnr`) 
	values ('Ralph Lauren', 'medium', 'fleece', '199603142554');
insert into `golf_cup_västra_götaland`.`jacka` (`modell`, `storlek`, `material`, `s_personnr`) 
	values ('Monel', 'medium', 'goretex', '199603142554');
insert into `golf_cup_västra_götaland`.`jacka` (`modell`, `storlek`, `material`, `s_personnr`) 
	values ('Monel', 'medium', 'goretex', '199110014343');

insert into `golf_cup_västra_götaland`.`konstruktion` (`serienr`, `hårdhet`) values ('123', '10');
insert into `golf_cup_västra_götaland`.`konstruktion` (`serienr`, `hårdhet`) values ('456', '5');
    
insert into `golf_cup_västra_götaland`.`klubba` (`klubbnr`, `material`, `s_personnr`, `k_serienr`) 
	values ('1', 'trä', '198609282574', '123');
insert into `golf_cup_västra_götaland`.`klubba` (`klubbnr`, `material`, `s_personnr`, `k_serienr`) 
	values ('1', 'trä', '199110014343', '456');
insert into `golf_cup_västra_götaland`.`klubba` (`klubbnr`, `material`, `s_personnr`, `k_serienr`) 
	values ('2', 'järn', '199603142554', '789');
insert into `golf_cup_västra_götaland`.`klubba` (`klubbnr`, `material`, `s_personnr`) 
	values ('6', 'järn', '199603142554');

/*Operation 1*/
select ålder from spelare where namn='Johan Andersson';

/*Operation 2*/
select datum from tävling where tävlingsnamn='Big Golf Cup Skövde';

/*Operation 3*/
select klubba.material from klubba 
join spelare on klubba.s_personnr=spelare.personnr
where spelare.namn='Johan Andersson';

/*Operation 4*/
select * from jacka
join spelare on jacka.s_personnr=spelare.personnr
where spelare.namn='Johan Andersson';

/*Operation 5*/
select * from spelare
join deltagande on spelare.personnr=deltagande.s_personnr
where deltagande.tävlingsnamn='Big Golf Cup Skövde';

/*Operation 6*/
select vindstyrka from regn
join tävlingsväder on regn.typ=tävlingsväder.regntyp
where tävlingsväder.tävlingsnamn='Big Golf Cup Skövde';

/*Operation 7*/
select * from spelare where ålder<30;

/*Operation 8*/
delete jacka from jacka
join spelare on jacka.s_personnr=spelare.personnr
where spelare.namn='Johan Andersson';
select * from jacka;

/*Operation 9*/

set sql_safe_updates = 0;
delete spelare from spelare 
where namn='Nicklas Jansson';
set sql_safe_updates = 1;
select * from spelare;

/*Operation 10*/
select avg(ålder) from spelare;