<?php

include "connexion.inc.php";
$add_query = 'INSERT INTO pratique values (:num, :code)';
$del_query = 'DELETE FROM pratique WHERE num = :num AND code_loisir = :code';

if (isset($_POST['add']) OR isset($_POST['del'])) {
    if (!empty($_POST['num']) AND !empty($_POST['loisirs'])) {
        foreach ($_POST['loisirs'] as $loisir) {
            $result = $cnx->prepare(isset($_POST['add']) ? $add_query : $del_query);
            $result->execute(array(":num" => $_POST['num'], ":code" => $loisir));
        }
        echo "Édition réussie !";
    } else {
        printf('Erreur lors de l\'édition de votre loisir pour l\'employé %d !', $_POST['num']);
    }
} else {
    echo 'Merci de passer par <code>form_DB.html</code>.';
}

$cnx = null;
