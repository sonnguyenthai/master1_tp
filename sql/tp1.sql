create table Hotels (
NumHo decimal(10),
NomHo varchar(25),
RueAdrHo varchar(25),
VilleHo varchar(25),
NbEtoilesHo decimal(1),
constraint pk_hotels primary key (NumHo)
);

create table TypesChambre(
NumTy decimal(10),
NomTy varchar(25),
PrixTy decimal(10),
constraint pk_type primary key (NumTy)
);

create table Chambres(
NumCh decimal(10),
NumHo decimal(10) references Hotels,
Numty decimal(10) references TypesChambre,
constraint pk_chambre primary key (NumCh, NumHo)
);
 
create table Clients (
NumCl decimal(10),
NomCl varchar(25),
PrenomCl varchar(25),
RueAdrCl varchar(25),
VilleCl varchar(25),
constraint pk_client primary key (NumCl)
);

create table Reservations (
NumCl decimal(10),
NumHo decimal(10) references Hotels, 
NumTy decimal(10) references TypesChambre,
DateA timestamp(0),
Nbjours interval day to second(0) default interval'1' day not null check(Nbjours> interval '0' day),
NbChambres decimal(2),
constraint pk_reservation primary key (NumCl, NumHo, NumTy, DateA)
);

drop table Occupations purge;
create table Occupations (
NumCl decimal(10) references Clients not null,
NumHo decimal(10) ,
NumCh decimal(10) ,
DateA timestamp(0),
DateD timestamp(0),
constraint pk_occupation primary key (NumHo, NumCh, DateA)
);

insert into Hotels values (1, 'AB', 'rue numero 1', 'Marseille', 3);
insert into Hotels values (5, 'AA', 'rue numero xx 1', 'Marseille', 1);
insert into Hotels values (2, 'BB', 'rue numero 2', 'Lyon', 4);
insert into Hotels values (3, 'BB', 'rue numero 3', 'Paris', 5);
insert into Hotels values (4, 'BB', 'rue numero 4', 'Marseille', 2);


insert into Clients values(1, 'John', 'Smith', 'bd du nothing', 'Paris');
insert into Clients values(2, 'Alan', 'Smith', 'bd du a', 'Paris');
insert into Clients values(3, 'Tifa', 'Smith', 'bd du b', 'Marseille');
insert into Clients values(4, 'Cloud', 'Smith', 'bd du c', 'Marseille');
insert into Clients values(5, 'Vincent', 'Smith', 'bd du d', 'Nice');
insert into Clients values(6, 'Sep', 'Smith', 'bd du e', 'Toulon');
insert into Clients values(7, 'Nina', 'Smith', 'bd du f', 'Toulouse');

insert into TypesChambre values (1, 'X1', 10);
insert into TypesChambre values (2, 'X2', 20);
insert into TypesChambre values (3, 'X3', 30);
insert into TypesChambre values (4, 'X4', 40);
insert into TypesChambre values (5, 'X5', 50);

insert into RESERVATIONS values (1, 1, 1, timestamp '2016-09-25 17:30:20', interval '1' day, 1);
insert into RESERVATIONS values (2, 2, 2, timestamp '2016-08-24 17:30:20', interval '2' day, 1);
insert into RESERVATIONS values (3, 3, 3, timestamp '2016-09-25 17:30:20', interval '3' day, 1);
insert into RESERVATIONS values (4, 1, 4, timestamp '2016-06-25 17:30:20', interval '4' day, 1);
insert into RESERVATIONS values (5, 4, 5, timestamp '2016-04-25 17:30:20', interval '5' day, 1);
insert into RESERVATIONS values (6, 5, 1, timestamp'2016-07-25 17:30:20', interval'6' day, 1);

insert into Chambres values (1, 1, 1);
insert into Chambres values (20, 1, 1);
insert into Chambres values (2, 1, 2);
insert into Chambres values (3, 1, 3);
insert into Chambres values (4, 2, 1);
insert into Chambres values (5, 2, 2);
insert into Chambres values (6, 2, 5);
insert into Chambres values (7, 3, 1);
insert into Chambres values (8, 3, 2);
insert into Chambres values (9, 3, 3);
insert into Chambres values (10, 3, 4);
insert into Chambres values (11, 4, 1);
insert into Chambres values (12, 4, 2);
insert into Chambres values (13, 4, 3);
insert into Chambres values (14, 4, 4);
insert into Chambres values (15, 5, 4);
insert into Chambres values (16, 5, 2);
insert into Chambres values (17, 5, 1);
insert into Chambres values (18, 1, 4);
insert into Chambres values (19, 4, 5);




insert into Occupations values (1, 1, 1, timestamp '2016-09-25 17:30:20', timestamp '2016-09-30 17:30:20');
insert into Occupations values (2, 2, 5, timestamp '2016-08-24 17:30:20', timestamp '2016-08-30 17:30:20');
insert into Occupations values (3, 3, 9, timestamp '2016-09-25 17:30:20', timestamp '2016-10-30 17:30:20');
insert into Occupations values (4, 1, 18, timestamp '2016-06-25 17:30:20', timestamp '2016-11-30 17:30:20');
insert into Occupations values (5, 4, 19, timestamp '2016-04-25 17:30:20', timestamp '2016-12-30 17:30:20');
insert into Occupations values (6, 5, 20, timestamp '2016-07-25 17:30:20', timestamp '2016-09-30 17:30:20');


select NomHo from Hotels where NBETOILESHO > 2;

select count(*) from Hotels;

