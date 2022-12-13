CREATE TYPE client_type AS OBJECT(
    num NUMBER(6),
    nom VARCHAR2(60),
    adresse VARCHAR2(120),
    datenaiss DATE,
    MEMBER FUNCTION AGE RETURN NUMBER
);
/
CREATE TABLE Client of client_type(PRIMARY KEY (num));


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

CREATE OR REPLACE TYPE BODY client_type AS MEMBER FUNCTION age RETURN NUMBER IS vage NUMBER;

BEGIN 
SELECT ROUND(SYSDATE-c.datenaiss)/360 INTO vage from Client c where c.num=SELF.num;
RETURN vage;
END age;
END;
/

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