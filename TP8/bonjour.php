<?php

if (isset($_GET['prenom']))
    $prenom = $_GET['prenom'];
else if (isset($_POST['prenom']))
    $prenom = $_POST['prenom'];
else {
    echo 'Il y a quelqu\'un ?';
    return;
}

if (isset($_GET['age']))
    $age = $_GET['age'];
else if (isset($_POST['age']))
    $age = $_POST['age'];

if (isset($_GET['sexe']))
    $sexe = $_GET['sexe'];
else if (isset($_POST['sexe']))
    $sexe = $_POST['sexe'];

?>

<html>

<?php include("header.php") ?>

<?php printf("Bonjour %s %s, vous avez %d ans.", $sexe, $prenom, $age); ?>

<?php include("footer.php") ?>
</html>

