--
-- Q1.1 : Listez les différents services contenant au moins un employé.
--
SELECT lib_service
FROM t_service s
         JOIN t_personne p ON s.code_service = p.service
GROUP BY code_service
HAVING count(code_service) > 0;

--
-- Q1.2 : Listez les différents loisirs recensés dans la base de donnée.
--
SELECT *
FROM t_loisir;

--
-- Q2 : Créez dans votre base la table pratique(num,code_loisir) pour pouvoir référencer
-- les loisirs des différents employés.
--
CREATE TABLE pratique
(
    num         int,
    code_loisir char(3),
    CONSTRAINT pratique_pk
        PRIMARY KEY (num, code_loisir)
);

--
-- Q3 : Rajouter dans la table l’information que Arsene ESPOSITO pratique le poney et
-- le pédalo et que Elise BRUNNER pratique le dessin, le Tennis et le Ski.
--
INSERT INTO pratique VALUES (5, 'pon');
INSERT INTO pratique VALUES (5, 'ped');
INSERT INTO pratique VALUES (15, 'des');
INSERT INTO pratique VALUES (15, 'ten');
INSERT INTO pratique VALUES (15, 'ski');
