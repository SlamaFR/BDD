<?php

include("header.php");

if (isset($_POST['jour']) AND isset($_POST['mois']) AND isset($_POST['annee']))
    printf("<p>La date choisie est le %d/%d/%d</p>", $_POST['jour'], $_POST['mois'], $_POST['annee']);

if (isset($_POST['loisirFav']))
    printf("<p>Votre loisir favori est : %s</p>", $_POST['loisirFav']);

if (!empty($_POST['loisirPratiques'])) {
    sort($_POST['loisirPratiques']);
    printf("Vous pratiquez aussi comme loisirs : %s", implode(" - ", $_POST['loisirPratiques']));
}

include("footer.php");

