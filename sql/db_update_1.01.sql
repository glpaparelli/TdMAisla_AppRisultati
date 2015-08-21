USE aisla_triathlon;

ALTER TABLE utente
	ADD facebookId VARCHAR(255) DEFAULT NULL;
	
DELETE FROM versione_database;
INSERT INTO versione_database VALUES ('1.01');
