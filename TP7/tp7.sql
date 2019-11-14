-----------------------------------------------------------------------
--- Rappels et consignes de rendu
-----------------------------------------------------------------------
--- Vous rendrez sur le elearning un ficher bien présenté contenant les
--- réponses aux questions en suivant les modèles donnés aux 
--- précédents TP.

--- Télécharger le dump de la base disponible dans le fichier
--- vacances.sql et importer le dans votre base de données.

-----------------------------------------------------------------------
--- Partie 1 le schéma
-----------------------------------------------------------------------

--- M1 - Créer une table piste(id,nom,#station,couleur, longueur)
--- pour référencer les informations des pistes de ski d'une station.
--- L'attribut station sera l'identifiant de la station correspondante.

CREATE TABLE piste
(
    idpiste integer,
    nom     varchar(25),
    numsta  integer,
    couleur varchar(25),
    longeur integer,
    PRIMARY KEY (idpiste),
    FOREIGN KEY (numsta) REFERENCES station (numsta)
);


--- M2 - Créer une nouvelle table croisement(\#idpiste1,\#idpiste2)
--- permettant de savoir quelles pistes se rencontrent. Les attributs
--- sont des identifiants de piste. Le clé primaire est constituée des
--- deux attributs.

CREATE TABLE croisement
(
    idpiste1 integer,
    idpiste2 integer,
    PRIMARY KEY (idpiste1, idpiste2),
    FOREIGN KEY (idpiste1) REFERENCES piste (idpiste),
    FOREIGN KEY (idpiste2) REFERENCES piste (idpiste)
);

--- M3 - Le domaine skiable des Houches contient la fameuse piste noire
--- "Kandahar" de 3343m le long. Celle-ci croise la piste bleue appelée
--- "Les Aillouds" dont on ne connait pas la longueur. Ajoutez ces
--- informations à votre base de donnée.

INSERT INTO piste
VALUES (1, 'Kandahar', (SELECT numsta FROM station WHERE nomsta = 'Les Houches'), 'noire', 3343);

INSERT INTO piste
VALUES (2, 'Les Aillouds', (SELECT numsta FROM station WHERE nomsta = 'Les Houches'), 'bleue', NULL);

INSERT INTO croisement
VALUES (1, 2);

--- M4 - Ajouter un client 'Sherlock Holmes' habitant au '221B Baker
--- Street, London' dont on ne connait pas le numéro de téléphone.

INSERT INTO client
VALUES (21, 'Holmes', '221B Baker Street London', NULL);

--- M5 - Mettre à jour le numéro de téléphone du client 14 qui est
--- maintenant 0635448727

UPDATE client
SET telcli='0635448727'
WHERE numcli = 14;

--- M6 - Supprimer la réservation de Mr Tarkovski à l'hotel Bellevue à
--- Flaine en janvier 2013.

DELETE
FROM reservation
WHERE numcli = (SELECT numcli FROM client WHERE nomcli = 'Tarkovski')
  AND numhot =
      (SELECT numhot
       FROM hotel
       WHERE nomhot = 'Bellevue'
         AND numsta = (SELECT numsta FROM station WHERE nomsta = 'Flaine')
      )
  AND datedeb BETWEEN '2013-01-01' AND '2013-01-31';

-------------------------------------------------------------------------
--- Ecrire des requêtes permettant d'extraire les informations suivantes:
-------------------------------------------------------------------------

--- R1 - Le nom de toutes les stations situées entre 1000 et 1500m
--- d'altitude.
--- (5 résultats attendus)

SELECT nomsta
FROM station
WHERE altitude BETWEEN 1000 AND 1500;

--- R2 - Les noms d'hotels qui existent dans plusieurs stations.
--- (2 résultats attendus)

SELECT nomhot
FROM (
         SELECT nomhot, count(*)
         FROM hotel
         GROUP BY nomhot
     ) c
WHERE c.count > 1;

--- R3 - Les noms d'hotels qui existent dans toutes les stations.
--- (1 résultat attendu)

SELECT nomhot
FROM (
         SELECT nomhot, count(*)
         FROM hotel
         GROUP BY nomhot
     ) c
WHERE c.count >= (SELECT count(*) FROM station);

--- R3 bis - L'hotel Bellevue de la station 1 (Avoriaz 1800) se décline maintenant en 2 catégories.
-- Insérez le nouvel hotel Bellevue d'Avoriaz 1800 qui ne possède que 2 étoiles (catégorie). 
-- Puis ajoutez dans cet hotel une chambre numéro 1 à 1 lit

INSERT INTO hotel
VALUES (25, 'Bellevue', 1, 2);
INSERT INTO chambre
VALUES (25, 1, 1);

--- R3 ter - Exécutez de nouveau votre requête R3 et corrigez si nécessaire

--- R4 - Le nom des clients n'ayant pas donné leur numéro de téléphone.
--- (2 résultats attendus)

SELECT nomcli
FROM client
WHERE telcli IS NULL;

--- R5 - Tous les hotels situé dans les Vosges avec le nom de la station
--- correspondante.
--- (7 résultats attendus)

SELECT nomhot, nomsta
FROM hotel
         NATURAL JOIN station
WHERE region = 'Vosges';

--- R6 - La liste des noms de clients qui ont séjourné dans un hotel
--- appelé 'Le Panorama'.
--- (3 résultats attendus)

SELECT DISTINCT nomcli
FROM client
         NATURAL JOIN reservation
         NATURAL JOIN hotel
WHERE nomhot = 'Le Panorama';

--- R7 - Tous les hotels qui n'ont aucune réservations.
--- (11 résultats attendus)

SELECT numhot, nomhot
FROM hotel h
WHERE NOT EXISTS
    (
        SELECT numhot
        FROM reservation
        WHERE reservation.numhot = h.numhot
    );

SELECT numhot, nomhot
FROM hotel
WHERE numhot NOT IN (SELECT DISTINCT numhot FROM reservation);

SELECT h.numhot, nomhot
FROM hotel h
         LEFT OUTER JOIN reservation r ON h.numhot = r.numhot
WHERE r.numhot IS NULL;

---Bonus - Proposer une requête utilisant NOT EXISTS, une requête
--- utilisant NOT IN et une requête utilisant OUTER JOIN  

--- R8 - Les hotels qui ont au moins une chambre de 5 lits ou plus.
--- (5 résultats attendus)

SELECT numhot, nomhot
FROM hotel h
WHERE EXISTS
          (
              SELECT numhot
              FROM chambre c
              WHERE c.numhot = h.numhot
                AND c.nblits >= 5
          );

--- R9 - Le nombre d'hotel de chaque catégorie. Afficher la catégorie et
--- le nombre d'hotels, classé par nombre d'hotel décroissant.

SELECT count(*) nbhotel, categorie
FROM hotel
GROUP BY categorie
ORDER BY nbhotel DESC;

--- R10 -  Les stations qui ont au moins deux hotels.
--- (9 résultats attendus)

SELECT count(*), nomsta
FROM hotel
         NATURAL JOIN station
GROUP BY numsta, nomsta
HAVING count(*) >= 2;

--- R11 - La liste des hotels (leur numéro et nom) avec leur nombre de chambres
--- classée par nombre de chambres décroissant.

SELECT numhot, nomhot, count(numch) nbch
FROM hotel
         NATURAL JOIN chambre
GROUP BY nomhot, numhot
ORDER BY nbch DESC;

--- R12 -  Pour chaque station de Haute-Savoie, donnez le nombre moyen
--- de lits par hôtel.

SELECT numsta, avg(nbch) moych
FROM station
         NATURAL JOIN
     (
         SELECT numsta, numhot, count(numch) AS nbch
         FROM station
                  NATURAL JOIN hotel
                  NATURAL JOIN chambre
         WHERE region = 'Haute-Savoie'
         GROUP BY numsta, numhot
     ) ch
GROUP BY numsta;

--- R13 - Combien de personnes ont réservé une chambre le 20 février
--- 2014?

SELECT count(DISTINCT numcli)
FROM reservation
WHERE '2014-02-20' BETWEEN datedeb AND datefin;

--- R14 - Le nom du client qui séjourne dans la chambre '4'
--- de l'hotel 'La Cachette' à la date du 15 février 2014.

SELECT nomcli
FROM client
         NATURAL JOIN reservation
         NATURAL JOIN hotel
         NATURAL JOIN chambre
WHERE numch = 4
  AND nomhot = 'La Cachette'
  AND ('2014-02-15' BETWEEN datedeb AND datefin);

--- R15 - Sherlock Holmes au ski...
--- Des vols ont eu lieu à La Breysse le 21 février 2014. La police
--- souhaite interroger l'ensemble des clients des hotels de la station
--- présents à cette date. Lister tous les clients
--- concernés (nom, adresse) à contacter.

SELECT nomcli, adrcli
FROM client
         NATURAL JOIN reservation
         NATURAL JOIN station
WHERE nomsta = 'La Breysse'
  AND '2014-02-21' BETWEEN datedeb AND datefin;

--- R16 - Plus tard on retrouva une partie des objets volés cachés
--- dernière la commode de la chambre 3 de l'hotel Bellevue de La Breysse.
--- On déduit donc que le suspect est passé par la chambre 3 après
--- le 20/02/14 et qu'il était présent sur la station le 21.
--- Corrigez la liste des suspects.

SELECT nomcli, adrcli
FROM client
         NATURAL JOIN reservation
         NATURAL JOIN hotel
         NATURAL JOIN station
WHERE nomsta = 'La Breysse'
  AND nomhot = 'Bellevue'
  AND numch = 3
  AND '2014-02-21' <= datedeb;

--- R17 - Dans le sac contenant le butin, on retrouve l'initiale 'F'
--- visible uniquement aux ultraviolets.
--- Cette information suffit-elle à désigner le coupable? Si oui qui
--- est-ce? Si non quels sont les choix?

SELECT nomcli, adrcli
FROM client
         NATURAL JOIN reservation
         NATURAL JOIN hotel
         NATURAL JOIN station
WHERE nomsta = 'La Breysse'
  AND nomhot = 'Bellevue'
  AND numch = 3
  AND '2014-02-21' <= datedeb
  AND nomcli LIKE 'F%';

-- Le suspect est Fantasio et il réside au 32 rue des boulets 75011 Paris !
