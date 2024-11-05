
CREATE DATABASE phones;

USE phones;

SELECT model,
ROUND(SQRT(resolution_width*resolution_width+resolution_height*resolution_height)/screen_size,2)
AS ppi
FROM smartphones;

SELECT DISTINCT(brand_name) AS all_brands FROM smartphones;

SELECT DISTINCT brand_name,processor_brand FROM smartphones;

SELECT * FROM smartphones WHERE brand_name='Samsung';

SELECT * FROM smartphones 
WHERE processor_brand='snapdragon' AND ram_capacity>8;

-- find brands who sell phones with price>50000

SELECT DISTINCT(brand_name) FROM smartphones WHERE price>50000;

SELECT * FROM smartphones WHERE processor_brand NOT IN ('snapdragon','exynos','bionic');

USE phones;

SELECT MIN(price),AVG(rating),MAX(ram_capacity) FROM smartphones;

-- find the price of costliest samsung phone

SELECT MAX(price) FROM smartphones WHERE brand_name='samsung';

SELECT AVG(rating) FROM smartphones WHERE brand_name='apple';

-- find the number of brands available

SELECT COUNT(DISTINCT brand_name) FROM smartphones;

/* find the average battery capacity and average primary rear camera resolution
for all smartphones with price greater than or equal to 100000
*/
SELECT AVG(battery_capacity),AVG(primary_camera_rear) FROM smartphones
WHERE price>=100000;

/*find the average internal memory capacity of smartphones that have refresh rate
of 120Hz or higher and front facing camera resolution greater than equal to 20 MP
*/
SELECT AVG(internal_memory) FROM smartphones
WHERE refresh_rate>=120 AND primary_camera_front>=20;

-- find the number of smartphones with 5G capability

SELECT COUNT(*) FROM smartphones 
WHERE has_5g="True";

-- find top 5 samsung phones with biggest screen size
SELECT model,screen_size FROM smartphones
WHERE brand_name='Samsung'
ORDER BY screen_size DESC LIMIT 5;

-- sort all the phones in descending order of number of total cameras

SELECT model,num_rear_cameras+num_front_cameras AS total_cameras FROM smartphones
ORDER BY total_cameras DESC;

-- find the phone with 2nd largest battery capacity

SELECT * FROM smartphones
ORDER BY battery_capacity DESC LIMIT 1,1;

-- find the name and rating of the worst rated apple phone
USE phones;
SELECT model,rating FROM smartphones
WHERE brand_name="apple"
ORDER BY rating ASC LIMIT 0,1;

-- sort phones alphabetically and then on the basis of rating in descending order

SELECT * FROM smartphones
ORDER BY brand_name ASC,rating DESC;

-- sort phones alphabetically and then on the basis of price in asc order

SELECT * FROM smartphones
ORDER BY brand_name ASC,price ASC;

-- Group smatphones by brand and get the count, avrage price, max rating
-- avg screen size,avg battery capacity
SELECT brand_name,COUNT(*),AVG(price),MAX(rating),AVG(screen_size),
AVG(battery_capacity)
FROM smartphones
GROUP BY brand_name;

-- Group smartphones by whether they have NFC and get the average price and rating
SELECT has_nfc,AVG(price),AVG(rating) FROM smartphones
GROUP BY has_nfc;

-- Group smartphones by whether they have 5g and get the average price and rating
SELECT has_5g,AVG(price),AVG(rating) FROM smartphones
GROUP BY has_5g;

/*  group smartphones by the brand and processor brand and get the count of models
and average primary camera resolution(rear)
*/
SELECT brand_name,processor_brand,COUNT(*),AVG(primary_camera_rear) FROM smartphones
GROUP BY brand_name,processor_brand;

-- find top 5 most costly brands

SELECT brand_name,AVG(price) AS avg_price FROM smartphones
GROUP BY brand_name
ORDER BY avg_price DESC LIMIT 5;

-- which brand makes the smallest screen smartphones
SELECT brand_name,AVG(screen_size) AS avg_screen_size FROM smartphones
GROUP BY brand_name
ORDER BY avg_screen_size ASC LIMIT 1;

/* group smartphones by brand and find the brand with the highest number of
models that have both NFC and an IR blaster
*/
USE phones;
SELECT brand_name,COUNT(*) AS num_model FROM smartphones
WHERE has_nfc="True" AND has_ir_blaster="True"
GROUP BY brand_name
ORDER BY num_model DESC LIMIT 1;

/* find all samsung 5g enabled smartphones and find out the 
avg price for NFC and Non-NFC phones
*/
SELECT has_nfc,AVG(price) FROM smartphones
WHERE brand_name="samsung" AND has_5g="True"
GROUP BY has_nfc;

-- find the phone name,price of the costliest phone

SELECT model,price  FROM smartphones
ORDER BY price DESC LIMIT 1;

-- find the avg rating of smartphones brands which have more than 20 phones
USE phones;

SELECT brand_name,AVG(rating),COUNT(*) AS total_models FROM smartphones
GROUP BY brand_name HAVING total_models>20;

/* find the top 3 brands with the highest avg ram that have a refresh rate
of at least 90HZ and fast charging available and don't consider brands which
have less than 10 phones
*/
SELECT brand_name,AVG(ram_capacity) AS avg_ram FROM smartphones
WHERE refresh_rate>=90 AND fast_charging_available=1
GROUP BY brand_name HAVING COUNT(*)>10
ORDER BY  avg_ram DESC LIMIT 3;

/* find the avg price of all the phone brands with avg rating>70 and 
num_phones more than 10 among all 5g enabled phones
*/
SELECT brand_name,AVG(price) FROM smartphones
WHERE has_5g="True"
GROUP BY brand_name HAVING COUNT(*)>10 AND AVG(rating)>70;







