<h1> Data-Base </h1>

**1) Creation des table en SQL**

### Table pilote

| plnum | plnom     | plprenom | ville  | salaire |
| ----- | --------- | -------- | ------ | ------- |
| 130   | Ben Salem | Omar     | Tunis  | 3000    |
| 131   | Ben Salah | Ahmed    | Sousse | 2900    |

````SQL
create table pilote ( plnum number(3) primary key,
			plnom varchar(20),
		plprenom varchar(20),
		ville varchar(20),
		salaire number(5) check (salaire >=2000));
````

### Table avion

| avnum | marque | type | capacité |
| ----- | ------ | ---- | -------- |
| 100   | AIRBUS | A320 | 300      |
| 101   | BOEING | B707 | 250      |

````SQL
create table avion( avnum number(3) primary key,
		      marque varchar(20),
		      type varchar(20),
		      capacite number(3) check (capacite between 50 and 455));
````

### Table vol

| volnum | ville_dep | ville_arr | date_vol   | plnum | avnum |
| ------ | --------- | --------- | ---------- | ----- | ----- |
| 388    | Monastir  | Paris     | 01/10/2022 | 131   | 100   |
| 392    | Djerba    | Istanbul  | 22/09/2022 | 131   | 101   |
| 410    | Tunis     | Madrid    | 02/12/2022 | 130   | 101   |


````SQL
create table vol( volnum number(3) primary key,
		      ville_dep varchar(20) not null,
		      ville_arr varchar(20) not null,
		      date_vol  date not null,
		      plnum number(3),
		      avnum number(3),
			constraint fk1 foreign key(plnum) references pilote(plnum),	
			constraint fk2 foreign key(avnum) references avion(avnum) );
````

**2) Insertition**

````sql
INSERT INTO pilote VALUES  (130, 'ben salem','omar','tunis',3000);
INSERT INTO pilote VALUES  (131, 'ben saleh','ahmed','sousse',2900);
`````
````sql
INSERT INTO avion VALUES (100, 'AIRBUS','A320',300);
INSERT INTO avion VALUES (101, 'BOEING','B707',250);
````
````sql
INSERT INTO vol VALUES (388, 'Monastir','Paris',to_date('01/10/2022','DD/MM/YYYY'),131,100);
INSERT INTO vol VALUES (392, 'Djerba','Istanbul',to_date('02/09/2022','DD/MM/YYYY'),131,101);
INSERT INTO vol VALUES (410, 'Tunis','Madrid',to_date('02/12/2022','DD/MM/YYYY'),130,101);
````

**3.Valider les insertions**
````sql
commit;
````
**4.Ajouter le vol suivant**

| volnum | ville_dep | ville_arr | date_vol   | plnum | avnum |
| ------ | --------- | --------- | ---------- | ----- | ----- |
| 422    | Tunis  | Paris     | 05/09/2022 | 131   | 101   |

````sql
INSERT INTO vol VALUES (422, 'Tunis','Paris',to_date('05/09/2022','DD/MM/YYYY'),131,101);
````
**5.Annuler l’insertion précédente**

````sql
rollback;
````

**6.Modifier le vol n° 388 (ville_arr=’Lyon’)**
````sql
UPDATE vol
SET ville_arr= 'Lyon'
WHERE volnum= 388;
````
**7.Modifier le vol n° 388 (ville_arr=’Lyon’)**
````sql
DELETE FROM vol
WHERE volnum = 392;
````
**8.Valider la suppression**
````sql
commit;
````
**9.Créer la vue Pnom (plnum, plnom) à partir de la table pilote.**
````sql
vue= table virtuelle 
create view Pnom as select plnum, plnom from pilote;
desc pnom 
drop view pnom;
````
**10.A travers la vue Pnom, modifier le nom du pilote 130 en ‘Ben Younes’**
````sql
UPDATE pnom
SET plnom='Ben younes'
WHERE plnum= 130;
````
**11.Créer la vue Vols (volnum, plnom, marque) associant à chaque numéro de vol, le nom 
du pilote et la marque de l’avion, à partir des tables pilotes pilote, avion et vol.**
````sql
UPDATE pnom
SET plnom='Ben younes'
WHERE plnum= 130;
````
**12.Octroyer à tous les utilisateurs le droit d’accès en lecture (privilège SELECT) à la vue 
Vols**
````sql
create view vols as select volnum, plnom,marque from pilote;
creeate user newuser 
identified by password;
grant connect, dba, resource to username;
````