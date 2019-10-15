# Pour pouvoir utiliser les fonctions de upemtk
from upemtk import *

LARGEUR_FENETRE = 400
HAUTEUR_FENETRE = 400
# Crée une fenêtre
cree_fenetre(LARGEUR_FENETRE, HAUTEUR_FENETRE)

hauteurs = [100, 200, 350, 40, 160, 210, 130, 80, 170, 300, 280, 210, 320, 30, 70]

for i, h in enumerate(hauteurs):
    rectangle(i * 20, HAUTEUR_FENETRE, (i + 1) * 20, HAUTEUR_FENETRE - h, remplissage='black')

# cercle(300, 250, 50, remplissage='red')

# attend que l'utilisateur clique dans la fenêtre
attente_clic()
# ferme la fenêtre
ferme_fenetre()
