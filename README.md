# Dashboard sur les apparitions d'UFOs depuis 1910

Ce dashboard a été réalisé par Timothée DUMAS et Yannis TUMELIN. 

## La base de données

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

A l'aide du script clean.py nous retirons les valeurs manquantes ainsi que les colonnes "Encounter_Duration", "Country_Code","Month" et "Locale". Nous calculons à l'aide de la colonne "length_of_encounter_seconds" la durée de la rencontre en minutes.

## User Guide

Un « User Guide » qui permet de déployer et d’utiliser votre dashboard sur une autre machine.

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
