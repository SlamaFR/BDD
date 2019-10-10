---------------------------------------------------------------------------
--- Requêtes d'échauffement, facultatives si vous vous sentez à l'aise.
---------------------------------------------------------------------------
---
--- P1 Le nom des usines de Bordeaux. Le résultat est constitué de 1
--- enregistrement.
---

SELECT nom_usine FROM usine WHERE ville='Bordeaux';

---
--- P2 Les noms de produits qui finissent par la lettre 'e'. Le résultat est
--- constitué de 6 enregistrements (n'oubliez pas d'éliminer les doublons!).
---

SELECT DISTINCT nom_prod FROM produit WHERE nom_prod LIKE '%e';

---
--- P3 Les numéros de références des bottes de couleur rouge. (Il n'y a qu'un
--- seul modèle.)
---

SELECT ref_prod FROM produit WHERE nom_prod='bottes' AND couleur='rouge';

----------------------------------------------------------------------------
--- Nom: Madet
--- Prénom: Irwin
--- Groupe de TP: 10
--- Groupe de TD: 03
----------------------------------------------------------------------------
--- Requêtes obligatoires à rendre.
----------------------------------------------------------------------------
---
--- Q1  Le nom et la couleur des produits livrés par l'usine 302. Le résultat
--- doit comprendre 6 enregistrements.
---

SELECT DISTINCT nom_prod, couleur FROM produit NATURAL JOIN provenance WHERE ref_usine='302';

---
--- Q2 Les produits (tous les attributs) dont la couleur est connue. Le
--- résultat est constitué de 19 enregistrements.
---

SELECT * FROM produit WHERE couleur IS NOT NULL;

---
--- Q3 La couleur du produit de référence 22.
---

SELECT couleur FROM produit WHERE ref_prod='22';

---
--- Q4 Les produits dont la couleur est différente de 'bleu'. Le résultat doit
--- comprendre 13 enregistrements. Le produit 22 ne fait pas partie de la
--- réponse.  Est-ce normal ?
---

SELECT * FROM produit WHERE couleur<>'bleu';

-- Oui c'est normal car la couleur du produit 22 est NULL.

---
--- Q5 Les produits dont la couleur et le poids sont connus. Le résultat est
--- constitué de 17 enregistrements.
---

SELECT * FROM produit WHERE couleur IS NOT NULL AND poids IS NOT NULL;

---
--- Q6 Les produits pour lesquels il manque au moins une information de poids
--- ou de couleur. Le résultat est constitué de 6 enregistrements.
---

SELECT * FROM produit WHERE couleur IS NULL OR poids IS NULL;

---
--- Q7 Les produits pour lesquels il manque une et une seule information de
--- poids ou de couleur. Le résultat est constitué de 5 enregistrements.
---

SELECT * FROM produit WHERE (couleur IS NULL AND poids IS NOT NULL) OR (poids IS NULL AND couleur IS NOT NULL);

---
--- Q8 Les couples nom d'usine, nom de magasin qui sont dans la même ville. Le
--- résultat est constitué de 7 enregistrements.
---

SELECT nom_usine, nom_mag FROM magasin NATURAL JOIN usine;

---
--- Q9 Les noms des produits rouges fabriqués à Nantes. Le résultat est
--- constitué de 2 enregistrements.
---

SELECT DISTINCT nom_prod FROM produit NATURAL JOIN provenance NATURAL JOIN usine WHERE ville='Nantes' AND couleur='rouge';

---
--- Q10 Les couples nom de produit, nom de magasin où on peut acheter celui-ci.
--- Le résultat est constitué de 24 enregistrements.
---

SELECT DISTINCT nom_prod, nom_mag FROM produit NATURAL JOIN provenance NATURAL JOIN magasin;

---
--- Q11 Les couples nom de produit, nom de magasin où on peut acheter
--- celui-ci en se limitant aux produits de couleur bleue ou rouge. Le résultat
--- est constitué de 12 enregistrements.
---

SELECT DISTINCT nom_prod, nom_mag FROM produit NATURAL JOIN provenance NATURAL JOIN magasin WHERE couleur IN ('bleu', 'rouge');

---
--- Q12 Les couples de magasins (références) qui s'approvisionnent du même
--- produit fabriqués par la même usine (attention, votre requête ne devrait
--- pas afficher les paires (x,x) composées de deux fois le même magasin.) Le
--- résultat est constitué de 6 enregistrements.
---

SELECT p1.ref_mag, p2.ref_mag FROM provenance AS p1, provenance AS p2 WHERE p1.ref_mag<>p2.ref_mag AND p1.ref_prod=p2.ref_prod AND p1.ref_usine=p2.ref_usine;

---
--- Q13 Ajuster la requête pour ne pas afficher le couple (y,x) si le couple
--- (x,y) est affiché. Le résultat est constitué de 3 enregistrements.
---

SELECT p1.ref_mag, p2.ref_mag FROM provenance AS p1, provenance AS p2 WHERE p1.ref_mag<p2.ref_mag AND p1.ref_prod=p2.ref_prod AND p1.ref_usine=p2.ref_usine;

---
--- Q14 Les noms des lampes fabriquées par peugeot vendues à Bordeaux. Le
--- résultat est constitué de 2 enregistrements.
---

SELECT DISTINCT nom_prod FROM produit NATURAL JOIN provenance NATURAL JOIN magasin JOIN usine ON nom_prod LIKE '%lampe%' WHERE magasin.ville='Bordeaux' AND nom_usine='peugeot';

---
--- Q15 Toutes les références et les couleurs des produits fabriqués et vendus
--- dans la même ville. Le résultat est constitué de 2 enregistrements.
---

SELECT DISTINCT produit.ref_prod, couleur FROM produit, provenance, usine, magasin WHERE provenance.ref_usine=usine.ref_usine AND provenance.ref_prod=produit.ref_prod AND provenance.ref_mag=magasin.ref_mag AND magasin.ville=usine.ville;

----------------------------------------------------------------------------
--- Requêtes plus techniques obligatoires pour les étudiants L2info.
----------------------------------------------------------------------------
---
--- Q16  Les couples de noms de produits différents tels que leurs poids
--- diffèrent d'au plus 2 et tels qu'ils sont vendus dans le même magasin. Le
--- résultat est constitué de 5 enregistrements.
---

SELECT DISTINCT p1.nom_prod, p2.nom_prod FROM produit AS p1, produit AS P2, provenance AS pro1, provenance AS pro2 WHERE pro1.ref_mag=pro2.ref_mag AND pro1.ref_prod=p1.ref_prod AND pro2.ref_prod=p2.ref_prod AND p1.ref_prod<p2.ref_prod AND p1.poids-p2.poids BETWEEN -2 AND 2;

---
--- Q17 Les couples de noms de produits différents tels que leurs poids diffèrent d'au
--- plus 2 et tels qu'ils sont vendus dans la même ville. Le résultat est
--- constitué de 5 enregistrements.
---

SELECT DISTINCT p1.nom_prod, p2.nom_prod FROM produit AS p1, produit AS P2, provenance AS pro1, provenance AS pro2, magasin AS m1, magasin AS m2 WHERE pro1.ref_prod=p1.ref_prod AND pro2.ref_prod=p2.ref_prod AND p1.ref_prod<p2.ref_prod AND m1.ville=m2.ville AND pro1.ref_mag=m1.ref_mag AND pro2.ref_mag=m2.ref_mag AND p1.poids-p2.poids BETWEEN -2 AND 2;

---
--- Q18 Les couples nom de produit, nom de magasin où on peut acheter celui-ci
--- en se limitant aux produits bleus, et aux produits rouges disponibles dans
--- le magasin en quantité supérieure à 400 pièces. Le résultat doit comprendre
--- 9 enregistrements.
---

SELECT DISTINCT nom_prod, nom_mag FROM produit NATURAL JOIN provenance NATURAL JOIN magasin WHERE produit.couleur='bleu' OR (produit.couleur='rouge' AND provenance.quantite>400);
