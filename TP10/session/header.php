<?php

echo "Vous êtes connecté(e) en tant que <b>" . $_SESSION['login'] . "</b><br>";

echo "Ce n'est pas vous ? <button onclick='document.location.href=\"logout.php\"'>Déconnexion</button>";