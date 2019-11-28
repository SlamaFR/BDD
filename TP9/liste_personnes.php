<?php

include "connexion.inc.php";

$results = $cnx->query("SELECT * FROM t_personne p JOIN t_service s on p.service = s.code_service;");

foreach ($results as $line) {
    switch ($line['titre']) {
        case 1:
            echo "Mr ";
            break;
        case 2:
            echo "Mme ";
            break;
        case 3:
            echo "Mlle ";
            break;
    }
    printf("%s %s ", $line['prenom'], $line['nom']);
    printf("est né" . ($line['titre'] > 1 ? "e " : " "));
    printf("le %s et travaille dans le service %s.<br>", $line['date_n'], $line["lib_service"]);
}

$cnx = null;


