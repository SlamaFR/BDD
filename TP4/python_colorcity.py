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
    requete = "SELECT ref_batiment, hauteur, couleur, batiment.ref_type FROM batiment NATURAL JOIN type;"

    hauteurs = list()
    couleurs = list()
    types = list()

    cursor.execute(requete)
    for result in cursor:
        hauteurs.append(result[1])
        couleurs.append(result[2])
        types.append(result[3])

    cursor.close()
    cnx.close()

    LARGEUR_FENETRE = 400
    HAUTEUR_FENETRE = 400
    offset = 0
    cree_fenetre(LARGEUR_FENETRE, HAUTEUR_FENETRE)

    for i, h in enumerate(hauteurs):
        rectangle(offset, HAUTEUR_FENETRE, offset + 10 * types[i], HAUTEUR_FENETRE - h, remplissage=couleurs[i])
        offset += 10 * types[i]

    attente_clic()
    ferme_fenetre()
