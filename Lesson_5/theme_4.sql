#theme_4
DROP database IF EXISTS example;
CREATE database example;
USE example;

DROP TABLE IF EXISTS users;
CREATE table users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at DATE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
 
/*Подсчитайте средний возраст пользователей в таблице users*/ 
 
SELECT round(avg(timestampdiff(YEAR, birthday_at, now()))) AS age FROM users;

/*Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/

SELECT date_format(Date(concat_ws('-',YEAR(now()), MONTH (birthday_at), DAY(birthday_at)) ), '%W') AS weekdays,
count(*) FROM users GROUP BY weekdays ORDER BY count(*);

/*(по желанию) Подсчитайте произведение чисел в столбце таблицы
*/


 