--
-- Q1 : Nombre total de factures stockées dans la base de données.
--
SELECT count(*)
FROM facture;

--
-- Q2 : La liste des noms de magasins, avec pour chacun le nombre de villes
-- où ils sont implantés.
--
SELECT nom, count(DISTINCT ville)
FROM magasin
GROUP BY nom;

--
-- Q3 : La liste des numéros et noms de clients avec pour chacun le nombre
-- de factures qui le concernent.
--
SELECT client.numcli, nom, count(idfac)
FROM client
         LEFT OUTER JOIN facture f ON client.numcli = f.numcli
GROUP BY nom, client.numcli;

--
-- Q4 : Le prix moyen, minimum et maximum d’un bureau à Paris.
--
SELECT avg(prixunit), min(prixunit), max(prixunit)
FROM produit
         NATURAL JOIN stocke
         NATURAL JOIN magasin
WHERE magasin.ville = 'paris'
  AND produit.libelle = 'bureau';

--
-- Q5 : La liste des meilleurs prix pour chaque libellé de produit.
--
SELECT libelle, min(prixunit)
FROM produit
         NATURAL JOIN stocke
GROUP BY libelle;

--
-- Q6 : La liste de toutes les factures, avec pour chacune le nom complet du client qui l’a
-- contractée et son montant total, triées par montant décroissant.
--
SELECT nom, prenom, sum(quantite * prixunit)
FROM client
         NATURAL JOIN facture
         NATURAL JOIN contient
GROUP BY nom, prenom, idfac
ORDER BY sum(quantite * prixunit) DESC;

--
-- Q7 : La liste des magasins qui vendent au moins 20 produits de libellés différents
--
SELECT nom
FROM magasin
         NATURAL JOIN stocke
         NATURAL JOIN produit
GROUP BY nom
HAVING count(DISTINCT libelle) >= 20;

--
-- Q8 : La liste des 3 magasins qui vendent le plus de produits de libellés différents.
--
SELECT nom
FROM magasin
         NATURAL JOIN stocke
         NATURAL JOIN produit
GROUP BY idmag
ORDER BY count(DISTINCT libelle) DESC
LIMIT 3;

--
-- Q9 : La liste des numéros, noms et prénoms de clients qui habitent à Paris et ont dépensé
-- au moins 3000 euros, tous achats confondus.
--
SELECT numcli, nom, prenom
FROM client
         NATURAL JOIN facture
         NATURAL JOIN contient
WHERE ville = 'paris'
GROUP BY numcli
HAVING sum(quantite * prixunit) > 3000;