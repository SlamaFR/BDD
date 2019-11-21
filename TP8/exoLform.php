<?php

$MONTHS = [
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Août',
    'Septembre',
    'Octobre',
    'Novembre',
    'Décembre'
];
$LOISIRS = ['Sport', 'Musique', 'Jeux', 'Voyages'];

?>

<html>

<?php include("header.php") ?>

<form action="exoLaffiche.php" method="post">
    <label for="jour">Jour :</label>
    <select id="jour" name="jour">
        <?php for ($i = 1; $i <= 31; $i++): ?>
            <option><?= $i ?></option>
        <?php endfor; ?>
    </select>
    <label for="mois">Mois :</label>
    <select id="mois" name="mois">
        <?php for ($i = 0; $i < sizeof($MONTHS); $i++): ?>
            <option value="<?= $i + 1 ?>"><?= $MONTHS[$i] ?></option>
        <?php endfor; ?>
    </select>
    <label for="annee">Année :</label>
    <select id="annee" name="annee">
        <?php for ($i = 1990; $i <= 2012; $i++): ?>
            <option><?= $i ?></option>
        <?php endfor; ?>
    </select>
    <p>Loisir favoris :</p>
    <?php for ($i = 0; $i < sizeof($LOISIRS); $i++): ?>
        <input name="loisirFav" type="radio" id="loisir_f_<?= $i ?>" value="<?= $LOISIRS[$i] ?>">
        <label for="loisir_f_<?= $i ?>"><?= $LOISIRS[$i] ?></label>
    <?php endfor; ?>
    <p>Loisir pratiqués :</p>
    <?php for ($i = 0; $i < sizeof($LOISIRS); $i++): ?>
        <input name="loisirPratiques[]" type="checkbox" id="loisir_p_<?= $i ?>" value="<?= $LOISIRS[$i] ?>">
        <label for="loisir_p_<?= $i ?>"><?= $LOISIRS[$i] ?></label>
    <?php endfor; ?>
    <p><input type="submit"></p>
</form>

<?php include("footer.php") ?>

</html>