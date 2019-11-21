<?php

if (!isset($_POST))
    return;

?>
<html>
<body>
<p>Consultation de :</p>
<ul>
    <li><a href="etatcivil.php?prenom=<?= $_POST['prenom'] ?>&nom=<?= $_POST['nom'] ?>">Votre état civil</a></li>
    <li><a href="adresse.php?adresse=<?= $_POST['adresse'] ?>">Votre adresse</a></li>
</ul>
</body>
</html>
