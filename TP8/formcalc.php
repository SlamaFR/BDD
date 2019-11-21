<html>

<?php include("header.php") ?>

<form action="formcalc.php" method="post">
    Opérandes :
    <input name="op1" type="number">
    <input name="op2" type="number"><br>
    Opérateur :
    <input id="op_add" name="operateur" value="+" type="radio" checked>
    <label for="op_add">Addition</label>
    <input id="op_sub" name="operateur" value="-" type="radio">
    <label for="op_sub">Soustraction</label>
    <input id="op_mul" name="operateur" value="*" type="radio">
    <label for="op_mul">Multiplication</label>
    <input id="op_div" name="operateur" value="/" type="radio">
    <label for="op_div">Division</label>
    <input type="submit">
</form>

<?php

if (isset($_POST['op1']) AND isset($_POST['op2']) AND isset($_POST['operateur'])) {
    switch ($_POST['operateur']) {
        case '+':
            $result = $_POST['op1'] + $_POST['op2'];
            break;
        case '-':
            $result = $_POST['op1'] - $_POST['op2'];
            break;
        case '*':
            $result = $_POST['op1'] * $_POST['op2'];
            break;
        case '/':
            $result = $_POST['op1'] / $_POST['op2'];
            break;
        default:
            echo 'Erreur d\'opérateur&nbsp;!';
            return;
    }

    echo '<hr>';
    printf("%d %s %d = %d", $_POST['op1'], $_POST['operateur'], $_POST['op2'], $result);
}

?>

<?php include("footer.php") ?>
</html>