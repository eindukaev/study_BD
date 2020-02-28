/* Задание
 * Написать крипт, 
 * добавляющий в БД vk, которую создали на занятии, 3 новые таблицы 
 * (с перечнем полей, указанием индексов и внешних ключей)
*/
USE vk;

DROP TABLE IF EXISTS all_music;
CREATE TABLE all_music (
	`id` SERIAL PRIMARY KEY,
	`from_user_id` BIGINT UNSIGNED DEFAULT NULL,
	`name_audio` varchar(255) NOT NULL,
	`singer` varchar(255) NOT NULL,
    `format` varchar(5) NOT NULL,
    `size_byte` size INT,
    
    INDEX name_audio (name_audio),
    INDEX singer (singer),
    FOREIGN KEY (from_user_id) REFERENCES users(id),
);

DROP TABLE IF EXISTS `play_list`;
CREATE TABLE `play_list` (
	`id` SERIAL,
	`name` varchar(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `user_audio`;
CREATE TABLE `user_audio` (
	id SERIAL PRIMARY KEY,
	`name_audio` varchar(255) NOT NULL,
	`singer` varchar(255) NOT NULL,
    `format` varchar(5) NOT NULL,
    `size_byte` size INT,
	`play_list_id` BIGINT unsigned NOT NULL,
	`media_id` BIGINT unsigned NOT NULL,
	`all_music_id` BIGINT unsigned NOT NULL,
	
	INDEX play_list (play_list),
	INDEX name_audio (name_audio),
    INDEX singer (singer),
	FOREIGN KEY (play_list_id) REFERENCES play_list(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
    FOREIGN KEY (all_music_id) REFERENCES all_music(id)
);


