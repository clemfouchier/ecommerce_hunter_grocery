
-- Création de la table et test
CREATE TABLE ecommerce_data (
    order_id INT,
    user_id INT,
    order_number INT,
    order_dow INT,
    order_hour_of_day INT,
    days_since_prior_order INT,
    product_id INT,
    add_to_cart_order INT,
    reordered INT,
    department_id INT,
    department VARCHAR(255),
    product_name VARCHAR(255),
    order_date DATE,
    product_price FLOAT,
    quantity INT
);

INSERT INTO ecommerce_data (
    order_id,
    user_id,
    order_number,
    order_dow,
    order_hour_of_day,
    days_since_prior_order,
    product_id,
    add_to_cart_order,
    reordered,
    department_id,
    department,
    product_name,
    order_date,
    product_price,
    quantity
) 
VALUES(
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    'test',
    'test',
    '01-01-01',
    1.00,
    1
);

SELECT *
FROM ecommerce_data
LIMIT 100;

-- Dans le test, j'ai remarqué que le type de données de days_since_prior_order était INT au lieu de FLOAT normalement.
-- Corrigeons cette erreur

ALTER TABLE ecommerce_data
ALTER COLUMN days_since_prior_order TYPE FLOAT;

SELECT *
FROM ecommerce_data
LIMIT 100;

-- Suppression du test
DELETE FROM ecommerce_data
WHERE order_id = 1;

SELECT *
FROM ecommerce_data
LIMIT 100;

-- Chargement des données
COPY ecommerce_data
FROM "C:\Users\Public\Updated_ECommerce_data.csv"
DELIMITER ','
CSV HEADER;

SELECT *
FROM ecommerce_data
LIMIT 100;
