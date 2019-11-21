<?php

if (!isset($_GET['adresse']))
    return;

?>
<html>
<body>
<p>Vous habitez :</p>
<p><?= $_GET['adresse'] ?></p>
</body>
</html>
