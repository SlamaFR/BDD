<?php

if (!isset($_GET['prenom']) OR !isset($_GET['nom']))
    return;

?>
<html>
<body>
<p>Prénom : <?= $_GET['prenom'] ?></p>
<p>Nom : <?= $_GET['nom'] ?></p>
</body>
</html>
