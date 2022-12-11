
-- 1 

select username from all_users;

-- 2

create profile tp limit
failed_login_attempts 3;
 create user utp2 identified by tp2 default tablespace users
  password expire
  profile tp;

-- 3

conn utp2/tp2@xepdb1;
l'utilisateur n'a pas le privilege

-- 4

grant create session to utp2;

-- 5

conn utp2/haroun@xepdb1;
alter user utp2
account unlock;

-- 6

select * from SYSTEM_PRIVILEGE_MAP

-- 7

create table tabtest(
    numtest NUMBER(3),
   nomtest VARCHAR2(20));
privilÞges insuffisants

-- 8

select * from TABLE_PRIVILEGE_MAP;

-- 9

system: grant unlimited tablespace to utp2;

-- 10

select * from session_prises;

-- 11

select * from pilote;
l'utilisateur n'a pas de privilege de voir

-- 12

-- A 

create public synonym syspnom for epi.pnom;

-- B 

create role Editpnom;
grant insert any table,update any table,select any table to utp2;

-- C

grant Editpnom to utp2;

-- 13

insert into syspnom values (141,'jilani');