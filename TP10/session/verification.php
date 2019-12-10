<?php

session_start();

if (!isset($_SESSION['login']) OR !isset($_SESSION['mdp'])) {
    header('location: form_auth.php');
    return;
}

