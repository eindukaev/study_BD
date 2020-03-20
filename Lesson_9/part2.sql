/*Создайте хранимую функцию hello(), 
 которая будет возвращать приветствие, в зависимости от текущего времени суток.
 С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
  12:00 до 18:00 функция должна возвращать фразу "Добрый день",
   18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".*/
DELIMITER //

DROP PROCEDURE IF EXISTS hello//
CREATE FUNCTION hello ()
RETURNS TEXT DETERMINISTIC
BEGIN
	DECLARE time INT;
	SET time = HOUR (NOW());
	IF time BETWEEN 6 AND 11 THEN
		RETURN 'Доброе утро';
	ELSEIF time BETWEEN 12 AND 17 THEN
		RETURN 'Добрый день';
	ELSEIF time BETWEEN 18 AND 23 THEN
		RETURN 'Добрый вечер';
	ELSEIF time BETWEEN 0 AND 5 THEN
		RETURN 'Доброй ночи';
	END IF;
END//

DELIMITER ;

/*В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
 Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное
 значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей 
 или оба поля были заполнены. 
 При попытке присвоить полям NULL-значение необходимо отменить операцию.*/
CREATE OR REPLACE TRIGGER name_notnull BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	SET NEW.name = COALESCE(NEW.name, OLD.name);
END//

CREATE OR REPLACE TRIGGER name_notnull BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
	SET NEW.name = COALESCE(NEW.name, OLD.name);
END//

CREATE OR REPLACE TRIGGER description_notnull BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	SET NEW.description = COALESCE(NEW.description, OLD.description);
END//

CREATE OR REPLACE TRIGGER description_notnull BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
	SET NEW.description = COALESCE(NEW.description, OLD.description);
END//
