<h1> Data-Base </h1>
<img src=https://i.gifer.com/T9r9.gif width = 250 />

**1) Creation des table en SQL**

### Table pilote

| plnum | plnom     | plprenom | ville  | salaire |
| ----- | --------- | -------- | ------ | ------- |
| 130   | Ben Salem | Omar     | Tunis  | 3000    |
| 131   | Ben Salah | Ahmed    | Sousse | 2900    |

```SQL
create table pilote ( plnum number(3) primary key,
			plnom varchar(20),
		plprenom varchar(20),
		ville varchar(20),
		salaire number(5) check (salaire >=2000));
```

### Table avion

| avnum | marque | type | capacité |
| ----- | ------ | ---- | -------- |
| 100   | AIRBUS | A320 | 300      |
| 101   | BOEING | B707 | 250      |

```SQL
create table avion( avnum number(3) primary key,
		      marque varchar(20),
		      type varchar(20),
		      capacite number(3) check (capacite between 50 and 455));
```

### Table vol

| volnum | ville_dep | ville_arr | date_vol   | plnum | avnum |
| ------ | --------- | --------- | ---------- | ----- | ----- |
| 388    | Monastir  | Paris     | 01/10/2022 | 131   | 100   |
| 392    | Djerba    | Istanbul  | 22/09/2022 | 131   | 101   |
| 410    | Tunis     | Madrid    | 02/12/2022 | 130   | 101   |

```SQL
create table vol( volnum number(3) primary key,
		      ville_dep varchar(20) not null,
		      ville_arr varchar(20) not null,
		      date_vol  date not null,
		      plnum number(3),
		      avnum number(3),
			constraint fk1 foreign key(plnum) references pilote(plnum),
			constraint fk2 foreign key(avnum) references avion(avnum) );
```

**2) Insertition**

```sql
INSERT INTO pilote VALUES  (130, 'ben salem','omar','tunis',3000);
INSERT INTO pilote VALUES  (131, 'ben saleh','ahmed','sousse',2900);
```

```sql
INSERT INTO avion VALUES (100, 'AIRBUS','A320',300);
INSERT INTO avion VALUES (101, 'BOEING','B707',250);
```

```sql
INSERT INTO vol VALUES (388, 'Monastir','Paris',to_date('01/10/2022','DD/MM/YYYY'),131,100);
INSERT INTO vol VALUES (392, 'Djerba','Istanbul',to_date('02/09/2022','DD/MM/YYYY'),131,101);
INSERT INTO vol VALUES (410, 'Tunis','Madrid',to_date('02/12/2022','DD/MM/YYYY'),130,101);
```

**3.Valider les insertions**

```sql
commit;
```

**4.Ajouter le vol suivant**

| volnum | ville_dep | ville_arr | date_vol   | plnum | avnum |
| ------ | --------- | --------- | ---------- | ----- | ----- |
| 422    | Tunis     | Paris     | 05/09/2022 | 131   | 101   |

```sql
INSERT INTO vol VALUES (422, 'Tunis','Paris',to_date('05/09/2022','DD/MM/YYYY'),131,101);
```

**5.Annuler l’insertion précédente**

```sql
rollback;
```

**6.Modifier le vol n° 388 (ville_arr=’Lyon’)**

```sql
UPDATE vol
SET ville_arr= 'Lyon'
WHERE volnum= 388;
```

**7.Modifier le vol n° 388 (ville_arr=’Lyon’)**

```sql
DELETE FROM vol
WHERE volnum = 392;
```

**8.Valider la suppression**

```sql
commit;
```

**9.Créer la vue Pnom (plnum, plnom) à partir de la table pilote.**

```sql
vue= table virtuelle
create view Pnom as select plnum, plnom from pilote;
desc pnom
drop view pnom;
```

**10.A travers la vue Pnom, modifier le nom du pilote 130 en ‘Ben Younes’**

```sql
UPDATE pnom
SET plnom='Ben younes'
WHERE plnum= 130;
```

**11.Créer la vue Vols (volnum, plnom, marque) associant à chaque numéro de vol, le nom
du pilote et la marque de l’avion, à partir des tables pilotes pilote, avion et vol.**

```sql
UPDATE pnom
SET plnom='Ben younes'
WHERE plnum= 130;
```

**12.Octroyer à tous les utilisateurs le droit d’accès en lecture (privilège SELECT) à la vue
Vols**

```sql
create view vols as select volnum, plnom,marque from pilote;
creeate user newuser
identified by password;
grant connect, dba, resource to username;
```

<h1>TP2</h1>

-- 1

```sql
select username from all_users;
```

-- 2

```sql
create profile tp limit
failed_login_attempts 3;
 create user utp2 identified by tp2 default tablespace users
  password expire
  profile tp;
```

-- 3

```sql
conn utp2/tp2@xepdb1;
l'utilisateur n'a pas le privilege
```

-- 4

```sql
grant create session to utp2;
```

-- 5

```sql
conn utp2/haroun@xepdb1;
alter user utp2
account unlock;
```

-- 6

```sql
select * from SYSTEM_PRIVILEGE_MAP
```

-- 7

```sql
create table tabtest(
    numtest NUMBER(3),
   nomtest VARCHAR2(20));
privilÞges insuffisants
```

-- 8

```sql
select * from TABLE_PRIVILEGE_MAP;
```

-- 9

```sql
system: grant unlimited tablespace to utp2;
```

-- 10

```sql
select * from session_prises;
```

-- 11

```sql
select * from pilote;
l'utilisateur n'a pas de privilege de voir
```

-- 12

-- A

```sql
create public synonym syspnom for epi.pnom;
```

-- B

```sql
create role Editpnom;
grant insert any table,update any table,select any table to utp2;
```

-- C

```sql
grant Editpnom to utp2;
```

-- 13

```sql
insert into syspnom values (141,'jilani');
```

<h1>TP3</h1>

-- 2

```sql
desc dictionary;
```

-- 3

```sql
select count(*) from dictionary;
```

-- 4

```sql
select * from dictionary where
 TABLE_NAME in ('USER_TABLES','USER_OBJECTS','USER_CONSTRAINTS');
```

-- 5

```sql
select object_name,object_type
from USER_OBJECTS;
```

-- 6

```sql
select TABLE_NAME,tablespace_name from USER_TABLES;
```

-- 7

```sql
desc user_views;
select VIEW_NAME,TEXT from USER_VIEWS;
```

-- 8

```sql
desc USER_UPDATABLE_COLUMNS;

select COLUMN_NAME,INSERTABLE,UPDATABLE,DELETABLE from
USER_UPDATABLE_COLUMNS where TABLE_NAME='PNOM';

select COLUMN_NAME,INSERTABLE,UPDATABLE,DELETABLE from
USER_UPDATABLE_COLUMNS where TABLE_NAME='VOLS';
```

-- 9

```sql
select COLUMN_NAME,CONSTRAINT_NAME from USER_CONS_COLUMNS
where TABLE_NAME='PILOTE';
```

-- 10

```sql
select CONSTRAINT_NAME , CONSTRAINT_TYPE,TABLE_NAME,SEARCH_CONDITION from USER_CONSTRAINTS
where TABLE_NAME in('PILOT','VOL');
```

-- 11

```sql
select CONSTRAINT_NAME,SEARCH_CONDITION from USER_CONSTRAINTS where CONSTRAINT_TYPE='c' AND TABLE_NAME='PILOTE';
```

-- 12

```sql
comment on table pilote IS 'Pilotes Information';
```

-- 13

```sql
select TABLE_NAME,COMMENTS from USER_TAB_COMMENTS;
```

-- partie 2
-- 14

```sql
alter table pilote
add dateEmbauche DATE;
```

-- 15

```sql
alter table pilote
add compa VARCHAR2(20);
```

-- 16

```sql
select * from pilote;
update pilote
SET salaire=3000,dateEmbauche='23/06/2017' ,COMPA='TUNISAIR'
WHERE plnum=130;

update pilote
SET salaire=2900,dateEmbauche='14/11/2018' ,COMPA='TUNISAIR'
WHERE plnum=131;

insert into pilote values(132,'Hammadi','Leila','Nabeul',2700,'6/01/2019','NOVELAIR');

insert into pilote values(133,'Ben Abdallah','Riadh','Tunis',2900,'15/04/2018','TUNISAIR');
```

-- 17

```sql
select PLNOM,round(months_between(SYSDATE,dateEmbauche)) MONTHS_WORKED FROM pilote;
```

-- 18

```sql
select PLNOM,dateEmbauche,to_char(dateEmbauche,'DAY')jour from pilote;
```

-- 19

```sql
select PLNOM ,dateEmbauche,to_char(add_months(dateEmbauche,6)review from pilote;
```

-- 20

```sql
create view Tunisair_pl(numeros,nom,comagnie)AS select PLNUM,PLNOM,compa from pilote where compa='TUNISAIR' with check option;
```

-- 21

```sql
desc Tunisair_PL;
```

-- 22

```sql
insert into Tunisair_PL values (134,'Ketata','SYFAX_AIRLINES');
```

<h1>TP4</h1>

# creation du compte:

```sql
alter session set container=xepdb1;
create user haroun identified by haroun;
grant connect,dba,resource to haroun;
conn haroun/haroun@xepdb1;
```

-- 1
-- a-

```sql
create type telephone_vry_type as VARRAY(3) of varchar2(14);
```

-- b-

```sql
create type client_type AS OBJECT(
num number(5),
nom varchar2(30),
numtel telephone_vry_type)
create table client of client_type(constraint pk_client primary key(nom));
```

-- c-

```sql
create type compte_type AS OBJECT(
ncompte varchar2(5),solde number(10,2),
dateOuv date,ref_client ref client_type)
not final
not instantiable
```

-- d-

```sql
create type signataire_elt_nt_type AS OBJECT
(num number(5),droit char(1))
```

-- e-

```sql
create type signataire_nt_type AS table of
signataire_elt_nt_type
```

-- f-

```sql
create or replace type cptCourant_type UNDER
compte_type(nbopcb number(5),
signataire_nt signataire_nt_type)
```

-- g-

```sql
create or replace type cptEpargne_type UNDER
compte_type(txint number(2,1));
```

-- h-

```sql
create or replace type mouvement_type AS OBJECT
(ref_client ref client_type,ref_cpt_courant
ref cptCourant_type,DateOp date,montant number(8,2))
```

-- 2

```sql
create table cptcourant of cptCourant_type(primary key (ncompte),
check(ref_client is not null),ref_client references client)
nested table signataire_nt store as signataire_tabnt
```

-- 3

```sql
alter table signataire_tabnt add constraint ck_droit
check (droit in('D','R'));

alter table signataire_tabnt add constraint nsignature
check (num is not null);

alter table signataire_tabnt add constraint cn_droit
check(droit is not null);
```

-- 4

```sql
create table CptEpargne of cptEpargne_type(primary key (ncompte),check(ref_client  is not null),
ref_client references client,check(TXINT<3.5));
```

-- 5

```sql
create table mouvement of mouvement_type (ref_client references client,check(ref_client is not null),
ref_cpt_courant references cptcourant,check(ref_cpt_courant is not null),dateop default(sysdate-2));
```

-- 6

```sql
insert into client values(1,'riadh ahmed','mahdia',telephone_vry_type('+21624316547',null,null));
insert into client values(2,'riadh ammar','sousse',telephone_vry_type(null,null','+21695444333'));
insert into client values(3,'jaidane rihem','sousse',telephone_vry_type('+21624396547','+21624316847','+21624314547'));
insert into client values(4,'baba jamila','monastir',telephone_vry_type('+21624366547',null','+21624359547'));
insert into client values(5,'mounir abbes','tunis',telephone_vry_type('+21616996547',null,null));
```
