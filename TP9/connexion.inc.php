<?php

/*
 * Création d'objet PDO de la connexion qui sera représentée par la variable $cnx.
 */
$user = 'irwin';
$pass = '';
try {
    $cnx = new PDO('pgsql:host=localhost;dbname=irwin', $user, $pass);
} catch (PDOException $e) {
    echo "ERREUR : La connexion a échouée";
}
