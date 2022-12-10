-- 1

create table pilote ( plnum number(3) primary key,
			plnom varchar(20),
		plprenom varchar(20),
		ville varchar(20),
		salaire number(5) check (salaire >=2000));

create table avion( avnum number(3) primary key,
		      marque varchar(20),
		      type varchar(20),
		      capacite number(3) check (capacite between 50 and 455));

create table vol( volnum number(3) primary key,
		      ville_dep varchar(20) not null,
		      ville_arr varchar(20) not null,
		      date_vol  date not null,
		      plnum number(3),
		      avnum number(3),
			constraint fk1 foreign key(plnum) references pilote(plnum),	
			constraint fk2 foreign key(avnum) references avion(avnum) );

-- 2

INSERT INTO pilote VALUES  (130, 'ben salem','omar','tunis',3000);
INSERT INTO pilote VALUES  (131, 'ben saleh','ahmed','sousse',2900);


INSERT INTO avion VALUES (100, 'AIRBUS','A320',300);
INSERT INTO avion VALUES (101, 'BOEING','B707',250);

INSERT INTO vol VALUES (388, 'Monastir','Paris',to_date('01/10/2022','DD/MM/YYYY'),131,100);
INSERT INTO vol VALUES (392, 'Djerba','Istanbul',to_date('02/09/2022','DD/MM/YYYY'),131,101);
INSERT INTO vol VALUES (410, 'Tunis','Madrid',to_date('02/12/2022','DD/MM/YYYY'),130,101);

-- 3

commit;

-- 4

INSERT INTO vol VALUES (422, 'Tunis','Paris',to_date('05/09/2022','DD/MM/YYYY'),131,101);

-- 5
rollback;

-- 6

UPDATE vol
SET ville_arr= 'Lyon'
WHERE volnum= 388;

-- 7

DELETE FROM vol
WHERE volnum = 392;

-- 8

commit;

-- 9

vue= table virtuelle 
create view Pnom as select plnum, plnom from pilote;
desc pnom 
drop view pnom;

-- 10

UPDATE pnom
SET plnom='Ben younes'
WHERE plnum= 130;

-- 11

create view vols as select volnum, plnom,marque from pilote;
creeate user newuser 
identified by password;
grant connect, dba, resource to username;


