-- 2

CREATE TYPE Produit_type AS OBJECT ( 
 num NUMBER(11),
 designation VARCHAR2(120), 
 prix NUMBER(10,2),
 stock NUMBER(10)
);
/
CREATE TABLE Produit of Produit_type (PRIMARY KEY(num));


CREATE TYPE client_type AS OBJECT(
    num NUMBER(6),
    nom VARCHAR2(20),
    adresse VARCHAR2(150),
    datenaiss DATE,
    MEMBER FUNCTION AGE RETURN NUMBER
);
/
CREATE TABLE Client of client_type(PRIMARY KEY(num));


CREATE TYPE typeLigneFacture AS OBJECT (
    REF_Produit REF Produit_type,
    qte NUMBER(10)
);
/

CREATE TYPE LigneFacture_type AS TABLE OF typeLigneFacture;
/

CREATE TYPE Facture_type AS OBJECT(
    num NUMBER(11),
    datef DATE,
    lignes_facture LigneFacture_type,
    REF_Client REF client_type,
    MEMBER FUNCTION totol RETURN NUMBER
);
/

CREATE TABLE Facture OF Facture_type(PRIMARY KEY (num), REF_Client references Client, Check(REF_Client IS NOT null))
NESTED TABLE lignes_facture STORE AS nt_lignes_facture;

ALTER TABLE nt_lignes_facture
ADD CONSTRAINT nn_prod_num CHECK (qte > 0);

ALTER TABLE nt_lignes_facture
DROP CONSTRAINT  nn_prod_num;

ALTER TABLE nt_lignes_facture
ADD CONSTRAINT ckqte CHECK (qte > 0);

-- 3

CREATE OR REPLACE TYPE BODY client_type AS MEMBER FUNCTION age RETURN NUMBER IS vage NUMBER;

BEGIN 
SELECT ROUND(SYSDATE-c.datenaiss)/360 INTO vage from Client c where c.num=SELF.num;
RETURN vage;
END age;
END;
/

-- 4

CREATE OR REPLACE TYPE BODY Facture_type AS
MEMBER FUNCTION Total RETURN NUMBER IS vTotal NUMBER;

BEGIN 
SELECT SUM(lf.qte*lf.REF_Produit.prix) 
from THE(select f.lignes_facture from facture f WHERE f.num = SELF.num) lf;
RETURN vTotal;
END Total:
END ;
/

CREATE OR REPLACE TYPE BODY Facture_type AS
MEMBER FUNCTION total RETURN NUMBER
 IS
 vTotal NUMBER;
 BEGIN
 SELECT SUM(lf.qte*lf.REF_produit.prix) INTO vTotal
 FROM THE(select f.lignes_facture from facture f WHERE f.num = SELF.num ) lf ;
 RETURN vTotal;
 END total; 
END;
/

-- 5

INSERT INTO Client 
VALUES (1, 'Abidi Dorsaf', 'Bizerte', to_date('12/01/1998', 'DD/MM/YYYY'));
INSERT INTO Client 
VALUES (2, 'Brini Sofien', 'Ben Arous', to_date('29/07/2006', 'DD/MM/YYYY'));
INSERT INTO Produit
VALUES (1, ‘PC P GAMER ASUS’, 7200.50, 6) ;
INSERT INTO Produit
VALUES (2, ‘PC P GAMER MSI SWORD’, 3400.10, 8) ;
INSERT INTO Produit
VALUES (3, 'MANETTE PS4', 210.3, 12) ;
INSERT INTO Produit 
VALUES (4, 'CASQUE KONIX', 75.9, 23) ;


INSERT INTO Facture 
 VALUES (
 0000123,to_date('05/12/2022', 'DD/MM/YYYY')
 ,LigneFacture_type(typeLigneFacture((select REF(p) from produit p where p.num=2),1),
 typeLigneFacture((select REF(p) from produit p where p.num=3),2)), 
 (select REF (cli) from client cli where cli.num=1));


INSERT INTO Facture 
 VALUES (
 00001234,to_date('06/12/2022', 'DD/MM/YYYY'),
LigneFacture_type(
 typeLigneFacture((select REF(p) from produit p where p.num=1),1),
 typeLigneFacture((select REF(p) from produit p where p.num=4),1)
), 
 (select REF (cli) from client cli where cli.num=2));
/

-- 6

-- a

SELECT f.num, f.REF_Client.nom , f.REF_Client.age()
FROM Facture f;

-- b

SELECT f.num , f.REF_Client.nom , f.total()
FROM Facture f;

-- Afficher le nombre de produits achetés par le client 1

SELECT SUM(lf.qte) AS nombre
FROM THE(select f.Lignes_facture from facture WHERE f.REF_Client.num = 1) lf;

-- c

ALTER TYPE Facture_type ADD MEMBER FUNCTION quantiteT RETURN NUMBER
CASCADE;
CREATE OR REPLACE TYPE BODY Facture_type AS
 MEMBER FUNCTION total RETURN NUMBER
 IS
 vTOTAL NUMBER;
 BEGIN
 SELECT SUM(lf.qte*lf.REF_produit.prix) INTO vTotal
 FROM THE(select f.lignes_facture from facture f WHERE f.num = SELF.num ) lf
 RETURN vTotal;
 END total; 
 
 MEMBER FUNCTION quantiteT RETURN NUMBER IS
 vQuantite NUMBER; 
 BEGIN
 SELECT SUM(lf.qte) INTO vQuantite 
 FROM THE(select f.lignes_facture from facture f WHERE f.num = SELF.num ) lf; 
 RETURN vQuantite; 
 END quantite; 
END;

-- d

SELECT DISTINCT f.REF_Client.num, f.REF_Client.nom AS nom
FROM Facture f 
WHERE f.quantiteT() > 3;