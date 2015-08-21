USE aisla_triathlon;

SET @idTipoGaraIndividuale := (SELECT id FROM tipo_gara WHERE nome_it = 'Individuale');
SET @idTipoGaraInSquadra := (SELECT id FROM tipo_gara WHERE nome_it = 'In squadra');
SET @idTipoRichiestaTesseramentoGiornata := (SELECT id FROM tipo_richiesta_tesseramento WHERE nome_it = 'Tesseramento di Giornata');
SET @idTipoRichiestaTesseramentoFitri := (SELECT id FROM tipo_richiesta_tesseramento WHERE nome_it = 'Tesseramento F.I.Tri');
SET @idTipoTesseramentoGiornata := (SELECT id FROM tipo_tesseramento WHERE nome_it = 'Tesseramento di Giornata');
SET @idTipoTesseramentoFitri := (SELECT id FROM tipo_tesseramento WHERE nome_it = 'Tesseramento F.I.Tri');

SET @defaultString := 'importazione dati 2014';
SET @defaultDate := '2014-06-29';

INSERT INTO gara (id, nome, disputataIl, idTipoGara)
	VALUES (1, 'TdM AISLA Sprint MTB Individuale', @defaultDate, @idTipoGaraIndividuale);

INSERT INTO gara (id, nome, disputataIl, idTipoGara)
	VALUES (2, 'TdM AISLA Olimpico MTB Individuale', @defaultDate, @idTipoGaraIndividuale);

INSERT INTO gara (id, nome, disputataIl, idTipoGara)
	VALUES (3, 'TdM AISLA Olimpico MTB In squadra', @defaultDate, @idTipoGaraInSquadra);



INSERT INTO utente
	(id, eAmmiistratore, nome, cognome, email)
	VALUES (0, 0, @defaultString, @defaultString, @defaultString);
	
INSERT INTO ordine
	(id, ricevutoIl, totale, pagato, ricevutaInviata, idModalitaPagamento, indirizzoLinea1, indirizzoCap, indirizzoCitta, indirizzoStato)
	VALUES (0, 0, 0, 1, 0, 0, @defaultString,  @defaultString, @defaultString, @defaultString);
	
---------
-- inserimento societa_fitri
------------------------------------------------------------------------------------

SET @curId = 1;
INSERT INTO utente
	(id, eAmministratore, nome, cognome, sesso, natoIl, email, telefono)
	VALUES (@curId, 0, YYY, YYY, YYY, YYY, YYY, YYYY, YYYY);
INSERT INTO adesione_personale
	(id, idUtente, categoriaFitri, indirizzoLinea1, indirizzoCap, indirizzoCitta, indirizzoStato)
	VALUES (@curId, @curId, XXX, @defaultString,  @defaultString, @defaultString, @defaultString);
INSERT INTO richiesta_tesseramento
	(id, eseguitaIl, verificata, idAdesionePersona, idTipoRichiestaTesseramento)
	VALUES (@curId, @defaultDate, 1, @curId, XXX);
INSERT INTO tesseramento
	(id, finoAl, matricola, codiceSocietaFitri, idTipoTesseramento, idRichiestaTesseramento)
	VALUES (@curId, @defaultDate, XXX, XXX, @curId);
INSERT INTO iscrizione
	(id, eseguitaIl, pettorale, idOrdine, idGara, idAdesionePersonale) --- idSquadra
	VALUES (@curId, @defaultDate, 0, XXX, @curId);
	
-----------
SET @curId = TODO
INSERT INTO utente
	(id, eAmministratore, nome, cognome, sesso, natoIl, email, telefono)
	VALUES (@curId, 0, YYY, YYY, YYY, YYY, YYY, YYYY, YYYY);
INSERT INTO utente
	(id, eAmministratore, nome, cognome, sesso, natoIl, email, telefono)
	VALUES (@curId, 0, YYY, YYY, YYY, YYY, YYY, YYYY, YYYY);
INSERT INTO utente
	(id, eAmministratore, nome, cognome, sesso, natoIl, email, telefono)
	VALUES (@curId, 0, YYY, YYY, YYY, YYY, YYY, YYYY, YYYY);
	
INSERT INTO squadra
	(id, nome)
	VALUES (XXX, XXX);

INSERT INTO adesione_personale
	(id, idUtente, idSquadra, categoriaFitri, indirizzoLinea1, indirizzoCap, indirizzoCitta, indirizzoStato)
	VALUES (@curId, @curId, XXX, YYY, @defaultString,  @defaultString, @defaultString, @defaultString);
	
INSERT INTO richiesta_tesseramento
	(id, eseguitaIl, verificata, idAdesionePersona, idTipoRichiestaTesseramento)
	VALUES (@curId, @defaultDate, 1, @curId, XXX);
INSERT INTO tesseramento
	(id, finoAl, matricola, codiceSocietaFitri, idTipoTesseramento, idRichiestaTesseramento)
	VALUES (@curId, @defaultDate, XXX, XXX, @curId);
INSERT INTO iscrizione
	(id, eseguitaIl, pettorale, idOrdine, idGara, idSquadra)
	VALUES (@curId, @defaultDate, 0, XXX, ZZZ);


DELETE FROM versione_database;
INSERT INTO versione_database VALUES ('1.02');