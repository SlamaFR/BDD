<?php

if (empty($_POST['pseudo']) OR empty($_POST['mdp'])) {
    header('location: form_auth.php');
    return;
}

$user = 'irwin';
try {
    $cnx = new PDO('pgsql:host=localhost;dbname=irwin', $user, '');
} catch (PDOException $e) {
    echo "ERREUR : La connexion a échouée";
}

$requete = $cnx->prepare("SELECT * FROM authentification WHERE login=:login;");
$requete->bindValue(":login", $_POST['pseudo']);
$requete->execute();
$resultat = $requete->fetchAll();

if (empty($resultat)) {
    header('location: form_auth.php');
    return;
}

if ($resultat[0]['mdp'] != md5($_POST['mdp'])) {
    header('location: form_auth.php');
    return;
}

echo 'Authentification réussie !';

