/*
 Пусть в таблице users поля created_at и updated_at оказались незаполненными.
  Заполните их текущими датой и временем. 
 */

DROP database IF EXISTS example;
CREATE database example;
USE example;

DROP TABLE IF EXISTS users;
CREATE table users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at DATE,
  created_at DATETIME, #DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME #DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
 
 SELECT * FROM  users;

UPDATE users
SET
	created_at = now(),
	updated_at = now();

  SELECT * FROM  users;
 
 /*Таблица users была неудачно спроектирована.
 Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения 
 в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.*/
 
 DROP TABLE IF EXISTS users;
CREATE table users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at DATE,
  created_at VARCHAR(255), #DEFAULT CURRENT_TIMESTAMP,
  updated_at VARCHAR(255) #DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05','20.10.2017 8:10', '01.03.2020 22:18'),
  ('Наталья', '1984-11-12','20.10.2017 8:10', '01.03.2020 22:18'),
  ('Александр', '1985-05-20','20.10.2017 8:10', '01.03.2020 22:18'),
  ('Сергей', '1988-02-14','20.10.2017 8:10', '01.03.2020 22:18'),
  ('Иван', '1998-01-12','20.10.2017 8:10', '01.03.2020 22:18'),
  ('Мария', '1992-08-29','20.10.2017 8:10', '01.03.2020 22:18');
 
 SELECT * FROM  users;


UPDATE users
SET
	created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i') ,
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

ALTER TABLE users
CHANGE created_at created_at Datetime DEFAULT CURRENT_TIMESTAMP; 
ALTER TABLE users
CHANGE updated_at updated_at Datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
DESCRIBE users ;

SELECT * FROM  users;

/*В таблице складских запасов storehouses_products в поле value могут встречаться самые 
разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. 
Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
Однако, нулевые запасы должны выводиться в конце, после всех записей.
*/

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO storehouses_products (name, value) VALUES
  ('рис', 50),
  ('греча', 30),
  ('просо', 23),
  ('овсянка', 0),
  ('кускус', 12),
  ('перловка', 9);
  
 SELECT * FROM storehouses_products ORDER BY IF(value >0, 0, 1), value;
 