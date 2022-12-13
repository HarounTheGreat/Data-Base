
creation de compte:
alter session set container=xepdb1;
create user haroun identified by haroun;
grant connect,dba,resource to haroun;
conn haroun/haroun@xepdb1;

-- 1
-- a- 

create type telephone_vry_type as VARRAY(3) of varchar2(14); 


-- b-

create type client_typ AS OBJECT(
num number(5),
nom varchar2(30),
numtel telephone_vry_type)
create table client of client_typ(constraint pk_client primary key(nom));

-- c- 

create type compte_type AS OBJECT(
ncompte varchar2(5),solde number(10,2),
dateOuv date,ref_client ref client_typ)
not final
not instantiable


-- d- 

create type signataire_elt_nt_type AS OBJECT
(num number(5),droit char(1))


-- e- 

create type signataire_nt_type AS table of 
signataire_elt_nt_type 

-- f- 

create or replace type cptCourant_type UNDER 
compte_type(nbopcb number(5),
signataire_nt signataire_nt_type)


-- g-

create or replace type cptEpargne_type UNDER
compte_type(txint number(2,1));


-- h-

create or replace type mouvement_type AS OBJECT
(ref_client ref client_typ,ref_cpt_courant
ref cptCourant_type,DateOp date,montant number(8,2))



-- 2

create table cptcourant of cptCourant_type(primary key (ncompte),
check(ref_client is not null),ref_client references client)
nested table signataire_nt store as signataire_tabnt


-- 3 

alter table signataire_tabnt add constraint ck_droit
check (droit in('D','R'));

alter table signataire_tabnt add constraint nsignature
check (num is not null);

alter table signataire_tabnt add constraint cn_droit
check(droit is not null);

-- 4 

create table CptEpargne of cptEpargne_type(primary key (ncompte),check(ref_client  is not null),
ref_client references client,check(TXINT<3.5));

-- 5 

create table mouvement of mouvement_type (ref_client references client,check(ref_client is not null),
ref_cpt_courant references cptcourant,check(ref_cpt_courant is not null),dateop default(sysdate-2));

-- 6

insert into client values(1,'riadh ahmed','mahdia',telephone_vry_type('+21624316547',null,null));
insert into client values(2,'riadh ammar','sousse',telephone_vry_type(null,null','+21695444333'));
insert into client values(3,'jaidane rihem','sousse',telephone_vry_type('+21624396547','+21624316847','+21624314547'));
insert into client values(4,'baba jamila','monastir',telephone_vry_type('+21624366547',null','+21624359547'));
insert into client values(5,'mounir abbes','tunis',telephone_vry_type('+21616996547',null,null));
