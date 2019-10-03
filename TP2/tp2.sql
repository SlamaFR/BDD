/**
 *	Compte rendu de IRWIN MADET groupe de TP 10
 **/

/**
 *  Exercice 1
 **/

-- Commentaires/Réponses sur les questions de l'exo 1

/**
 *  Exercice 2
 **/

-- Commentaires/Réponses sur les questions de l'exo 2

-- Insérer le produit d'id PA75, de nom POINTE ACIER 75, de prix 80 et avec 40 exemplaires en stock.

INSERT INTO c_produit VALUES ('PA75', 'POINTE ACIER 75', 80, 40);

-- Insérer les valeurs PA60, pointe carbone, 110, 3.

INSERT INTO c_produit VALUES ('PA60', 'pointe carbonne', 110, 3);

-- On obtient une erreur car la clé primaire PA60 existe déjà.
-- Si l'on essaie d'insérer la pointe acier à nouveau nous obtiendront la même erreur.

-- Insérer le client numéro B4321, ...

INSERT INTO c_client VALUES ('B4321', 'MUNSTER', '23 A. CAMENBERT', 'SANCY', NULL, '1250');

-- Insérer le tuple... à c_commande.

INSERT INTO c_commande VALUES ('30190', 'J007', '2003-12-23');
-- La requête fonctionne bien.

-- Insérer le tuple... à c_detail.

INSERT INTO c_detail VALUES ('30188', 'PA90', 22);

-- Ajouter une clé étrangère entre c_detail et c_produit

ALTER TABLE c_detail ADD FOREIGN KEY (npro) REFERENCES c_produit(npro);
-- Une errer est levée car le numéro de produit PA90 n'existe pas dans c_produit.

-- Supprimer le tuple qui pose problème

DELETE FROM c_detail WHERE npro='PA90';
-- La clé étrangère est bien créée désormais.

-- Ajouter la clé étrangère manquante

ALTER TABLE c_detail ADD FOREIGN KEY (ncom) REFERENCES c_commande(ncom);

-- Supprimer la colonne cat de c_client et afficher le contenu de la table.

ALTER TABLE c_client DROP COLUMN cat;
SELECT * FROM c_client;

/**
 *  Exercice 3
 **/

-- Commentaires/Réponses sur les questions de l'exo 3

-- Proposer un SEA
-- Voir sea_cheval.svg

--Construisez le schéma relationnel

/*
course(codeCourse, titreCourse, dotation)
parent(numChevalEnfant, numChevalParent, degreParente)
jockey(numJockey, nom, prénom)
monte(numJockey, numCheval, codeCourse, numDossard)
cheval(numCheval, nomCheval, sexe, dateNaissance)
*/

-- Créer les tables

CREATE TABLE COURSE (
  codecourse CHAR(6) PRIMARY KEY,
  titrecourse VARCHAR(50),
  dotation INTEGER DEFAULT NULL
);

CREATE TABLE PARENT (
  numchevalenfant INTEGER,
  numchevalparent INTEGER,
  degreparente INTEGER,
  CONSTRAINT parent_pkey PRIMARY KEY (numchevalenfant, numchevalparent)
);

CREATE TABLE JOCKEY (
  numjockey SERIAL PRIMARY KEY,
  nom VARCHAR(50),
  prenom VARCHAR(50)
);

CREATE TABLE MONTE (
  numjockey INTEGER,
  numcheval INTEGER,
  codecourse CHAR(6),
  numdossard INTEGER,
  CONSTRAINT monte_pkey PRIMARY KEY (numjockey, numcheval, codecourse)
);

CREATE TABLE CHEVAL (
  numcheval SERIAL PRIMARY KEY,
  nomcheval VARCHAR(50),
  sexe CHAR(1),
  datenaissance DATE DEFAULT NULL
);

ALTER TABLE PARENT ADD FOREIGN KEY (numchevalenfant) REFERENCES CHEVAL (numcheval) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE PARENT ADD FOREIGN KEY (numchevalparent) REFERENCES CHEVAL (numcheval) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE MONTE ADD FOREIGN KEY (codecourse) REFERENCES COURSE (codecourse) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE MONTE ADD FOREIGN KEY (numcheval) REFERENCES CHEVAL (numcheval) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE MONTE ADD FOREIGN KEY (numjockey) REFERENCES JOCKEY (numjockey) ON DELETE CASCADE ON UPDATE CASCADE;

-- Insérer les données

INSERT INTO course VALUES ('GPAT01', 'Grand Prix de l''Arc de Triomphe', 5000000);

INSERT INTO jockey (nom, prenom) VALUES ('Poinceleta', 'Roger');
INSERT INTO jockey (nom, prenom) VALUES ('Camaci', 'Enrico');

INSERT INTO cheval (nomcheval, sexe, datenaissance) VALUES ('Ribot', 'M', '12-09-1952');
INSERT INTO cheval (nomcheval, sexe, datenaissance) VALUES ('Molvedo', 'M', '01-01-1958');
INSERT INTO cheval (nomcheval, sexe) VALUES ('Prince Royal', 'M');

INSERT INTO parent VALUES (2, 1, 1);
INSERT INTO parent VALUES (3, 1, 1);

INSERT INTO monte VALUES (3, 1, 'GPAT01', 634);
INSERT INTO monte VALUES (3, 2, 'GPAT01', 356);
INSERT INTO monte VALUES (2, 3, 'GPAT01', 412);

-- Les clés étrangères sont mises en avant ici sont : numCourse, numCheval, numJockey, numChevalEnfant, numChevalParent

-- Changer le code GPAT01 en GPAT02

UPDATE course SET codecourse='GPAT02' WHERE codecourse='GPAT01';
-- On obitient : UPDATE 1 donc le changement se répercute bien.
-- On peut s'en assurer en regardant le contenu de monte :
SELECT * FROM monte;

-- Insérer un nouveau cheval, ses relations parentales et modifier sa clé primaire :

INSERT INTO cheval (nomcheval, sexe) VALUES ('Sea The Stars', 'F');
INSERT INTO parent VALUES (9, 2, 1);
UPDATE cheval SET numcheval='10' WHERE numcheval='9';

-- Si on regarde le contenu de parent, la clé a bien été mise à jour.

SELECT * FROM parent;

-- Si on supprime ce cheval, ses relations doivent disparaitrent :

DELETE FROM cheval WHERE numcheval='10';
SELECT * FROM parent;

-- On constate que la dernière ligne a bien disparu.
