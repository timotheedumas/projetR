# Dashboard sur les apparitions d'UFOs depuis 1910

Ce dashboard a été réalisé par Timothée DUMAS et Yannis TUMELIN dans le cadre de l'unité DSIA-4101C : R & Data Visualisation.

## La base de données (https://www.kaggle.com/datasets/jonwright13/ufo-sightings-around-the-world-better)

La base de données contient des informations sur les UFOs (objets volants non identifiés) recensés entre 1910 et 2014. L'organisation qui à produit ce jeu de donnée est NUFORC. Les colonnes présentes dans le CSV téléchargé sont : 
- Date_time
- date_documented
- Year
- Month
- Hour
- Season 
- Country_Code
- Country
- Region
-  Locale
- latitude
- longitude
- UFO_shape
- length_of_encounter_seconds
- Encounter_Duration,
- Description

A l'aide du script clean.py nous retirons les valeurs manquantes ainsi que les colonnes :
- Encounter_Duration
- Country_Code
- Month
- Locale

Nous calculons à l'aide de la colonne "length_of_encounter_seconds" la durée de la rencontre en minutes.

## User Guide

Le but de ce projet est d'analyser et de visualiser les données collectées par la NUFORC. 

### Installation 

ouvrer un terminal sur votre machine locale et placer vous dans le répertoire souhaité puis taper cette liste de commandes  :

1. git clone https://github.com/timotheedumas/projetR.git # pour cloner le répertoire git sur votre machin
 
Avant de continuer vérifier à l'aide votre explorateur de fichiers que tout les fichiers ont bien tous étés téléchargés dans le même dossier. Puis :

2. R # permet de lancer R
3. Installer les packages listés dans le requirement.txt à l'aide de la commande install.packages("nomPackage)
4. library(shiny) # permet de charger la librairie Shiny
5. runApp() # lance l'application R 

### Utilisation

l'application s'ouvre alors, et vous pouvez naviguer entre les différents onglets en cliquant dessus. Pour certains onglets, vous pouvez sélectionner l'année à laquelle les données ont étés collectées en faisant glisser le curser sur la barre "Year".


## Developer Guide

Un « Developer Guide » qui permet de comprendre l’architecture du code et de modifier ou d’étendre celui-ci.

## Analyse des résultats

- Graphique du nombre d'UFO par an :
Le nombre d'UFO recensés augmente au cours des années, notamment autour des années 2000 où l'émergence d'Internet a favorisé les théories du complot. La forte baisse du nombre de données en 2014 est simplement due au fait que la base de données a été constituée au milieu de l'année 2014 et donc il n'y a que la moitié de l'année de représentée.

- Histogramme sur la durée d'apparition :
La plupart des apparitions durent entre 10 secondes et 30 minutes (surtout entre 1 et 5 minutes).

- Camembert sur les saisons :
Les UFOs sont plus souvent observés en été, beaucoup moins en hiver. Les extraterrestres seraient-ils frileux ? Ou simplement le ciel est plus dégagé en été donc les objets volants sont plus visibles.

- Camembert sur les formes d'UFO :
Ce graphique montre que les formes prédominantes sont circulaires (cercle, disque, ovale...), triangulaires et lumineuses.

- Répartition des UFO dans le monde :
La plupart des UFOs sont observés dans les pays anglophones tels que les États-Unis, l'Angleterre, l'Inde et l'Australie, probablement car "UFO" est un terme anglais. L'écrasante majorité des données sont recensées aux États-Unis, peut-être parce que la culture de l'UFO y est plus répandue, ou peut-être parce que les aliens sont des amateurs de cheeseburgers ?
