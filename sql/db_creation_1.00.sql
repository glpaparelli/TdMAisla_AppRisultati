-- phpMyAdmin SQL Dump
-- version 4.4.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Creato il: Ago 19, 2015 alle 10:05
-- Versione del server: 5.6.25
-- Versione PHP: 5.6.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aisla_triathlon`
--
DROP database IF EXISTS `aisla_triathlon`;

CREATE DATABASE `aisla_triathlon` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `aisla_triathlon`;

-- --------------------------------------------------------

--
-- Struttura della tabella `abilitazione_modalita_pagamento`
--

CREATE TABLE IF NOT EXISTS `abilitazione_modalita_pagamento` (
  `idGara` bigint(20) unsigned NOT NULL,
  `idModalitaPagamento` tinyint(3) unsigned NOT NULL,
  `finoAl` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `abilitazione_tipo_iscrizione`
--

CREATE TABLE IF NOT EXISTS `abilitazione_tipo_iscrizione` (
  `idGara` bigint(20) unsigned NOT NULL,
  `idTipoIscrizione` tinyint(3) unsigned NOT NULL,
  `finoAl` datetime NOT NULL,
  `costo` decimal(7,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `abilitazione_tipo_richiesta_tesseramento`
--

CREATE TABLE IF NOT EXISTS `abilitazione_tipo_richiesta_tesseramento` (
  `idTipoRichiestaTesseramento` tinyint(4) unsigned NOT NULL,
  `idGara` bigint(20) unsigned NOT NULL,
  `finoAl` datetime NOT NULL,
  `costo` decimal(7,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `adesione_personale`
--

CREATE TABLE IF NOT EXISTS `adesione_personale` (
  `id` bigint(20) unsigned NOT NULL,
  `categoriaFitri` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `indirizzoLinea1` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `indirizzoLinea2` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `indirizzoCap` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `indirizzoCitta` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `indirizzoProvincia` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `indirizzoStato` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idSquadra` bigint(11) unsigned DEFAULT NULL,
  `idUtente` bigint(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `categoria_fitri`
--

CREATE TABLE IF NOT EXISTS `categoria_fitri` (
  `nome` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomeEsteso` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `iniziaDaAnni` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `categoria_fitri`
--

INSERT INTO `categoria_fitri` (`nome`, `nomeEsteso`, `iniziaDaAnni`) VALUES
('CUC', 'Cuccioli', 8),
('ESO', 'Esordienti', 10),
('JUN', 'Junior', 18),
('M1', 'Master 1', 40),
('M2', 'Master 2', 45),
('M3', 'Master 3', 50),
('M4', 'Master 4', 55),
('M5', 'Master 5', 60),
('M6', 'Master 6', 65),
('M7', 'Master 7', 70),
('M8', 'Master 8', 75),
('MIN', 'Minicuccioli', 6),
('RAG', 'Ragazzi', 12),
('S1', 'Senior 1', 20),
('S2', 'Senior 2', 25),
('S3', 'Senior 3', 30),
('S4', 'Senior 4', 35),
('YOA', 'Youth A', 14),
('YOB', 'Youth B', 16);

-- --------------------------------------------------------

--
-- Struttura della tabella `codice_conclusione_gara`
--

CREATE TABLE IF NOT EXISTS `codice_conclusione_gara` (
  `nome` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descrizione_it` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descrizione_en` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `codice_conclusione_gara`
--

INSERT INTO `codice_conclusione_gara` (`nome`, `descrizione_it`, `descrizione_en`) VALUES
('COM', 'Completata', 'Completed'),
('DNF', 'Non finita (Did Not Finish)', 'Did Not Finish'),
('DNS', 'Non partito (Did Not Start)', 'Did Not Start'),
('DSQ', 'Squalificato (Disqualified)', 'Disqualified');

-- --------------------------------------------------------

--
-- Struttura della tabella `documento`
--

CREATE TABLE IF NOT EXISTS `documento` (
  `nomeFile` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idRichiestaTesseramento` bigint(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `gara`
--

CREATE TABLE IF NOT EXISTS `gara` (
  `id` bigint(20) unsigned NOT NULL,
  `nome` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descrizione_it` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descrizione_en` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disputataIl` datetime NOT NULL,
  `idTipoGara` tinyint(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `invito`
--

CREATE TABLE IF NOT EXISTS `invito` (
  `codice` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nome` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cognome` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idAdesionePersonale` bigint(11) unsigned DEFAULT NULL,
  `idSquadra` bigint(11) unsigned DEFAULT NULL,
  `idIscrizione` bigint(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `iscrizione`
--

CREATE TABLE IF NOT EXISTS `iscrizione` (
  `id` bigint(20) unsigned NOT NULL,
  `eseguitaIl` datetime NOT NULL,
  `pettorale` int(11) DEFAULT NULL,
  `motto` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `haImmagine` tinyint(1) NOT NULL,
  `idOrdine` bigint(11) unsigned NOT NULL,
  `idGara` bigint(11) unsigned NOT NULL,
  `idAdesionePersonale` bigint(11) unsigned NOT NULL,
  `idSquadra` bigint(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `modalita_pagamento`
--

CREATE TABLE IF NOT EXISTS `modalita_pagamento` (
  `id` tinyint(3) unsigned NOT NULL,
  `nome_it` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descrizione_it` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nome_en` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descrizione_en` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `modalita_pagamento`
--

INSERT INTO `modalita_pagamento` (`id`, `nome_it`, `descrizione_it`, `nome_en`, `descrizione_en`) VALUES
(1, 'PayPal', NULL, 'PayPal', NULL),
(2, 'Bonifico Bancario', NULL, 'Bank Transfer', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `ordine`
--

CREATE TABLE IF NOT EXISTS `ordine` (
  `id` bigint(20) unsigned NOT NULL,
  `ricevutoIl` datetime NOT NULL,
  `totale` decimal(7,2) NOT NULL,
  `pagato` tinyint(1) NOT NULL,
  `ricevutaInviata` tinyint(1) NOT NULL,
  `ricevutaInviataIl` datetime DEFAULT NULL,
  `idModalitaPagamento` tinyint(3) unsigned NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `clienteIndirizzoLinea1` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `clienteIndirizzoLinea2` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clienteIndirizzoCap` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `clienteIndirizzoCitta` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `clienteIndirizzoProvincia` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clienteIndirizzoStato` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idCliente` bigint(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `richiesta_tesseramento`
--

CREATE TABLE IF NOT EXISTS `richiesta_tesseramento` (
  `id` bigint(20) unsigned NOT NULL,
  `eseguitaIl` datetime NOT NULL,
  `verificata` tinyint(1) NOT NULL,
  `idAdesionePersonale` bigint(11) unsigned NOT NULL,
  `idTipoRichiestaTesseramento` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `risultato`
--

CREATE TABLE IF NOT EXISTS `risultato` (
  `id` bigint(20) unsigned NOT NULL,
  `codiceConclusioneGara` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `posizione` int(11) DEFAULT NULL,
  `posizioneInSesso` int(11) DEFAULT NULL,
  `posizioneInCategoria` int(11) DEFAULT NULL,
  `tempo` time DEFAULT NULL,
  `posizioneDopoNuoto` int(11) DEFAULT NULL,
  `tempoDopoNuoto` time DEFAULT NULL,
  `posizioneDopoBici` int(11) DEFAULT NULL,
  `tempoDopoBici` time DEFAULT NULL,
  `posizioneFrazioneBici` int(11) DEFAULT NULL,
  `tempoFrazioneBici` time DEFAULT NULL,
  `posizioneFrazioneCorsa` int(11) DEFAULT NULL,
  `tempoFrazioneCorsa` time DEFAULT NULL,
  `idIscrizione` bigint(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `societa_fitri`
--

CREATE TABLE IF NOT EXISTS `societa_fitri` (
  `codice` int(11) NOT NULL,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `squadra`
--

CREATE TABLE IF NOT EXISTS `squadra` (
  `id` bigint(20) unsigned NOT NULL,
  `nome` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `tesseramento`
--

CREATE TABLE IF NOT EXISTS `tesseramento` (
  `id` bigint(20) unsigned NOT NULL,
  `finoAl` datetime NOT NULL,
  `matricola` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codiceSocietaFitri` int(11) DEFAULT NULL,
  `stranieroSocieta` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stranieroStato` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idTipoTesseramento` tinyint(3) unsigned NOT NULL,
  `idRichiestaTesseramento` bigint(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `tipo_gara`
--

CREATE TABLE IF NOT EXISTS `tipo_gara` (
  `id` tinyint(3) unsigned NOT NULL,
  `nome_it` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descrizione_it` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nome_en` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descrizione_en` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `tipo_gara`
--

INSERT INTO `tipo_gara` (`id`, `nome_it`, `descrizione_it`, `nome_en`, `descrizione_en`) VALUES
(1, 'Individuale', NULL, 'Individual', NULL),
(2, 'In squadra', NULL, 'Team', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `tipo_iscrizione`
--

CREATE TABLE IF NOT EXISTS `tipo_iscrizione` (
  `id` tinyint(3) unsigned NOT NULL,
  `nome_it` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descrizione_it` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nome_en` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descrizione_en` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `tipo_iscrizione`
--

INSERT INTO `tipo_iscrizione` (`id`, `nome_it`, `descrizione_it`, `nome_en`, `descrizione_en`) VALUES
(1, 'Iscrizione standard', NULL, 'Standard registration', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `tipo_richiesta_tesseramento`
--

CREATE TABLE IF NOT EXISTS `tipo_richiesta_tesseramento` (
  `id` tinyint(3) unsigned NOT NULL,
  `nome_it` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descrizione_it` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nome_en` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descrizione_en` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `tipo_richiesta_tesseramento`
--

INSERT INTO `tipo_richiesta_tesseramento` (`id`, `nome_it`, `descrizione_it`, `nome_en`, `descrizione_en`) VALUES
(1, 'Tesseramento di Giornata', NULL, 'Day Pass', NULL),
(2, 'Tesseramento F.I.Tri', NULL, 'Italian Triathlon Federation (F.I.Tri) registration', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `tipo_tesseramento`
--

CREATE TABLE IF NOT EXISTS `tipo_tesseramento` (
  `id` tinyint(3) unsigned NOT NULL,
  `nome_it` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nome_en` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `tipo_tesseramento`
--

INSERT INTO `tipo_tesseramento` (`id`, `nome_it`, `nome_en`) VALUES
(1, 'Tesseramento di Giornata', 'Day Pass'),
(2, 'Tesseramento F.I.Tri', 'Italian Triathlon Federation (F.I.Tri) registration');

-- --------------------------------------------------------

--
-- Struttura della tabella `utente`
--

CREATE TABLE IF NOT EXISTS `utente` (
  `id` bigint(20) unsigned NOT NULL,
  `username` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gettoneAutenticazione` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gettoneAutenticazioneScadeIl` datetime DEFAULT NULL,
  `nome` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cognome` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sesso` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `natoIl` DATE DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `eAmministratore` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `verifica_pagamento`
--

CREATE TABLE IF NOT EXISTS `verifica_pagamento` (
  `id` bigint(20) unsigned NOT NULL,
  `idOrdine` bigint(20) unsigned NOT NULL,
  `idAmministratore` bigint(20) unsigned NOT NULL,
  `eseguitaIl` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `verifica_richiesta_tesseramento`
--

CREATE TABLE IF NOT EXISTS `verifica_richiesta_tesseramento` (
  `id` bigint(20) unsigned NOT NULL,
  `idAmministratore` bigint(20) unsigned NOT NULL,
  `idRichiestaTesseramento` bigint(20) unsigned NOT NULL,
  `eseguitaIl` datetime NOT NULL,
  `esito` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `versione_database`
--

CREATE TABLE IF NOT EXISTS `versione_database` (
  `versione` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `versione_database`
--

INSERT INTO `versione_database` (`versione`) VALUES
('1.00');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `abilitazione_modalita_pagamento`
--
ALTER TABLE `abilitazione_modalita_pagamento`
  ADD PRIMARY KEY (`idGara`,`idModalitaPagamento`,`finoAl`),
  ADD KEY `idModalitaPagamento` (`idModalitaPagamento`);

--
-- Indici per le tabelle `abilitazione_tipo_iscrizione`
--
ALTER TABLE `abilitazione_tipo_iscrizione`
  ADD PRIMARY KEY (`idGara`,`idTipoIscrizione`,`finoAl`),
  ADD KEY `idTipoIscrizione` (`idTipoIscrizione`);

--
-- Indici per le tabelle `abilitazione_tipo_richiesta_tesseramento`
--
ALTER TABLE `abilitazione_tipo_richiesta_tesseramento`
  ADD PRIMARY KEY (`idTipoRichiestaTesseramento`,`idGara`,`finoAl`),
  ADD KEY `idGara` (`idGara`);

--
-- Indici per le tabelle `adesione_personale`
--
ALTER TABLE `adesione_personale`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `categoriaFitri` (`categoriaFitri`),
  ADD KEY `idSquadra` (`idSquadra`),
  ADD KEY `idUtente` (`idUtente`);

--
-- Indici per le tabelle `categoria_fitri`
--
ALTER TABLE `categoria_fitri`
  ADD PRIMARY KEY (`nome`);

--
-- Indici per le tabelle `codice_conclusione_gara`
--
ALTER TABLE `codice_conclusione_gara`
  ADD PRIMARY KEY (`nome`);

--
-- Indici per le tabelle `documento`
--
ALTER TABLE `documento`
  ADD PRIMARY KEY (`nomeFile`,`idRichiestaTesseramento`),
  ADD KEY `idRichiestaTesseramento` (`idRichiestaTesseramento`);

--
-- Indici per le tabelle `gara`
--
ALTER TABLE `gara`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `tipo` (`idTipoGara`);

--
-- Indici per le tabelle `invito`
--
ALTER TABLE `invito`
  ADD PRIMARY KEY (`codice`),
  ADD KEY `idAdesionePersonale` (`idAdesionePersonale`),
  ADD KEY `idSquadra` (`idSquadra`),
  ADD KEY `idIscrizione` (`idIscrizione`);

--
-- Indici per le tabelle `iscrizione`
--
ALTER TABLE `iscrizione`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `idOrdine` (`idOrdine`),
  ADD KEY `idGara` (`idGara`),
  ADD KEY `idAdesionePersonale` (`idAdesionePersonale`),
  ADD KEY `idSquadra` (`idSquadra`);

--
-- Indici per le tabelle `modalita_pagamento`
--
ALTER TABLE `modalita_pagamento`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome_it` (`nome_it`),
  ADD UNIQUE KEY `nome_en` (`nome_en`);

--
-- Indici per le tabelle `ordine`
--
ALTER TABLE `ordine`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codice` (`id`),
  ADD KEY `idCliente` (`idCliente`),
  ADD KEY `idModalitaPagamento` (`idModalitaPagamento`);

--
-- Indici per le tabelle `richiesta_tesseramento`
--
ALTER TABLE `richiesta_tesseramento`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `idAdesionePersonale` (`idAdesionePersonale`),
  ADD KEY `idTipoRichiestaTesseramento` (`idTipoRichiestaTesseramento`);

--
-- Indici per le tabelle `risultato`
--
ALTER TABLE `risultato`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `codiceConclusioneGara` (`codiceConclusioneGara`),
  ADD KEY `idIscrizione` (`idIscrizione`);

--
-- Indici per le tabelle `societa_fitri`
--
ALTER TABLE `societa_fitri`
  ADD PRIMARY KEY (`codice`);

--
-- Indici per le tabelle `squadra`
--
ALTER TABLE `squadra`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indici per le tabelle `tesseramento`
--
ALTER TABLE `tesseramento`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `codiceSocietaFitri` (`codiceSocietaFitri`),
  ADD KEY `idTipoTesseramento` (`idTipoTesseramento`),
  ADD KEY `idRichiestaTesseramento` (`idRichiestaTesseramento`);

--
-- Indici per le tabelle `tipo_gara`
--
ALTER TABLE `tipo_gara`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome_it` (`nome_it`),
  ADD UNIQUE KEY `nome_en` (`nome_en`);

--
-- Indici per le tabelle `tipo_iscrizione`
--
ALTER TABLE `tipo_iscrizione`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `tipo_richiesta_tesseramento`
--
ALTER TABLE `tipo_richiesta_tesseramento`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome_it` (`nome_it`),
  ADD UNIQUE KEY `nome_en` (`nome_en`);

--
-- Indici per le tabelle `tipo_tesseramento`
--
ALTER TABLE `tipo_tesseramento`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome_it` (`nome_it`),
  ADD UNIQUE KEY `nome_en` (`nome_en`);

--
-- Indici per le tabelle `utente`
--
ALTER TABLE `utente`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indici per le tabelle `verifica_pagamento`
--
ALTER TABLE `verifica_pagamento`
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `idOrdine` (`idOrdine`,`idAmministratore`,`eseguitaIl`);

--
-- Indici per le tabelle `verifica_richiesta_tesseramento`
--
ALTER TABLE `verifica_richiesta_tesseramento`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `idAmministratore` (`idAmministratore`),
  ADD KEY `idRichiestaTesseramento` (`idRichiestaTesseramento`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `adesione_personale`
--
ALTER TABLE `adesione_personale`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT per la tabella `gara`
--
ALTER TABLE `gara`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT per la tabella `iscrizione`
--
ALTER TABLE `iscrizione`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT per la tabella `modalita_pagamento`
--
ALTER TABLE `modalita_pagamento`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT per la tabella `ordine`
--
ALTER TABLE `ordine`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT per la tabella `richiesta_tesseramento`
--
ALTER TABLE `richiesta_tesseramento`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT per la tabella `risultato`
--
ALTER TABLE `risultato`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT per la tabella `squadra`
--
ALTER TABLE `squadra`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT per la tabella `tesseramento`
--
ALTER TABLE `tesseramento`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT per la tabella `tipo_gara`
--
ALTER TABLE `tipo_gara`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT per la tabella `tipo_iscrizione`
--
ALTER TABLE `tipo_iscrizione`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT per la tabella `tipo_richiesta_tesseramento`
--
ALTER TABLE `tipo_richiesta_tesseramento`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT per la tabella `tipo_tesseramento`
--
ALTER TABLE `tipo_tesseramento`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT per la tabella `utente`
--
ALTER TABLE `utente`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT per la tabella `verifica_pagamento`
--
ALTER TABLE `verifica_pagamento`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT per la tabella `verifica_richiesta_tesseramento`
--
ALTER TABLE `verifica_richiesta_tesseramento`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `abilitazione_modalita_pagamento`
--
ALTER TABLE `abilitazione_modalita_pagamento`
  ADD CONSTRAINT `abilitazione_modalita_pagamento_ibfk_1` FOREIGN KEY (`idGara`) REFERENCES `gara` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `abilitazione_modalita_pagamento_ibfk_2` FOREIGN KEY (`idModalitaPagamento`) REFERENCES `modalita_pagamento` (`id`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `abilitazione_tipo_iscrizione`
--
ALTER TABLE `abilitazione_tipo_iscrizione`
  ADD CONSTRAINT `abilitazione_tipo_iscrizione_ibfk_1` FOREIGN KEY (`idTipoIscrizione`) REFERENCES `tipo_iscrizione` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `abilitazione_tipo_iscrizione_ibfk_2` FOREIGN KEY (`idGara`) REFERENCES `gara` (`id`);

--
-- Limiti per la tabella `abilitazione_tipo_richiesta_tesseramento`
--
ALTER TABLE `abilitazione_tipo_richiesta_tesseramento`
  ADD CONSTRAINT `abilitazione_tipo_richiesta_tesseramento_ibfk_2` FOREIGN KEY (`idGara`) REFERENCES `gara` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `abilitazione_tipo_richiesta_tesseramento_ibfk_3` FOREIGN KEY (`idTipoRichiestaTesseramento`) REFERENCES `tipo_richiesta_tesseramento` (`id`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `adesione_personale`
--
ALTER TABLE `adesione_personale`
  ADD CONSTRAINT `adesione_personale_ibfk_1` FOREIGN KEY (`categoriaFitri`) REFERENCES `categoria_fitri` (`nome`) ON UPDATE CASCADE,
  ADD CONSTRAINT `adesione_personale_ibfk_2` FOREIGN KEY (`idSquadra`) REFERENCES `squadra` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `adesione_personale_ibfk_3` FOREIGN KEY (`idUtente`) REFERENCES `utente` (`id`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `documento`
--
ALTER TABLE `documento`
  ADD CONSTRAINT `documento_ibfk_1` FOREIGN KEY (`idRichiestaTesseramento`) REFERENCES `richiesta_tesseramento` (`id`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `gara`
--
ALTER TABLE `gara`
  ADD CONSTRAINT `gara_ibfk_1` FOREIGN KEY (`idTipoGara`) REFERENCES `tipo_gara` (`id`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `invito`
--
ALTER TABLE `invito`
  ADD CONSTRAINT `invito_ibfk_1` FOREIGN KEY (`idAdesionePersonale`) REFERENCES `adesione_personale` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `invito_ibfk_2` FOREIGN KEY (`idSquadra`) REFERENCES `squadra` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `invito_ibfk_3` FOREIGN KEY (`idIscrizione`) REFERENCES `iscrizione` (`id`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `iscrizione`
--
ALTER TABLE `iscrizione`
  ADD CONSTRAINT `iscrizione_ibfk_1` FOREIGN KEY (`idOrdine`) REFERENCES `ordine` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `iscrizione_ibfk_2` FOREIGN KEY (`idGara`) REFERENCES `gara` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `iscrizione_ibfk_3` FOREIGN KEY (`idAdesionePersonale`) REFERENCES `adesione_personale` (`id`),
  ADD CONSTRAINT `iscrizione_ibfk_4` FOREIGN KEY (`idSquadra`) REFERENCES `squadra` (`id`);

--
-- Limiti per la tabella `ordine`
--
ALTER TABLE `ordine`
  ADD CONSTRAINT `ordine_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `utente` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `ordine_ibfk_2` FOREIGN KEY (`idModalitaPagamento`) REFERENCES `modalita_pagamento` (`id`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `richiesta_tesseramento`
--
ALTER TABLE `richiesta_tesseramento`
  ADD CONSTRAINT `richiesta_tesseramento_ibfk_2` FOREIGN KEY (`idAdesionePersonale`) REFERENCES `adesione_personale` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `richiesta_tesseramento_ibfk_3` FOREIGN KEY (`idTipoRichiestaTesseramento`) REFERENCES `tipo_richiesta_tesseramento` (`id`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `risultato`
--
ALTER TABLE `risultato`
  ADD CONSTRAINT `risultato_ibfk_1` FOREIGN KEY (`codiceConclusioneGara`) REFERENCES `codice_conclusione_gara` (`nome`) ON UPDATE CASCADE,
  ADD CONSTRAINT `risultato_ibfk_2` FOREIGN KEY (`idIscrizione`) REFERENCES `iscrizione` (`id`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `tesseramento`
--
ALTER TABLE `tesseramento`
  ADD CONSTRAINT `tesseramento_ibfk_1` FOREIGN KEY (`codiceSocietaFitri`) REFERENCES `societa_fitri` (`codice`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tesseramento_ibfk_3` FOREIGN KEY (`idRichiestaTesseramento`) REFERENCES `richiesta_tesseramento` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tesseramento_ibfk_4` FOREIGN KEY (`idTipoTesseramento`) REFERENCES `tipo_tesseramento` (`id`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `verifica_richiesta_tesseramento`
--
ALTER TABLE `verifica_richiesta_tesseramento`
  ADD CONSTRAINT `verifica_richiesta_tesseramento_ibfk_1` FOREIGN KEY (`idAmministratore`) REFERENCES `utente` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `verifica_richiesta_tesseramento_ibfk_2` FOREIGN KEY (`idRichiestaTesseramento`) REFERENCES `richiesta_tesseramento` (`id`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
