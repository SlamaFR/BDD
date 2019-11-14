--
-- Exercice 1
--
-- Q1 : La liste des identifiants et noms de magasins qui ne vendent pas de bureaux.
--
SELECT DISTINCT idmag
FROM magasin
WHERE idmag NOT IN
      (
          SELECT DISTINCT idmag
          FROM stocke
                   NATURAL JOIN produit
          WHERE libelle = 'bureau'
      );

--
-- Q2 : La liste des magasins dont tous les produits sont à moins de 100 euros.
--
SELECT *
FROM magasin
WHERE 100 > ALL
      (
          SELECT prixunit
          FROM stocke
          WHERE stocke.idmag = magasin.idmag
      );

--
-- Q3 : La liste des produits qu’aucun client n’a acheté.
--
SELECT *
FROM produit
WHERE idpro NOT IN
      (
          SELECT idpro
          FROM contient
      );

--
-- Q4 : Le montant moyen des factures de la base de données.
--
SELECT avg(sum)
FROM (
         SELECT sum(prixunit * quantite)
         FROM contient
         GROUP BY idfac
     ) AS sum;

--
-- Q5 : La liste des noms et prénoms de clients qui ont acheté un produit au moins 20
-- euros plus cher que son prix moyen, avec les libellés des produits en question.
--
SELECT DISTINCT nom, prenom, libelle
FROM client
         NATURAL JOIN facture
         NATURAL JOIN contient
         NATURAL JOIN produit
WHERE prixunit >= ANY
      (
          SELECT avg(prixunit) + 20
          FROM stocke
          WHERE stocke.idpro = contient.idpro
          GROUP BY idpro
      );

--
-- Exercice 2
--
-- Q1 : La liste des identifiants et libellés de produits qui ont été vendus au moins 40%
-- plus cher que leur prix moyen sur le marché.
--
SELECT DISTINCT idpro, libelle
FROM produit
         NATURAL JOIN contient
WHERE prixunit >= ANY
      (
          SELECT avg(prixunit) * 1.4
          FROM stocke
          WHERE stocke.idpro = contient.idpro
          GROUP BY idpro
      );

--
-- Q2 : La liste des produits (idpro, libelle) les moins chers de chaque type avec pour
-- chacun son meilleur prix sur le marché et le(s) magasin(s) qui le vend(ent) à ce
-- prix-là.
--
SELECT p.idpro, p.libelle, s.prixunit, s.idmag
FROM (
         SELECT libelle, min(prixunit) AS prixunit
         FROM produit
                  NATURAL JOIN stocke
         GROUP BY libelle
     ) m
         NATURAL JOIN produit p
         NATURAL JOIN stocke s;

--
-- Q3 : Pour chaque client la valeur totale des produits qu’il a commandé mais qui ne sont
-- pas en stock.
--

SELECT f.numcli, nom, prenom, sum(quantite * prixunit) - achats.dispo AS indisponible
FROM client
         NATURAL JOIN facture f
         NATURAL JOIN contient
         JOIN
     (
         SELECT numcli, sum(quantite * prixunit) AS dispo
         FROM facture
                  NATURAL JOIN contient
         WHERE idpro IN
               (
                   SELECT DISTINCT idpro
                   FROM stocke
               )
         GROUP BY numcli
     ) AS achats ON achats.numcli = f.numcli
GROUP BY f.numcli, nom, prenom, achats.dispo;

--
-- Q4 : La liste des magasins qui vendent des produits de toutes les couleurs
--

SELECT *
FROM magasin m
WHERE NOT EXISTS
    (
        SELECT DISTINCT couleur
        FROM produit
        WHERE couleur IS NOT NULL
          AND couleur NOT IN
              (
                  SELECT DISTINCT couleur
                  FROM stocke s
                           NATURAL JOIN produit
                  WHERE s.idmag = m.idmag
                  AND couleur IS NOT NULL
              )
    );

-- Pour vérifier :

SELECT DISTINCT idmag, count(DISTINCT couleur)
FROM produit
         NATURAL JOIN stocke
GROUP BY idmag
HAVING count(DISTINCT couleur) = (
    SELECT count(DISTINCT couleur)
    FROM produit);

--
-- Q5 : La liste des magasins qui pratiquent le meilleur prix du marché sur plus de la moitié
-- de leur catalogue.
--
SELECT idmag, nom, mp.meilleursprix, count(idpro) AS nbproduits
FROM stocke
         NATURAL JOIN magasin
         NATURAL JOIN
     (
         SELECT idmag, count(idpro) AS meilleursprix
         FROM (
                  SELECT p.idpro, s.idmag
                  FROM (
                           SELECT idpro, min(prixunit) AS prixunit
                           FROM produit
                                    NATURAL JOIN stocke
                           GROUP BY idpro
                       ) m
                           NATURAL JOIN produit p
                           NATURAL JOIN stocke s
              ) p
         GROUP BY idmag) mp
GROUP BY idmag, nom, mp.meilleursprix
HAVING mp.meilleursprix > count(idpro) / 2;
