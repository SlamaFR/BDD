CREATE TABLE authentification
(
    id    serial primary key,
    login varchar(32),
    mdp   varchar(100)
);

-- Création de quelques logins bidons.
INSERT INTO authentification VALUES ('pchochois', md5('AZERTYUIOP'));
INSERT INTO authentification VALUES ('cdavid', md5('QSDFGHJKLM'));
INSERT INTO authentification VALUES ('obouillot', md5('WXCVBNHGFDSQ'));