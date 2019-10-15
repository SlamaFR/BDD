# Pour pouvoir utiliser les fonctions de upemtk
from upemtk import *
import psycopg2

try:
    cnx = psycopg2.connect("dbname='irwin' user='irwin' password=''")
except:
    print("An error occurred while connecting to the database!")
else:
    cnx.autocommit = True
    cursor = cnx.cursor()
    requete = "SELECT ref_batiment, hauteur FROM batiment;"

    hauteurs = list()

    cursor.execute(requete)
    for result in cursor:
        hauteurs.append(result[1])

    cursor.close()
    cnx.close()

    LARGEUR_FENETRE = 400
    HAUTEUR_FENETRE = 400
    cree_fenetre(LARGEUR_FENETRE, HAUTEUR_FENETRE)


    for i, h in enumerate(hauteurs):
        rectangle(i * 20, HAUTEUR_FENETRE, (i + 1) * 20, HAUTEUR_FENETRE - h, remplissage='black')

    attente_clic()
    ferme_fenetre()
