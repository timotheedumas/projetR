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

- git clone https://github.com/timotheedumas/projetR.git # pour cloner le répertoire git sur votre machin
 
Avant de continuer vérifier à l'aide votre explorateur de fichiers que tout les fichiers ont bien tous étés téléchargés dans le même dossier. 

- Ouvrez R studio
- Installer les packages listés dans le requirement.txt à l'aide de la commande install.packages("nomPackage")
- entrer runApp() dans la console ou bien selectionner app.R et cliquer sur le bouton "run App"


### Utilisation

l'application s'ouvre alors, et vous pouvez naviguer entre les différents onglets en cliquant dessus. Pour certains onglets, vous pouvez sélectionner l'année à laquelle les données ont étés collectées en faisant glisser le curseur sur la barre "Year".


- l'onglet "Histogram" contient un histogramme des durées d'observations des UFO par année, ainsi qu'un curseur pour sélectionner l'année.

-  l'onglet "Distribution of the hours of UFO encounters" contient un histogramme des heures d'observations des UFO par année.

- l'onglet "Pie chart Seasons" contient un diagramme circulaire représentant la répartition des rencontres UFO par saison, ainsi qu'un curseur pour sélectionner l'année.

- l'onglet "Pie chart Shapes" contient un diagramme circulaire représentant la répartition des formes d'UFO, ainsi qu'un curseur pour sélectionner l'année.

- l'onglet "plot of the UFO encounters per year" contient une graphique avec une courbe représentant le nombre total de rencontres d'UFO par année.

- l'onglet "Map of the UFO encounters" contient une carte interactive avec des points indiquand les lieux d'observation des UFO, ainsi qu'un curseur pour sélectionner l'année. En cliquant sur les points vous aurez accès à une description plus poussée.



## Developer Guide

Tout d'abord le script clean.py est utilisé pour nettoyer les données, si vous souhaitez modfier le nettoyage effectué ou ajouter de nouvelles colonnes, c'est ce fichier qu'il faut modifier et exécuter.

Le dashboard shiny est constitué de trois fichiers différents: 

- app.R 
- ui.R
- server.R

### app.R
    
Ce fichier permet d'exécuter l'ui et le server  à l'aide de source() puis de créer l'application à l'aide de la fonction shinyApp() qui prend ici en paramètres ui et server.

### ui.R 

Ce fichier permet de gérer le front-end, la partie visible par l'organisateur.
Au début de ce fichier sont chargées les librairies nécessaires ainsi que les données. L'interface utilisateur est ensuite définie à l'aide de la fonction fluidPage(). titlePanel() permet de spécifier le titre qui sera affiché en haut du dashboard.

Plusieurs onglets sont ensuite définis dans tabsetPanel(). 

par exemple : "Histogram" contient un histogramme des durées d'observations des UFO par année, ainsi qu'un curseur pour sélectionner l'année, ce dernier est défini à l'aide de SliderInput()

pour ajouter un onglet il faut utiliser la fonction tabPanel().

### server.R

Ce fichier permet de gérer la logique et les calculs.

Au début de ce fichier sont chargées les librairies nécessaires ainsi que les données. La fonction server() permet de gérer la logique côté serveur.

Le code  dans cette fonction peut se diviser en plusieurs blocs, un bloc correspondant au final à un onglet dans l'ui, tout les blocs à l'exception du deuxième permettent de génerer des sorties dynamiques à l'aide de fonctions telles que renderPlot() ou renderLeaflet() :

- le premier bloc permet de filtrer les données et de tracer l'histogramme pour les durées des rencontres. Il contient aussi un bloc de gestion des erreurs.
- le second bloc permet de tracer l'histogramme des rencontres en fonctions des heures de la journée.
- le troisième bloc permet de filtrer les données et de tracer le diagramme circulaire pour la répartition des observations par saison. Dans la fonction renderPlot(), un bloc if-else permet de gérer le cas ou les données ne sont pas suffisament pertinentes pour tracer le graphique.
-  le quatrième bloc permet de filtrer les données et de tracer le diagramme circulaire pour la répartition des formes des UFO observés. Il est structuré de la même manière que le troisième bloc.
- le cinquième bloc permet d'afficher la carte interactive.




## Analyse des résultats



- Histogramme sur la durée d'apparition :
La plupart des apparitions sont courtes et durent entre 10 secondes et 30 minutes (majoritairement entre 1 et 5 minutes). On constate que beaucoup plus d'apparitions ont étées recensées à partir des années 1950.

- Histogramme des heures d'apparition : On constate que la plupart des observations d'UFO ont lieues en début de soirée, et plus généralement durant la nuit. 
Ce contexte plus sombre à des heures de fatigue ou de sommeil pourrait expliquer pourquoi plus d'observations sont recensées la nuit.

- Diagramme circulaire  sur la répartition des apparitions par saison :
Les UFOs sont plus souvent observés en été, beaucoup moins en hiver. Le ciel est plus dégagé en été donc les objets volants sont plus visibles, de plus il y a plus d'étoiles filantes en été, ce qui pourrait mener à confusion avec des UFO.

- Diagramme circularie sur la répartition des formes d'UFO :
Ce graphique montre que les formes prédominantes sont circulaires (cercle, disque, ovale...), triangulaires et lumineuses.

- Graphique du nombre d'observations d'UFO par an :
Le nombre d'UFO recensés augmente au cours des années, notamment autour des années 2000 où l'émergence d'Internet a favorisé les théories du complot. La forte baisse du nombre de données en 2014 est simplement due au fait que la base de données a été constituée au milieu de l'année 2014 et donc il n'y a que la moitié de l'année de représentée.

- Répartition des UFO dans le monde :
La plupart des UFOs sont observés dans les pays anglophones tels que les États-Unis, l'Angleterre, l'Inde et l'Australie, probablement car "UFO" est un terme anglais. L'écrasante majorité des données sont recensées aux États-Unis, sûrement parce que l'organisation productrice de ces données est américaine et qu'il lui est donc plus facile de collecter des données.


En ce basant sur les analyses de ces graphiques, on peut en conclure que les observations d'UFO sont souvent faites dans des contextes défavorables, de nuit et avec des durées très courtes. On peut alors avancer que la plupart de ces observations sont éronnées et sont surement des erreurs.