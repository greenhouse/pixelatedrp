USE `essentialmode`;

ALTER TABLE `users`
	ADD COLUMN `firstname` VARCHAR(50) NULL DEFAULT '',
	ADD COLUMN `lastname` VARCHAR(50) NULL DEFAULT '',
	ADD COLUMN `dateofbirth` VARCHAR(25) NULL DEFAULT '',
	ADD COLUMN `sex` VARCHAR(10) NULL DEFAULT '',
	ADD COLUMN `height` VARCHAR(5) NULL DEFAULT ''
;

CREATE TABLE `characters` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(255) NOT NULL,
	`firstname` VARCHAR(255) NOT NULL,
	`lastname` VARCHAR(255) NOT NULL,
	`dateofbirth` VARCHAR(255) NOT NULL,
	`sex` VARCHAR(1) NOT NULL DEFAULT 'M',
	`height` VARCHAR(128) NOT NULL,

	PRIMARY KEY (`id`)
);