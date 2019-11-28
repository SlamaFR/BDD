<?php include "connexion.inc.php"; ?>
<!DOCTYPE>
<html lang="fr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Formulaire de saisie d'une personne</title>
    <style type="text/css">
        body {
            background-color: #ffd;
            font-family: Verdana, Helvetica, Arial, sans-serif;
        }
    </style>
</head>

<body>
<h1>Gestion des employés</h1>

<h3>Création d'un employé</h3>
<form action="insertion_employe.php" method="POST">
    <p>Nom <input type="text" name="nom" size="40"/>
        Prénom <input type="text" name="prenom" size="20"/><br/>
        <input type="radio" name="titre" value="1" checked/>M. <br/>
        <input type="radio" name="titre" value="2"/>Mme <br/>
        <input type="radio" name="titre" value="3"/>Mlle <br/>
        Date de naissance <input type="date" name="date_n" size="6" value="aa/mm/jj"/> <br/>
        Service <select name="service">
            <option value="" selected="selected">-- service --</option>
            <?php foreach ($cnx->query('SELECT * FROM t_service') as $service): ?>
                <option value="<?= $service['code_service'] ?>"><?= $service['lib_service'] ?></option>
            <?php endforeach ?>
        </select>
    </p>
    <p>
        Loisirs <br/>
        <?php foreach ($cnx->query('SELECT * FROM t_loisir') as $loisir): ?>
            <input type="checkbox" name="loisirs[]" value="<?= $loisir['code_loisir'] ?>"/> <?= $loisir['lib_loisir'] ?>
            <br>
        <?php endforeach ?>
    </p>
    <p>
        <input type="reset" name="reset" value="Effacez"/>
        <input type="submit" name="submit" value="Validez"/>
    </p>
</form>

<h3>Édition des loisirs d'un employé</h3>
<form action="insertion_pratique.php" method="post">
    <p>
        <label>Numéro d'employé :
            <select name="num">
                <?php foreach ($cnx->query('SELECT num FROM t_personne;') as $num): ?>
                    <option><?= $num['num'] ?></option>
                <?php endforeach ?>
            </select>
        </label>
    </p>
    <p>
        <?php foreach ($cnx->query('SELECT * FROM t_loisir') as $loisir): ?>
            <label>
                <input type="checkbox" name="loisirs[]" value="<?= $loisir['code_loisir'] ?>"/>
                <?= $loisir['lib_loisir'] ?>
            </label>
        <?php endforeach ?>
    </p>
    <p>
        <input type="submit" name="add" value="Ajouter">
        <input type="submit" name="del" value="Supprimer">
    </p>
</form>

</body>
</html>
