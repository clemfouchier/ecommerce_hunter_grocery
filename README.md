# Analyse des données du site web de l'épicerie en ligne Hunter Grocery avec SQL et PowerBI
![Logo Hunter Grocery](https://github.com/clemfouchier/ecommerce_hunter_grocery/blob/main/Logo_hunter_grocery.png?raw=true)

## Introduction

Je vous présente aujourd'hui un projet personnel basé sur des données réelles de consomation d'un site web, partagées par l'entreprise pour inciter les Data Analysts et Data Scientists à améliorer leur produit. 

La première partie sera consacrée à la l'analyse. Et la seconde détaillera les étapes du projet, de manière à ce qu'il puisse être reproduit.


# PARTIE 1 : L'ANALYSE

## Contexte :

Le site "The Hunter Grocery", qui propose la livraison de produits issus d'épiceries locales, a mis à disposition en libre-service des données qui rescencent l'ensemble des produits commandés pendant l'année 2022 : https://www.kaggle.com/datasets/hunter0007/ecommerce-dataset-for-predictive-marketing-2023

Elles ont été mises en ligne pour effectuer des opérations de Machine Learning comme de la personnalisation des recommandations ou du clustering. J'ai choisi d'utiliser ce jeu de données pour produire une analyse grâce à la visualisation des données clés. Le tout avec pour objectif d'accroître les ventes sur le site.


## Méthodologie : 

Pour visualiser les données efficacement, j'ai choisi d'utiliser l'excellent outil de Dataviz (et bien plus) de Microsoft : PowerBI. Concrètement, j'ai créé un tableau de bord qui synthétise les principales informations du site. Je les ai analysées en les présentant sous forme de storytelling, et j'ai émis des recommandations pour répondre à l'objectif.

Lors de ce projet, je me suis rajouté un petite difficulté supplémentaire : l'utilisation unique de SQL et PowerBI pour le nettoyage, le traitement des données, l'analyse et la création du tableau de bord. Autrement dit, je me suis interdit l'utilisation de Python, finalement très utile, comme je vais m'en rendre compte, pour l'exploration des données.

J'ai également cherché à utiliser ChatGPT pour enrichir le projet, de plusieurs manières :
- L'IA générative m'a donnée des consignes à suivre.
- Elle m'a permis d'enrichir les données en créant les variables suivantes : les quantités achetées, les prix des produits et les dates de livraison pour me permettre de manipuler ce type de données sur SQL et dans PowerBI.
- L'aide pour créer les formules DAX.
- Du conseil sur les requêtes SQL, notamment parfois les manières de les simplifier.

Avec des résultats pas toujours escomptés sur certaines tâches, comme développé dans la partie 2 "étapes"..


## Tableau de bord :

![Tableau de bord final](https://github.com/clemfouchier/ecommerce_hunter_grocery/blob/main/dashboard_ecommerce.png?raw=true)
(Vous pouvez cliquer sur l'image pour l'agrandir)

A savoir : sur PowerBI, les tableaux de bords sont interactifs. Par exemple, si je clique sur la barre "Lundi", tous les autres chiffres seront modifiés pour ne prendre en compte que les commandes réalisées un lundi. Voici le résultat :

![Tableau de bord quand on clique sur "lundi"](https://github.com/clemfouchier/ecommerce_hunter_grocery/blob/main/dashboard_ecommerce_lundi.png?raw=true)

Ce qui permet de savoir par exemple que 29 000 clients ont effectué une commande, que les fruits et légumes sont plus commandés que d'habitude, et que le pic a plus lieu entre 13h et 15h

Aussi, l'ensemble des tâches, de la préparation des données à la création des graphiques, sont automatisées. Ce qui signifie que le mois prochain, si les données sont collectées de la même manière, ce tableau de bord sera mis à jour avec les nouvelles données.


## Enseignements :

***1. L'enjeu prioritaire devrait être la fidélisation des utilisateurs***

En regardant les chiffres présentés à gauche, nous apprenons qu'il y a 105 000 clients actifs environ pour 200 000 commandes. Ce qui donne un nombre de commandes par client en moyenne de 1,9. 

Ce chiffre démontre une faible fidélité des utilisateurs, qui semblent réaliser des achats ponctuels sur la plateforme, par exemple pour acheter les ingrédients nécéssaires à la réalisation de recettes bien précises. Ce qui semble d'ailleurs mis en évidence sur le site : 

![Apperçu site Hunter Grocery](https://github.com/clemfouchier/ecommerce_hunter_grocery/blob/main/find_by_ingrediants.png?raw=true)

Pour un développement des ventes, il devrait être ancré dans les habitudes d'achat des individus.


***2. Autres objectifs moins prioritaires : augmenter le nombre de références achetées et de nouveaux clients***

Le nombre de références achetées par panier, de 10, peut être amélioré, notamment en proposant plus de produits. Mais, à ce stade, ce chiffre est acceptable.

Le nombre de nouveaux clients (12 000) peut toujours s'améliorer, mais avant de viser cet objectif, qui passerait par la communication, une autre étape me semble nécessaire : la mise en place d'actions marketing pour renforcer la marque et l'expérience client... développés dans la partie recommandation.


***3. Les utilisateurs sont majoritairement attirés par les produits frais.***

Plus de la moitié des produits achetés (en vert foncé &#x1F49A;) concernent des produits frais, à commencer par les fruits et légumes, mais aussi les produits laitiers, et les produits de boulangerie.

Par ailleurs, lorsque l'on regarde les produits qui ont été re-commandés (en vert clair &#x1F4D7;), c'est-à-dire les produits qui ont été à nouveau achetés par les utilisateurs, nous constatons qu'ils re-commandent davantage les produits frais, notamment les fruits et légumes et les produits laitiers.

Enfin, lorsque l'on zoom sur les produits mis en premier dans le panier (en marron &#x1F534;), nous voyons que les boissons se placent en troisième position, prenant la place des snacking. Il s'agit donc de produits attractifs, avec les produits frais dont les fruits et légumes et les produits laitiers. Ils seront potentiellement plus déclancheurs de l'envie de commander. 

Ce trio confirme le positionnement de Hunter Grocery sur les produits frais et sains. Ce seront les produits d'appel à mettre en avant.


***4. Le lundi et le mardi sont les jours où le plus de commandes sont réalisées.***


***5. La plupart des commandes sont effectuées entre 9h et 17h, avec un pic à 10h.***

Si des relances devaient être mises en place, le lundi à 9h semble être une bonne option et/ou le dimanche soir à 19h si l'on souhaite anticiper.


## Recommandations : 

Selon moi, l'enjeu de Hunter Grocery est aujourd'hui de **travailler sur le "produit" pour le rendre plus désirable et ainsi l'ancrer dans les habitudes**, tout en conservant son positionnement sur les produits sains et sur la mise en avant d'épiceries locales.

Avant d'attirer de nouveaux clients, il convient de **créer un expérience unique et attractive** à tous les niveaux, de manière à tisser un lien avec les indidus. Ainsi, il sera possible de **transformer les utilisateurs les plus fidèles en ambassadeurs de la marque**. Voici donc mes préconisations concrètes : 

1. Mettre un place un service de **newsletter** chaque semaine ou chaque mois **proposant des recettes de saison à cuisiner avec des produits frais**. Il faudrait au préalable s'assurer que l'on ne puisse commander que lorsque l'on est loggés pour pouvoir envoyer des campagnes d'emails.

2. Mettre en place un système de **"carte de fidélité" en gamifiant l'approche**, c'est-à-dire avec un système de points, des badges à gagner, voire ajouter un système "communautaire" pour partager ses accomplissements avec ses amis.

3. Créer du contenu pour **informer sur les bonnes pratiques pour se nourrir sainement**, sur les bienfaits de la consommation dans les épiceries locales et/ou la mise en avant des épiciers.

4. Utiliser les emails et les SMS pour **communiquer avec les clients**. Par exemple les SMS pour communiquer sur des promotions près de chez l'individu, et les emails pour communiquer sur les nouveautés (produits, articles, annonces...). Prendre contact au travers de plusieurs médiums permet de favoriser la mémorisation spontannée de la marque.

Bonnes pratiques concernant la communication:
- Pour les communications, **privilégier le dimanche soir et/ou le lundi matin**, soit au plus proche de jours de commande, et **communiquer à intervalle régulier pour créer une habitude**.
- A chaque fois, **mettre en avant les produits attractifs** : fruits et légumes, produits laitiers, boissons, sur lesquelles le site peut se différencier.

L'ensemble de ces propositions sont en phase avec le positionnement de Hunter Grocery et respectent le choix du site de ne pas mettre en avant de produits particuliers.

Ainsi, à la fois la marque et le produit Hunter Grocery se trouveraient renforcés, ce qui favorisera la fidélisation des utilisateurs. Une fois cette étape terminée, il sera possible d'aller chercher de nouveaux clients, puis d'essayer d'augmenter le panier par utilisateur.

Pour aller plus loin il est possible de :
- Personnaliser les moments de la relance en fonction des habitudes d'achat
- Créer des personae avec du clustering pour avoir une meilleure compréhension de la clientèle et pour personnaliser les relances et les recommandations de produits.


# PARTIE 2 : ETAPE PAR ETAPE

Pour ceux qui aimeraient reproduire le projet ou comprendre le fonctionnement des outils, voici l'ensemble des étapes du projet, de l'installation de SQL à la vérification des chiffres utilisés.

Je mets aussi à chaque fois les ressources qui m'ont aidées lorsque nécessaire.


## 1. L'enrichissement des données avec ChatGPT

ChatGPT est un bon outil pour générer synthétiquement des jeux de données ou pour enrichir un jeu de données existant par des nouvelles colonnes, essentiellement dans un but éducatif, pour manipuler certains types de données dans SQL et PowerBI.

Voici les données que j'ai essayées de créer :
- Les quantités achetées pour chaque référence
- Le prix pour chaque référence
- Les dates d'achat

Utilisant la version gratuite, ChatGPT n'a pas pu m'envoyer les données modifiées. J'ai donc dû créer un script Python (update_data.py) sur la base du code envoyé et l'executer via la commande Windows.

Finalement, je n'ai utilisé aucune de ces données dans le tableau de bord final. Certaines variables étaient plus pertinentes que d'autres. J'aurais pu utiliser les quantités, qui étaient cohérentes, s'il y avait un volet logistique à l'analyse. Les prix étaient en général peu pertinants, voire fantaisistes. Ils auraient rendu l'analyse étrange. 

Mais surtout, ChatGPT n'a pas du tout respecté les consignes sur l'édition des dates (à sa décharge, ce n'était pas une tâche facile), ce qui a rendu la variable totalement inutilisable. C'est fort dommage, puisque les dates sont incontournables dans le monde de la data, et leur manipulation est souvent spécifique à chaque outil. Elle m'a uniquement permis d'utiliser une table calendaire dans PowerBI dans le but de m'exercer.

N'hésitez pas à me contacter pour avoir le prompt.

Source pour la création de données synthétiques via ChatGPT : https://medium.com/@atifhussain/why-and-how-i-use-chatgpt-to-create-synthetic-datasets-for-my-students-f2ca427ea860


## 2. L'installation de SQL sur mon PC (Postgre)

Avant toute manipulation, j'ai dû installer SQL sur mon PC, puisque c'est la première fois que je manipule ce langage dans le cadre d'un projet personnel.

Gratuit et largement utilisé en entreprise, j'ai opté pour Postgre. Je l'ai ensuite couplé à VSCode pour profiter des bienfaits de l'IDE.

Pour l'installer chez vous, vous pouvez suivre cette vidéo à partir d'1h26 minutes : https://www.youtube.com/watch?v=7mz73uXD9DA&t=6623s


## 3. L'intégration du jeu de données dans SQL

Une fois l'environnement SQL mis en place, j'ai pu intégrer les données en suivant les étapes suivantes :
- Créer la table (CREATE TABLE) en mettant le type de données colonne par colonne.
- Créer un test pour regarder si tout va bien (INSERT VALUES)
- Modifier le type (ALTER TABLE xx ALTER COLUMN xx TYPE xx)
- Supprimer le test (DELETE FROM xx WHERE xx = xx)
- Charger les données (COPY ...)

Attention, pour que les données soient chargées, j'ai du déplacer mon fichier de données dans le dossier "Public" : C:\Users\Public.

En plus de la vidéo envoyée ci-dessus, ce site m'a aidé : https://learnsql.fr/blog/comment-importer-des-fichiers-csv-dans-Postgreql-avec-pgadmin/


## 4. L'analyse exploratoire des données dans SQL

Une fois que les données sont intégrées, nous pouvons commencer à les manipuler et à les modifier si nécessaire. L'analyse exploratoire des données consiste à se familiariser avec les données, en vérifier la qualité/détecter les anomalies, et à les explorer pour produire des analyses.

Je ne vais pas détailler l'ensemble des étapes de ce travail fastidieux sur SQL (nettement plus que si je l'avais réalisé via Python), que vous trouverez dans le fichier "EDA_ecommerce.sql". Mais je peux vous dresser le bilan de cette étape et les enseignements que j'en tire.

L'analyse exploratoire en SQL m'a permis d'en constater les forces et les faiblesses, en compraison de Python.

**Les forces, c'est un temps d'execution fiable, et une syntaxe facile à comprendre et à utiliser**. Il est simple de faire des requêtes pour avoir des informations sur une colonne, ou pour avoir des informations précises en intérrogeant la base de données. 

Mais lorsque l'on veut une analyse exploratoire complète, il faut faire un nombre de requêtes important, voire très important, alors que **Python offre des possibilités pour aller bien plus vite avec quelques lignes de code**. Avec SQL, nous pouvons nous perdre dans un flot ininterrompu de requêtes.

L'absence de graphiques rend l'analyse plus compliquée, que ce soit pour identifier les distributions, ou pour connaître les valeurs extrêmes / aberrantes, ou simplement pour faire parler les données.

C'est pour cette raison que j'ai décidé de réduire l'ambition du projet. Le seul obectif est désormais de trouver des solutions pour accroître les ventes.

J'ai abandonné l'amélioration de la rétention client, qui demande des analyses ciblées et précises sur les différentes types de consommateurs (fidèles, à retenir...)

Il en va de même sur l'optimisation des stocks, qui demande une analyse approfondie pour les principaux produits.

Et même sur l'objectif d'accroître les ventes, il a été compliqué de regarder les produits qui sont plus achetés en combinaison d'autres produits (par exemple les produits plus achetés par les acheteurs de soja sans lactose).


## 5. La connexion des données de Postgre à PowerBI

Petite difficulté ici, lorsque l'on travail sur un environnement Postgre, il faut chercher le connecteur "SQL Postgre" dans PowerBI, et non le connecteur général SQL.

Avec cette vidéo, vous ne devriez pas avoir de problèmes : https://www.youtube.com/watch?v=4S2TfV1G0so


## 6. La transformation des données via PowerQuery

PowerQuery est l'outil ETL (Extract-Transform-Load) directement intégré dans PowerBI.

Il permet de récupérer les données d'une base de données et d'effectuer des transformations sur les données pour qu'elles soient facilement utilisables dans les visualisations PowerBI.

L'outil est à la fois facile d'utilisation et intuitif (NoCode), notamment pour les utilisateurs d'Excel, et permet de faire un nombre conséquent de transformations. En revanche, il peut s'avérer long pour manipuler les données si elles sont trop nombreuses et/ou qu'il y a trop de transformations.

C'est pourquoi, lorsque possible, il est préférable d'effectuer les transformations directement dans SQL.

Voici un exemple des transformations effectuées :
- Modifier le type de données
- Renommer les colonnes pour les rendre faciles à comprendre pour d'autres utilisateurs.
- Renommer des valeurs pour les rendre plus compréhensibles.
- Créer un index (1, 2,..., n)
- Créer des colonnes sur la base d'autres colonnes (exemple : 7h --> 7, 8h --> 8)
- Utiliser une colonne de tri pour que les valeurs d'une colonne soient automatiquement triées dans les graphiques (par exemple : lundi, mardi, mercredi... suivant le code 1, 2, 3..., ou la colonne créée ci-dessus pour trier l'heure de la commande)

Le point fort, c'est que ces modifications se font selon des étapes ordonnées (par exemple suivant l'ordre décrit ci-dessus). Ce qui signifie que nous pouvons retracer et modifier toutes les étapes, voire en ajouter à certains endroits. 

Mais surtout, ces opérations sont réalisées automatiquement à chaque connexion à PowerBI. L'ensemble de ce travail de préparation n'est à réaliser qu'une seule fois. S'il y a de nouvelles lignes dans les tables, elles subiront les mêmes transformations. Autrement dit, PowerQuery permet d'**automatiser le processus d'intégration des données**.


## 7. La modélisation des données

Dans l'idée, **une même préparation des données doit pouvoir être utilisé par plusieurs collaborateurs**. C'est la raison pour laquelle il faut s'efforcer de rendre cette préparation aussi facile à comprendre que possible. D'où un nom explicite des colonnes/variables. Et une modélisation des données efficace.

La modélisation des données, c'est la manière dont les différentes tables interagissent entre elles. Pour rendre ce concept explicite, rien de mieux qu'un exemple tiré du projet : 

![Modélisation des données du projet](https://github.com/clemfouchier/ecommerce_hunter_grocery/blob/main/modele_ecommerce.png?raw=true)


Par exemple, la table "Products" est liée à la table principale au centre par la variable "Product ID".

Dans l'idéal, la table de faits (au centre) contient les données à analyser (principalement quantitatives), et les tables de dimension contiennent les descriptions (par exemple le nom des produits).

Pour plus d'efficacité, il convient d'utiliser le format en étoile, comme ci-dessus. C'est-à-dire que les tables de dimension ne sont UNIQUEMENT reliées qu'à UNE SEULE table de faits. L'outil a été optimisé dans ce but.

Ici, j'ai créé une table "calendrier" qui permet en temps normal d'utiliser les données issues des dates, grâce à une seule formule "CALENDARAUTO", à partir de laquelle nous pouvons créer toutes les combinaisons de dates possibles (jour, mois, timestre, année et mois...).

Vous remarquerez également une table "Mesures", qui est spécifique, puisqu'elle contient les indicateurs à mesurer, créés avec DAX. Nous y reviendrons dans le prochain point. Les regrouper dans une seule table permet de les retrouver plus facilement.

A noter également, la vue "Modèle" permet de masquer certaines variables sur l'interface permettant de créer les graphiques, pour ne pas surcharger les utilisateurs d'informations peu utiles. Par exemple, il n'y a pas d'intérêt à montrer la variable "Product ID" si nous pouvons déjà utiliser le nom de ces produits...

**A la fin de cette étape, les données devraient pouvoir être facilement utilisables par n'importe quel utilisateur pour créer des visualisations.**


## 8. La création des mesures avec DAX

DAX est le langage utilsé dans PowerBI pour créer des mesures/indicateurs à afficher sur les tableaux de bords. Bien que la syntaxe soit à priori intuitive, elle nécessite de la pratique pour pouvoir la maîtriser.

Par exemple, voici le code le plus simple du projet : 

`Nb de Commandes = DISTINCTCOUNT('public ecommerce_data'[Order ID])`


En bon français, la formule indique que la mesure 'Nb de Commandes' compte le nombre de valeurs uniques de la variable 'Order ID' dans la table 'public ecommerce_data'.

C'est ici que ChatGPT s'est révélé le plus précieux. Il m'a permis de pallier mon manque de connaissance et de me révéler l'existance de formules très utiles.

Par exemple ici la formule AVERAGEX qui m'a permis de calculer le nombre moyen de références achetées par commande :

`Nb Références Achetées = AVERAGEX(
     VALUES('public ecommerce_data'[Order ID]),
     CALCULATE(COUNTROWS('public ecommerce_data'))
)`


Il s'agit d'un incontournable de PowerBI, à maîtriser pour pouvoir répondre aux diverses demandes et créer des tableaux de bord utiles aux parties prenantes.


## 9. La création du tableau de bord

Une fois que (enfin !!!) le travail de l'ombre, véritable face émergée de l'iceberg, est effectué, nous pouvons basculer dans la vue "Rapport" pour créer des tableaux de bords.

Nous avons donc les mesures et les variables présentées à droite de manières à ce qu'elles soient compréhensibles et faciles à utiliser pour moi comme pour d'autres collaborateurs.

J'ai choisi ici de mettre les informations que je juge les plus intéressantes sur une page, tout en gardant une facilité de lecture. C'est-à-dire en suivant une certaine logique dans le positionnement des graphiques, en choisissant des titres de graphiques et d'axes explicites, en choisissant des graphiques percutants pour chaque type de données, tout en veillant à avoir des graphiques avec une taille suffisante pour conserver une bonne visibilité.

J'ai aussi veillé à utiliser les codes visuels de la marque, de manière à respecter les codes de l'entreprise.

Présenté ainsi, il a été facile de créer une analyse que l'on peut présenter sous forme de storytelling en suivant un ordre de lecture naturel des chiffres et des graphiques. Les analyses et les recommandations n'en sont que plus faciles à comprendre, à intégrer et à adopter.

Les utilisateurs pourront également rentrer dans les détails en cliquant sur les parties qui les intéressent : l'ensemble des chiffres du rapport s'adapteront (cf exemple dans la partie analyse).

Message à destination des débutants : si vous êtes habitués à utiliser PowerPoint, vous vous rendrez comptes que les graphiques sont bien moins intuitifs à créer et à personnaliser. La raison est que PowerBI est fait pour se mettre à jour de manière automatisée. Il faut parfois chercher un peu avant de parvenir à afficher les graphiques de la forme que l'on souhaite. Et parfois, ce ne sera pas possible : il faudra passer par des voies détournées.


## 10. La vérification des chiffres via SQL

La dernière étape a été la vérification des chiffres utilisés dans SQL, pour m'assurer que les chiffres présentés soient justes.

Cette étape a été nécessaire, parfois pour apporter des modifications mineures, pour comprendre quand les chiffres diffèrent, et aussi pour s'assurer que les bons choix ont été faits.

Ainsi, je suis bien plus confiant dans mon travail, et si l'on me pose les questions, je pourrai y répondre avec plus d'assurance.


# Conclusion :

Ce projet, le plus ambitieux et chronophage que j'ai réalisé jusqu'ici, m'a permis de pratiquer en toute autonomie SQL et PowerBI pour répondre à une problématique business précise. Et, cerise sur la gâteau : les données utilisées sont réelles, et peuvent tout-à-fait contribuer à aider l'entreprise cible.

Après avoir installé un environnement SQL sur mon PC, j'ai pu créer la table, insérer les données, les manipuler, et les analyser grâce à ce langage. Parfois, la flexibilité de Python et la génération de graphiques m'ont terriblement manqués...

Elle m'a permis aussi d'utiliser ChatGPT à plusieurs étapes, que ce soit pour me donner des consignes crédibles, pour enrichir les données et pour m'aider à créer des mesures sur le langage DAX dans PowerBI, où il a été le plus utile. J'ai ici aussi pu mesurer les limites de cet outil : il est impératif de contrôler ce qu'il génère pour éviter les mauvaises surprises.

J'ai revu l'ensemble de mes cours sur PowerBI pour m'assurer que les données soient efficacement chargées, transformées et modélisées afin que je puisse (ou potentiellement un autre collaborateur) facilement créer un tableau de bord ou un rapport.

Enfin, la création d'un tableau de bord clair, synthétique et esthétique m'ont aidé à produire une analyse sous forme de storytelling en suivant l'ordre naturel de lecture de chiffres, et en reprenant les codes graphiques de l'entreprise. J'en ai tiré des recommandations précises pour améliorer l'expérience d'utilisation du site web et ainsi accroître les ventes.

Tous les retours sont bienvenus, n'hésitez surtout pas :).
