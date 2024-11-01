-- 1. Premier apperçu

-- Premier apperçu des 100 première lignes
SELECT *
FROM ecommerce_data
LIMIT 100;

-- 10 dernières lignes
SELECT *
FROM ecommerce_data
ORDER BY order_id DESC
LIMIT 10;

/*
Problème : days_since_prior_order contient beaucoup de valeurs manquantes.
Ce sont les premiers achats sur la plateforme pour les user_id. 

Ici, nous pouvons remplacer le NULL par une valeur mathématique autre, comme -1.
Mais cela peut fausser les calculs mathématiques. Eventuellement, nous pourrons l'appliquer dans PowerBI.
Je vais préférer créer une nouvelle colonne pour identifier les premiers achats.
*/

ALTER TABLE ecommerce_data
ADD COLUMN first_purchase BOOLEAN;

UPDATE ecommerce_data
SET first_purchase = TRUE
WHERE days_since_prior_order IS NULL;

UPDATE ecommerce_data
SET first_purchase = FALSE
WHERE days_since_prior_order IS NOT NULL;

SELECT days_since_prior_order, first_purchase
FROM ecommerce_data
LIMIT 100;

-- Vérification des lignes duppliquées

-- Pour information, la clé primaire est la combinaison de order_id, user_id, product_id et add_to_cart_order

-- Le code compte le nombre de fois où la combinaison se retrouve
-- Puis isole les lignes où on la retrouve plus d'une fois.
SELECT
    order_id
    , user_id
    , product_id
    , add_to_cart_order
    , COUNT(*)
FROM ecommerce_data
GROUP BY order_id, user_id, product_id, add_to_cart_order
HAVING COUNT(*) > 1
LIMIT 100;
-- Pas de duppliquées ici.

-- Nombre de lignes : 2 019 501
SELECT COUNT(*)
FROM ecommerce_data;

-- 2. Analyse univariée

-- Nombre unique des variables 'id'
SELECT 
    COUNT(DISTINCT order_id) AS unique_order_id
    , COUNT(DISTINCT user_id) AS unique_user_id
    , COUNT(DISTINCT product_id) AS unique_product_id
    , COUNT(DISTINCT department_id) AS unique_department_id
FROM ecommerce_data;

-- order_number : l'ordre de la commande par user_id (1 à 100)
SELECT 
    COUNT(order_number) AS count
    , MIN(order_number) AS minimum
    , MAX(order_number) AS maximum
    , AVG(order_number) AS average
    , STDDEV_SAMP(order_number) AS standard_deviation
FROM ecommerce_data;

-- order_dow : jour de la semaine (0 = lundi)
SELECT 
    *
    , ROUND((num / SUM(num) OVER()) * 100, 2) AS percentage
FROM (
    SELECT 
        order_dow 
        , COUNT(*) AS num
    FROM ecommerce_data
    GROUP BY order_dow
) AS temp;
-- Le lundi et le mardi sont les deux jours où il y a le plus de produits commandés.
-- Ils représentent plus de 36% des produits commandés.

-- order_hour_of_day  : heure d'achat du produit
SELECT 
    *
    , ROUND((num / SUM(num) OVER()) * 100, 2) AS percentage
FROM (
    SELECT 
        order_hour_of_day 
        , COUNT(*) AS num 
    FROM ecommerce_data
    GROUP BY order_hour_of_day 
) AS temps;
-- La grande majorité des produits commandés le sont entre 9 et 17h.

-- days_since_prior_order : le nombre de jours depuis la dernière commande.
SELECT 
    COUNT(days_since_prior_order) AS count
    , MIN(days_since_prior_order) AS minimum
    , MAX(days_since_prior_order) AS maximum
FROM ecommerce_data;
-- le minimum de 0 nous indique qu'une commande a eu lieu le même jour.
-- et le maximum de 30 que les commandes les plus éloignées le sont d'un mois.
-- La moyenne n'est pas pertinente ici, car une ligne compte une référence achetée et non pas une commande.

-- first_purchase : les produits achetés lors d'une première commande.
SELECT 
    *
    , ROUND((num / SUM(num) OVER()) * 100, 2) AS percentage
FROM (
    SELECT 
        first_purchase 
        , COUNT(*) AS num
    FROM ecommerce_data
    GROUP BY first_purchase 
) AS temps;
-- 6% des produits commandés concernent des premiers achats.

-- add_to_cart_order : l'ordre des achats d'une commande.
SELECT 
    COUNT(add_to_cart_order) AS cnt
    , MIN(add_to_cart_order) AS minimum
    , MAX(add_to_cart_order) AS maximum
FROM ecommerce_data;
-- La commande la plus importante a compté 137 articles.

-- reordered : products qui ont été réachetés
SELECT 
    *
    , ROUND((num / SUM(num) OVER()) * 100, 2) AS percentage
FROM (
    SELECT 
        reordered 
        , COUNT(*) AS num
    FROM ecommerce_data
    GROUP BY reordered 
) AS temps;
-- 59% des achats concernent des produits qui avaient déjà été achetés.
-- Aussi intéressant est le constat invers : 41% des achats concernent des produits achetés pour la première fois.

-- department : catégories des produits
SELECT 
    *
    , ROUND((num / SUM(num) OVER()) * 100, 2) AS percentage
FROM (
    SELECT 
        department 
        , COUNT(*) AS num
    FROM ecommerce_data
    GROUP BY department
    ORDER BY num DESC 
) AS temps;
-- Les produits laitiers (diairy eggs) et 'produce' sont les plus achetés.
-- Suivent les snacks et les boissons, à 9% et 8% respectivement.

-- Pour comprendre la catégorie 'produce', regardons les produits associés.
SELECT DISTINCT product_name
FROM ecommerce_data
WHERE department = 'produce';
-- Ce sont des produits frais

-- product_name : nom des produits
SELECT 
    *
    , ROUND((num / SUM(num) OVER()) * 100, 2) AS percentage
FROM (
    SELECT 
        product_name 
        , COUNT(*) AS num
    FROM ecommerce_data
    GROUP BY product_name
    ORDER BY num DESC 
) AS temps;
-- Nous trouvons une forte cohérence avec la catégorie des produits.
-- Les produits frais en général sont les plus achetés (plus ou moins 30%)

-- order_date : date de la commande
SELECT 
    MIN(order_date)
    , MAX(order_date)
FROM ecommerce_data;
-- La date maximum est en 2035, alors que 2023 était demandé.

SELECT *
FROM ecommerce_data
ORDER BY user_id, order_id, order_number
LIMIT 100;
/*
Quand nous regardons de plus près, nous devrions avoir une date unique pour chaque combinaison order_id, user_id et order_number.
Or, ce n'est pas du tout le cas. Il faut refaire tourner chatGPT pour avoir de nouvelles dates.
UPDATE : ChatGPT n'a pas fonctionné pour trouver des dates cohérentes. Il faut malheureusement abandonner cette colonne.
*/

-- product_price : prix du produit à l'unité
SELECT 
    COUNT(product_price) AS count
    , MIN(product_price) AS minimum
    , MAX(product_price) AS maximum
    , AVG(product_price) AS average
    , STDDEV_SAMP(product_price) AS standard_deviation
FROM ecommerce_data;

-- quantity : quantités achetées
SELECT 
    COUNT(quantity) AS count
    , MIN(quantity) AS minimum
    , MAX(quantity) AS maximum
    , AVG(quantity) AS average
    , STDDEV_SAMP(quantity) AS standard_deviation
FROM ecommerce_data;

-- Ces deux dernières variables sont générées aléatoirement avec ChatGPT.
-- Elles vont me permettre de manipuler les données, mais il ne faudra pas en attendre des analyses approfondies.
-- C'est notamment le cas du prix qui peut se révéler incohérent, même irréaliste.
-- C'est la raison pour laquelle nous conservons la colonne quantité et abandonnons la colonne prix.

-- Maintenant que nous nous sommes familiarisés avec les données, nous pouvons analyser la relation des variables entre elles.

-- 2. Analyses bi et multivariées

/*
ChatGTP nous a donné les objectifs suivants :
- Accroître les ventes
- Améliorer la rétention client
- Optimiser la gestion des stocks

Nous présenterons ici les analyse qui permettent de répondre à ces questions

UPDATE : suite au temps passé considérable sur SQL pour l'analyse bi-variée, et aux limites constatées de cet outil 
par rapport à Python, j'ai décidé de me concentrer sur le premier objectif : accroître les ventes.
*/

-- a. Accroître les ventes

-- Nombre de commandes par client

WITH cte_order_per_user AS (SELECT 
    user_id
    , COUNT(DISTINCT order_id) AS nb_order_per_user
FROM ecommerce_data
GROUP BY user_id)

SELECT AVG(nb_order_per_user)
FROM cte_order_per_user;
-- En moyenne, un utilisateur a passé 19 commandes.

-- Catégories de produits les plus achetés.

SELECT
    *
    , ROUND(num_dept / SUM(num_dept) OVER() * 100, 2)
    FROM(
   SELECT 
        department
        , COUNT(*) AS num_dept
    FROM ecommerce_data
    GROUP BY department
    ORDER BY num_dept DESC);


WITH dept_cte AS(
    SELECT
    *
    , ROUND(num_dept / SUM(num_dept) OVER() * 100, 2) AS percentage_dept
FROM(
    SELECT 
        department
        , COUNT(*) AS num_dept
    FROM ecommerce_data
    GROUP BY department
    ) AS temp1
),
reorered_dept_cte AS (
    SELECT
    *
    , ROUND(num_reordered / SUM(num_reordered) OVER() * 100, 2) AS percentage_reordered
    FROM (SELECT
        department
        , COUNT(*) AS num_reordered
    FROM ecommerce_data
    WHERE reordered = 1
    GROUP BY department
    ) AS temp2
),
first_product_dept_cte AS (
    SELECT
    *
    , ROUND(num_fp / SUM(num_fp) OVER() * 100, 2) AS percentage_first_product
    FROM (SELECT
        department
        , COUNT(*) AS num_fp
    FROM ecommerce_data
    WHERE add_to_cart_order = 1
    GROUP BY department
    ) AS temp3
)

SELECT 
    department
    , d.percentage_dept
    , r.percentage_reordered
    , f.percentage_first_product
FROM dept_cte AS d
INNER JOIN reorered_dept_cte AS r USING(department)
INNER JOIN first_product_dept_cte AS f USING(department)
ORDER BY d.percentage_dept DESC
LIMIT 12;

/*
En comparant avec PowerBI, les chiffres changent légèrement.
La raison est que je présente les 12 catégories de produits les plus vendues.
Or, le total est calculé sur la base 100% de ce qui est affiché.
Les proportions restent les mêmes.
*/

-- order_dow : jour de la semaine (0 = lundi) par commande
SELECT 
    *
    , ROUND((nb_order / SUM(nb_order) OVER()) * 100, 2) AS percentage
FROM (
    SELECT 
        order_dow 
        , COUNT(DISTINCT order_id) AS nb_order
    FROM ecommerce_data
    GROUP BY order_dow
) AS temp;
-- Le lundi et le mardi sont les deux jours où il y a le plus de produits commandés.
-- Ils représentent plus de 36% des produits commandés.

-- order_hour_of_day  : heure d'achat par commande
SELECT 
    *
    , ROUND((nb_order / SUM(nb_order) OVER()) * 100, 2) AS percentage
FROM (
    SELECT 
        order_hour_of_day 
        , COUNT(DISTINCT order_id) AS nb_order 
    FROM ecommerce_data
    GROUP BY order_hour_of_day 
) AS temps;
-- La grande majorité des produits commandés le sont entre 9 et 17h.

-- days_since_pior_order : le nombre de jours moyen entre chaque commande.

/*
Explication de la CTE.

Pour connaître le nombre de jours entre chaque commande réalisée pour chaque individu,
il convient de réaliser une requête un peu complexe.

1er niveau : nous isolons le nombre de jours entre chaque commande pour chaque individu.

ex : individu 1, commmande 1 : x jours, commande 2 : y jours...

L'utilisation de MAX est anecdotique, puisque le nombre de jours entre chaque commande reste
le même quelle que soit la ligne de la commande.

2ème niveau : nous faisons la moyenne du nombre de jours entre chaque commande pour chaque individu.

Ensuite, nous calculons la moyenne par individu.
*/


WITH cte_days_per_order_per_user AS (
SELECT
    user_id
    , order_id
    , MAX(days_since_prior_order) AS days
FROM ecommerce_data
GROUP BY 1,2)
, cte_avg_days_per_user AS (
SELECT 
    user_id
    , AVG(days) AS avg_days_per_user
FROM cte_days_per_order_per_user
GROUP BY 1)

SELECT AVG(avg_days_per_user)
FROM cte_avg_days_per_user;

-- En moyenne, les individus attendent 13 jours entre chaque commande.
-- J'ai un doute sur la valeur maximale de 30 jours entre chaque commande, qui me semble bien peu.
-- Je choisis donc de ne pas utiliser cette variable dans l'analyse.

-- Nombre d'individus qui ont effectué leurs premières commandes

SELECT COUNT(DISTINCT user_id)
FROM ecommerce_data
WHERE first_purchase = TRUE;

-- 12 254, soit un résultat cohérent avec PowerBI.

-- Produits les plus vendus

SELECT
    *
    , ROUND(quantites / SUM(quantites) OVER() * 100, 2) AS percentage_products
FROM(
    SELECT 
        product_name
        , COUNT(quantity) AS quantites
    FROM ecommerce_data
    GROUP BY product_name
    ORDER BY quantites DESC
    ) AS temp;
-- 26% des quantités achetées proviennent des fruits et légumes (TOP3)
-- Viennent ensuite les yaourts, formage et lait, qui comptent pour 10% des produits.

-- Produits re-commandés
SELECT
    *
    , ROUND(quantites / SUM(quantites) OVER() * 100, 2) AS percentage_reordered
    FROM (SELECT
        product_name
        , COUNT(quantity) AS quantites
    FROM ecommerce_data
    WHERE reordered = 1
    GROUP BY product_name
    ORDER BY quantites DESC
    ) AS temp;
-- Nous retrouvons un classement similaire, à part le packaged cheese qui est moins re-commandé
-- Alors que le lait et l'eau sont des produits plus réguliers.

-- Produits achetés en premier
SELECT
    *
    , ROUND(quantites / SUM(quantites) OVER() * 100, 2) AS percentage_first_product
    FROM (SELECT
        product_name
        , COUNT(quantity) AS quantites
    FROM ecommerce_data
    WHERE add_to_cart_order = 1
    GROUP BY product_name
    ORDER BY quantites DESC
    ) AS temp;
-- Outre les fruits et légumes, le lait et l'eau sont les premiers produits à être mis dans le panier.

-- Récap des trois requêtes précédentes, mis ensemble dans un même tableau
WITH product AS(
    SELECT
    *
    , ROUND(quantites / SUM(quantites) OVER() * 100, 2) AS percentage_products
FROM(
    SELECT 
        product_name
        , COUNT(quantity) AS quantites
    FROM ecommerce_data
    GROUP BY product_name
    ) AS temp1
),
reorered_table AS (
    SELECT
    *
    , ROUND(quantites / SUM(quantites) OVER() * 100, 2) AS percentage_reordered
    FROM (SELECT
        product_name
        , COUNT(quantity) AS quantites
    FROM ecommerce_data
    WHERE reordered = 1
    GROUP BY product_name
    ) AS temp2
),
first_product AS (
    SELECT
    *
    , ROUND(quantites / SUM(quantites) OVER() * 100, 2) AS percentage_first_product
    FROM (SELECT
        product_name
        , COUNT(quantity) AS quantites
    FROM ecommerce_data
    WHERE add_to_cart_order = 1
    GROUP BY product_name
    ) AS temp3
)

SELECT 
    product_name
    , p.percentage_products
    , r.percentage_reordered
    , f.percentage_first_product
FROM product AS p
INNER JOIN reorered_table AS r USING(product_name)
INNER JOIN first_product AS f USING(product_name)
ORDER BY p.percentage_products DESC;

-- J'aimerais désormais voir quelques associations de produits.

-- Premièrement ceux qui achètent des fruits frais ou légumes frais, comme référence.
WITH fruits_vegetables_consumers AS (
    SELECT
        product_name,
        COUNT(quantity) AS quantites
    FROM ecommerce_data
    WHERE order_id IN (
        SELECT DISTINCT order_id
        FROM ecommerce_data
        WHERE product_name = 'fresh fruits' OR product_name = 'fresh vegetables')
    GROUP BY product_name
    ORDER BY quantites DESC)

SELECT
    *
    , ROUND(quantites / SUM(quantites) OVER() * 100, 2) AS percentage_fruits_vegetables_consumers
FROM fruits_vegetables_consumers;

-- La requête va chercher les produits achetés par les individus qui ont acheté des fruits ou légumes frais
-- Pour ce faire, nous isolons les ID de ces derniers dans une sous-requête, que nous allons les produits qu'ils achètent.

-- Regardons ceux qui mangent du soja sans lactose
WITH soy_freelactose_consumers AS (
    SELECT
        product_name,
        COUNT(quantity) AS quantites
    FROM ecommerce_data
    WHERE order_id IN (
        SELECT DISTINCT order_id
        FROM ecommerce_data
        WHERE product_name = 'soy lactosefree')
    GROUP BY product_name
    ORDER BY quantites DESC)

SELECT
    *
    , ROUND(quantites / SUM(quantites) OVER() * 100, 2) AS percentage_soy_freelactose_consumers
FROM soy_freelactose_consumers;

-- Dernière catégorie qui peut m'intéresser : ceux qui achètent du snacking
WITH snacking_consumers AS (
    SELECT
        product_name,
        COUNT(quantity) AS quantites
    FROM ecommerce_data
    WHERE order_id IN (
        SELECT DISTINCT order_id
        FROM ecommerce_data
        WHERE department = 'snacks')
    GROUP BY product_name
    ORDER BY quantites DESC)

SELECT
    *
    , ROUND(quantites / SUM(quantites) OVER() * 100, 2) AS percentage_snacking_consumers
FROM snacking_consumers;

-- Faisons un tableau récapitulatif de ces trois types de consommateurs
WITH fruits_vegetables_consumers_recap AS (
    SELECT
        product_name,
        COUNT(quantity) AS quantites_fv,
        ROUND(COUNT(quantity) / SUM(COUNT(quantity)) OVER() * 100, 2) AS percentage_fruits_vegetables_consumers
    FROM ecommerce_data
    WHERE order_id IN (
        SELECT DISTINCT order_id
        FROM ecommerce_data
        WHERE product_name = 'fresh fruits' OR product_name = 'fresh vegetables')
    GROUP BY product_name),
soy_freelactose_consumers_recap AS (
    SELECT
        product_name,
        COUNT(quantity) AS quantites_sl,
        ROUND(COUNT(quantity) / SUM(COUNT(quantity)) OVER() * 100, 2) AS percentage_soy_freelactose_consumers
    FROM ecommerce_data
    WHERE order_id IN (
        SELECT DISTINCT order_id
        FROM ecommerce_data
        WHERE product_name = 'soy lactosefree')
    GROUP BY product_name),
snacking_consumers_recap AS (
    SELECT
        product_name,
        COUNT(quantity) AS quantites_s,
        ROUND(COUNT(quantity) / SUM(COUNT(quantity)) OVER() * 100, 2) AS percentage_snacking_consumers
    FROM ecommerce_data
    WHERE order_id IN (
        SELECT DISTINCT order_id
        FROM ecommerce_data
        WHERE department = 'snacks')
    GROUP BY product_name)

SELECT 
    product_name,
    fv.percentage_fruits_vegetables_consumers,
    sf.percentage_soy_freelactose_consumers,
    s.percentage_snacking_consumers
FROM fruits_vegetables_consumers_recap AS fv
LEFT JOIN soy_freelactose_consumers_recap AS sf USING(product_name)
LEFT JOIN snacking_consumers_recap AS s USING(product_name)
ORDER BY fv.percentage_fruits_vegetables_consumers DESC;
/*Peu d'enseignements intéressants ici, si ce n'est que les individus des catégories... consomment plus de produits de leur catégorie.
En revanche, nous n'observons pas de baisse notable des autres catégories, à quelques exceptions près :
- Les individus qui mangent du snacking consonmment bien moins de fruits et légumes frais.
- Les individus qui consomment du soja sans lactose achètent moins de lait et de fromages à base de crème.
*/

-- Le nombre moyen de références commandés

-- CTE pour isoler le nombre de références max par commande.
-- Il s'agit donc de la quantité de références commandées.
WITH nb_products_per_order AS (
    SELECT 
        order_id
        , MAX(add_to_cart_order) AS nb_references_ordered
    FROM ecommerce_data
    GROUP BY order_id)

SELECT ROUND(AVG(nb_references_ordered), 2)
FROM nb_products_per_order;
-- Une moyenne de 10 références commandées.

-- Cette fois, regardons la quantité de produits acheté par commande.
WITH sum_quantities_cte AS (
    SELECT 
        order_id
        , SUM(quantity) AS sum_quantities
    FROM ecommerce_data
    GROUP BY order_id)

SELECT ROUND(AVG(sum_quantities), 2)
FROM sum_quantities_cte;
-- En moyenne, 19 produits sont achetés par commande.

-- FIN DE l'EDA
-- A partir de là, il s'agit d'un brouillon des tentatives sur les autres objectifs
-- Pour rappel, nous ne restons que sur le premier objectif : améliorer les ventes.

