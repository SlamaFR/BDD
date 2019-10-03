/**
 *	Compte rendu de IRWIN MADET groupe de TP 10
 **/


/**
 *  Exercice 1 sur la base usimag
 **/

-- Commande pour importer la base usimag.sql

\i usimag.sql

-- Schéma de la base usimag

\d

/*

Schema |    Name    | Type  |  Owner
--------+------------+-------+----------
 public | magasin    | table | postgres
 public | produit    | table | postgres
 public | provenance | table | postgres
 public | usine      | table | postgres

Mettre ici la liste des tables ainsi que les clés primaires et étrangères

produit(ref_prod, nom_prod, couleur, poids)
PK : ref_prod

magasin(ref_mag, nom_mag, ville)
PK : ref_mag

usine(ref_usine, nom_usine, ville)
PK : ref_usine

provenance(ref_prod, ref_usine, ref_mag, quantité)
PK : ref_prod, ref_usine, ref_mag
FK : ref_prod fait référence à produit(ref_prod)
FK : ref_usine fait référence à usine(ref_usine)
FK : ref_mag fait référence à magasin(ref_mag)

*/

-- le contenu la table magasin

SELECT * FROM magasin;

-- la colonne nom de la table magasin

SELECT nom_mag FROM magasin;

-- les noms de magasin sans doublon

SELECT DISTINCT nom_mag FROM magasin;

-- le nom des villes dans lesquelles il y a une usine

SELECT ville FROM usine;

-- le nom des villes dans lesquelles il y a une usine sans doublon

SELECT DISTINCT ville FROM usine;

-- les noms et les couleurs de chaque produit

SELECT nom_prod, couleur FROM produit;

-- la référence et la quantité de chaque produit livré au magasin avec la référence 14;

SELECT ref_prod, quantite FROM provenance WHERE ref_mag='14';

-- la référence, le nom et la ville de toutes les usines de Marseille;

SELECT * FROM usine WHERE ville='Marseille';

-- les références des magasins qui sont approvisionnés par l'usine de référence 109 en produit de référence 1;

SELECT ref_mag FROM provenance WHERE ref_usine='109' AND ref_prod='1';

-- la référence et le nom de tous les produits rouges;

SELECT ref_prod, nom_prod FROM produit WHERE couleur='rouge';

-- la référence et le nom de tous les produits dont le nom commence par "casse";

SELECT ref_prod, nom_prod FROM produit WHERE nom_prod LIKE 'casse%';

-- la référence des magasins auxquels on livre quelque chose.

SELECT ref_mag FROM provenance;

-- la même sans doublon

SELECT DISTINCT ref_mag FROM provenance;

-- le nom des produits qui pèsent entre 15 et 45;

SELECT DISTINCT nom_prod FROM produit WHERE poids BETWEEN 15 AND 45;

-- le nom des produits qui sont jaunes ou bleus, et qui pèsent moins que 20;

SELECT DISTINCT nom_prod FROM produit WHERE couleur IN ('jaune', 'bleu') AND poids < 20;

-- le nom des produits bleus qui pèsent moins que 20 et des produits jaunes;

SELECT DISTINCT nom_prod FROM produit WHERE (couleur='bleu' AND poids < 20) OR couleur='jaune';

-- le nom des lampes et des produits qui pèsent plus que 30;

SELECT DISTINCT * FROM produit WHERE nom_prod='lampe' OR poids > 30;

/**
 *  Exercice 3 sur la base GestCommande
 **/

-- Schéma de la base GestCommande

/*

Mettre ici la liste des tables ainsi que les clés primaires et étrangères

c_commande(ncom, ncli, datecom)
PK : ncom

c_detail(ncom, npro, qcom)
PK : ncom, npro

c_produit(npro, libelle, prix, qstock)
PK : npro

c_client(ncli, nom, adresse, localite, cat, compte)
PK : ncli

*/

-- Commandes pour afficher le contenu de la table C_CLIENT puis celui de la table C_COMMANDE.

SELECT * FROM c_client;

SELECT * FROM c_commande;

-- Le gestionnaire des commandes souhaite afficher la liste des commandes avec les informations client.
-- Il décide de le faire à l'aide de la requête suivante:  SELECT * FROM C_CLIENT, C_COMMANDE
-- Observez le résultat. Cette requête est-elle correcte?

-- La requête est incorrecte, on obtient un produit cartésien des deux tables
-- (Chaque client est associé à chaque commande).

-- Que manque-t-il pour que cette requête soit pertinente? Proposez en une.

SELECT DISTINCT * FROM c_client, c_commande WHERE c_client.ncli=c_commande.ncli;

-- Numéro du client qui a passé la commande numéro 30179.

SELECT ncli FROM c_commande WHERE ncom='30179';

-- Nom et localité du client qui a passé la commande numéro 30179.

SELECT nom, localite FROM c_client, c_commande WHERE c_commande.ncom='30179' AND c_client.ncli=c_commande.ncli;

-- Donner la liste des localités.{\tiny (Vous devez trouver 7 enregistrements)}

SELECT DISTINCT localite FROM c_client;

-- Liste des localités où habitent un client (ou plus) qui a passé une commande.

SELECT DISTINCT localite FROM c_client, c_commande WHERE c_client.ncli=c_commande.ncli;

-- Liste sans doublons des clients (numéro) qui ont commandé le produit CS464.

SELECT DISTINCT ncli FROM c_commande, c_detail WHERE c_detail.ncom=c_commande.ncom AND c_detail.npro='CS464';

-- Liste des clients (numéro, nom, localité) qui ont commandé le produit CS464.

SELECT DISTINCT c_client.ncli, nom, localite FROM c_commande, c_detail, c_client WHERE c_detail.ncom=c_commande.ncom AND c_detail.npro='CS464' AND c_commande.ncli = c_client.ncli;

-- Quels sont les produits en sapin (numéro et libellé) qui font l'objet d'une commande ?

SELECT DISTINCT c_produit.npro, libelle FROM c_detail, c_produit WHERE c_detail.npro=c_produit.npro AND libelle LIKE '%SAPIN%';
