-- 2

desc dictionary;

-- 3

select count(*) from dictionary;

-- 4

select * from dictionary where
 TABLE_NAME in ('USER_TABLES','USER_OBJECTS','USER_CONSTRAINTS');

-- 5

select object_name,object_type
from USER_OBJECTS;

-- 6

select TABLE_NAME,tablespace_name from USER_TABLES;

-- 7

desc user_views;
select VIEW_NAME,TEXT from USER_VIEWS;

-- 8

desc USER_UPDATABLE_COLUMNS;

select COLUMN_NAME,INSERTABLE,UPDATABLE,DELETABLE from
USER_UPDATABLE_COLUMNS where TABLE_NAME='PNOM';

select COLUMN_NAME,INSERTABLE,UPDATABLE,DELETABLE from
USER_UPDATABLE_COLUMNS where TABLE_NAME='VOLS';

-- 9

select COLUMN_NAME,CONSTRAINT_NAME from USER_CONS_COLUMNS
where TABLE_NAME='PILOTE';

-- 10

select CONSTRAINT_NAME , CONSTRAINT_TYPE,TABLE_NAME,SEARCH_CONDITION from USER_CONSTRAINTS
where TABLE_NAME in('PILOT','VOL');

-- 11

select CONSTRAINT_NAME,SEARCH_CONDITION from USER_CONSTRAINTS where CONSTRAINT_TYPE='c' AND TABLE_NAME='PILOTE';

-- 12

comment on table pilote IS 'Pilotes Information';

-- 13

select TABLE_NAME,COMMENTS from USER_TAB_COMMENTS;

-- partie 2
-- 14

alter table pilote
add dateEmbauche DATE;

-- 15

alter table pilote
add compa VARCHAR2(20);

-- 16

select * from pilote;
update pilote 
SET salaire=3000,dateEmbauche='23/06/2017' ,COMPA='TUNISAIR'
WHERE plnum=130;

update pilote 
SET salaire=2900,dateEmbauche='14/11/2018' ,COMPA='TUNISAIR'
WHERE plnum=131;

insert into pilote values(132,'Hammadi','Leila','Nabeul',2700,'6/01/2019','NOVELAIR');

insert into pilote values(133,'Ben Abdallah','Riadh','Tunis',2900,'15/04/2018','TUNISAIR');

-- 17

select PLNOM,round(months_between(SYSDATE,dateEmbauche)) MONTHS_WORKED FROM pilote;

-- 18

select PLNOM,dateEmbauche,to_char(dateEmbauche,'DAY')jour from pilote;

-- 19

select PLNOM ,dateEmbauche,to_char(add_months(dateEmbauche,6)review from pilote;

-- 20

create view Tunisair_pl(numeros,nom,comagnie)AS select PLNUM,PLNOM,compa from pilote where compa='TUNISAIR' with check option;

-- 21

desc Tunisair_PL;

-- 22

insert into Tunisair_PL values (134,'Ketata','SYFAX_AIRLINES');
