<?php

function fact($x)
{
    if ($x == 1)
        return $x;
    return $x * fact($x - 1);
}

?>
<html>

<?php include("header.php") ?>

<?php

if (isset($_POST['x'])) {
    printf("%d! = %d", $_POST['x'], fact($_POST['x']));
} else { ?>
    <form action="factorielle.php" method="post">
        <p>Calcul de x!</p>
        Valeur de x : <input name="x" type="number">
        <input type="submit">
    </form>
<?php } ?>

<?php include("footer.php") ?>
</html>