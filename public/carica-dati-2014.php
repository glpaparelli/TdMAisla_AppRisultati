<?php

function nomeCristiano($nome) {
    $nome = strtolower($nome);
    $a = explode(' ', $nome);
    $r = ucfirst($a[0]);
    for ($i = 1; $i < count($a); $i++) {
        $r .= ' ' . ucfirst($a[$i]);
    }
    return $r;
}

function campoCristiano($conn, $campo) {
    if ($campo !== NULL) {
        $campo = $conn->escape_string($campo);
    }
    return $campo;
}

function coppiaCristiana($conn, $campo1, $campo2) {
    $campo = NULL;
    if ($campo1 !== NULL) {
        $campo = $conn->escape_string($campo1);
    } else if ($campo2 !== NULL){
        $campo = $conn->escape_string($campo2);
    }
    return $campo;
}

include 'dati-2014.php';

$conf = parse_ini_file('./rest-api/config.ini', true);
$mysqlConf = $conf['mysql'];

$conn = new mysqli($mysqlConf['server'], $mysqlConf['username'], $mysqlConf['password'], $mysqlConf['database']);
if ($conn->connect_errno) {
    throw new Exception("Connection error: $conn->connect_error");
}

$idTipoGaraIndividuale = $conn->query('SELECT id FROM tipo_gara WHERE nome_it = \'Individuale\'')->fetch_array()[0];
$idTipoGaraInSquadra = $conn->query('SELECT id FROM tipo_gara WHERE nome_it = \'In squadra\'')->fetch_array()[0];
$idTipoRichiestaTesseramentoGiornata = $conn->query('SELECT id FROM tipo_richiesta_tesseramento WHERE nome_it = \'Tesseramento di Giornata\'')->fetch_array()[0];
$idTipoRichiestaTesseramentoFitri = $conn->query('SELECT id FROM tipo_richiesta_tesseramento WHERE nome_it = \'Tesseramento F.I.Tri\'')->fetch_array()[0];
$idTipoTesseramentoGiornata = $conn->query('SELECT id FROM tipo_tesseramento WHERE nome_it = \'Tesseramento di Giornata\'')->fetch_array()[0];
$idTipoTesseramentoFitri = $conn->query('SELECT id FROM tipo_tesseramento WHERE nome_it = \'Tesseramento F.I.Tri\'')->fetch_array()[0];

$DEFAULT_STRING = 'importazione dati 2014';
$DEFAULT_DATE = '2014-06-29';

$query = "DELETE FROM iscrizione__adesione_personale;";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}

$query = "DELETE FROM risultato;";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}

$query = "DELETE FROM tesseramento__societa_fitri;";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}

$query = "DELETE FROM iscrizione__squadra;";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}

$query = "DELETE FROM adesione_personale__squadra;";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}

$query = "DELETE FROM tesseramento;";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}
$query = "DELETE FROM richiesta_tesseramento; ";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}
$query = "DELETE FROM adesione_personale; ";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}
$query = "DELETE FROM squadra; ";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}
$query = "DELETE FROM iscrizione; ";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}
$query = "DELETE FROM gara;";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}
$query = "DELETE FROM ordine;";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}
$query = "DELETE FROM utente;";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}
$query = "DELETE FROM societa_fitri;";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}
echo '<p>Base di dati svuotata</p><hr>';
//-------------------------------

foreach ($societaFitri as $s) {
    $query = "INSERT INTO societa_fitri (codice, nome) VALUES (" . $s['codice'] . ", '"
            . $conn->escape_string($s['nome'])
            . "');";
    if (!$conn->query($query)) {
        throw new Exception("$conn->error ($query)");
    }
}
echo '<p>Società aggiunte</p><hr>';
//-------------------------------
/* NOTA
 * Id non può iniziare da 0, ma da 1, altrimenti viene utilizzato auto_increment
 */
$curId = 1;
$query = "INSERT INTO utente
	(id, eAmministratore, nome, cognome, email)
	VALUES ($curId, 0, '$DEFAULT_STRING', '$DEFAULT_STRING', '$DEFAULT_STRING');";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}

$idOrdine = 1;
$query = "INSERT INTO ordine
	(id, idCliente, ricevutoIl, totale, pagato, ricevutaInviata, idModalitaPagamento, clienteIndirizzoLinea1, clienteIndirizzoCap, clienteIndirizzoCitta, clienteIndirizzoStato)
	VALUES ($idOrdine, $curId, '$DEFAULT_DATE', 0, 1, 1, 1, '$DEFAULT_STRING',  '$DEFAULT_STRING', '$DEFAULT_STRING', '$DEFAULT_STRING');";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}

echo '<p>Ordine e cliente di comodo aggiunti</p><br /><hr>';
//-------------------------------

$idSprintIndividuale = 1;
$query = "INSERT INTO gara (id, nome, disputataIl, idTipoGara)
	VALUES ($idSprintIndividuale, 'TdM AISLA Sprint MTB Individuale', '$DEFAULT_DATE', $idTipoGaraIndividuale);";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}

$idOlimpicoIndividuale = 2;
$query = "INSERT INTO gara (id, nome, disputataIl, idTipoGara)
	VALUES ($idOlimpicoIndividuale, 'TdM AISLA Olimpico MTB Individuale', '$DEFAULT_DATE', $idTipoGaraIndividuale);";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}

$idOlimpicoInSquadra = 3;
$query = "INSERT INTO gara (id, nome, disputataIl, idTipoGara)
	VALUES ($idOlimpicoInSquadra, 'TdM AISLA Olimpico MTB In squadra', '$DEFAULT_DATE', $idTipoGaraInSquadra);";
if (!$conn->query($query)) {
    throw new Exception("$conn->error ($query)");
}
echo '<p>Gare aggiunte</p>';
//-------------------------------

$ultimoNomeSquadra = NULL;
$curIdSquadra = 0; // verrà incrementatto prima del primo utilizzo
$curId++; // attenzione all'inserimento dell'utente di comodo! (vedi prima)
$individualeFinito = false;

foreach ($dati2014 as $dato) {
    
    $nomeGara = strtolower($dato['gara']);
    $tipoGara = strtolower($dato['tipo']);
    $nome = nomeCristiano(campoCristiano($conn, $dato['nome']));
    $cognome = nomeCristiano(campoCristiano($conn, $dato['cognome']));
    $categoriaFitri = campoCristiano($conn, $dato['categoriaFitri']);
    $email = strtolower(campoCristiano($conn, $dato['email']));
    $telefono = campoCristiano($conn, $dato['telefono']);
    $sesso = strtoupper(campoCristiano($conn, $dato['sesso']));
    $matricolaFitri = campoCristiano($conn, $dato['matricolaFitri']);
    $codiceSocietaFitri = campoCristiano($conn, $dato['codiceSocietaFitri']);

    $nomeSquadra = campoCristiano($conn, $dato['nomeSquadra']);

    $pettorale = coppiaCristiana($conn, $dato['pettorale'], $dato['squadraPettorale']);
    $conclusioneGara = coppiaCristiana($conn, $dato['conclusioneGara'], $dato['squadraConclusioneGara']);
    $posizione = coppiaCristiana($conn, $dato['posizione'], $dato['squadraPosizione']);
    $posizioneInSesso = campoCristiano($conn, $dato['posizioneInSesso']);
    $posizioneInCategoria = coppiaCristiana($conn, $dato['posizioneInCategoria'], $dato['squadraPosizioneInCategoria']);
    $tempo = coppiaCristiana($conn, $dato['tempo'], $dato['squadraTempo']);
    $tempoDopoNuoto = coppiaCristiana($conn, $dato['tempoDopoNuoto'], $dato['squadraTempoDopoNuoto']);
    $posizioneDopoNuoto = coppiaCristiana($conn, $dato['posizioneDopoNuoto'], $dato['squadraPosizioneDopoNuoto']);
    $tempoFrazioneBici = coppiaCristiana($conn, $dato['tempoFrazioneBici'], $dato['squadraTempoFrazioneBici']);
    $posizioneFrazioneBici = coppiaCristiana($conn, $dato['posizioneFrazioneBici'], $dato['squadraPosizioneFrazioneBici']);
    $tempoDopoBici = coppiaCristiana($conn, $dato['tempoDopoBici'], $dato['squadraTempoDopoBici']);
    $posizioneDopoBici = coppiaCristiana($conn, $dato['posizioneDopoBici'], $dato['squadraPosizioneDopoBici']);
    $tempoFrazioneCorsa = coppiaCristiana($conn, $dato['tempoFrazioneCorsa'], $dato['squadraTempoFrazioneCorsa']);
    $posizioneFrazioneCorsa = coppiaCristiana($conn, $dato['posizioneFrazioneCorsa'], $dato['squadraPosizioneFrazioneCorsa']);

    echo "$curId ";
    $query = "INSERT INTO utente
	(id, eAmministratore, nome, cognome, sesso, natoIl, email, telefono)
	VALUES ($curId, 0, '$nome', '$cognome', '$sesso', '$DEFAULT_DATE', '$email', '$telefono');";
    if (!$conn->query($query)) {
        throw new Exception("$conn->error ($query)");
    }

    $query = "INSERT INTO adesione_personale
	(id, idUtente, categoriaFitri, indirizzoLinea1, indirizzoCap, indirizzoCitta, indirizzoStato)
	VALUES ($curId, $curId, '$categoriaFitri', '$DEFAULT_STRING',  '$DEFAULT_STRING', '$DEFAULT_STRING', '$DEFAULT_STRING');";
    if (!$conn->query($query)) {
        throw new Exception("$conn->error ($query)");
    }

    $tempIdTipoRichiestaTesseramento = ($matricolaFitri === NULL) ? $idTipoRichiestaTesseramentoGiornata : $idTipoRichiestaTesseramentoFitri;
    $query = "INSERT INTO richiesta_tesseramento
	(id, eseguitaIl, verificata, idAdesionePersonale, idTipoRichiestaTesseramento)
	VALUES ($curId, '$DEFAULT_DATE', 1, $curId, $tempIdTipoRichiestaTesseramento);";
    if (!$conn->query($query)) {
        throw new Exception("$conn->error ($query)");
    }

    if ($matricolaFitri !== NULL) {
        $tempMatricolaFitri = ($matricolaFitri === NULL) ? "null" : "'$matricolaFitri'";
        $tempCodiceSocietaFitri = ($codiceSocietaFitri === NULL) ? "null" : "'$codiceSocietaFitri'";
        $tempIdTipoTesseramento = ($matricolaFitri === NULL) ? $idTipoTesseramentoGiornata : $idTipoTesseramentoFitri;
        $query = "INSERT INTO tesseramento
                (id, finoAl, matricola, idTipoTesseramento, idRichiestaTesseramento)
                VALUES ($curId, '$DEFAULT_DATE', $matricolaFitri, $idTipoTesseramentoFitri, $curId);";
        if (!$conn->query($query)) {
            throw new Exception("$conn->error ($query)");
        }

        $query = "INSERT INTO tesseramento__societa_fitri
                (idTesseramento, codiceSocietaFitri)
                VALUES ($curId, $codiceSocietaFitri);";
        if (!$conn->query($query)) {
            throw new Exception("$conn->error ($query)");
        }
    } else {
        $query = "INSERT INTO tesseramento
                (id, finoAl, matricola, idTipoTesseramento, idRichiestaTesseramento)
                VALUES ($curId, '$DEFAULT_DATE', NULL, $idTipoTesseramentoGiornata, $curId);";
        if (!$conn->query($query)) {
            throw new Exception("$conn->error ($query)");
        }
    }

    if (strpos($nomeGara, 'olimpico') !== false) {
        if (strpos($tipoGara, 'individuale') !== false) {
            $temp = $idOlimpicoIndividuale;
        } else if (strpos($tipoGara, 'squadra') !== false) {
            $temp = $idOlimpicoInSquadra;
        } else {
            throw new Exception("Che tipo è? $nomeGara $tipoGara");
        }
    } else if (strpos($nomeGara, 'sprint') !== false) {
        if (strpos($tipoGara, 'individuale') !== false) {
            $temp = $idSprintIndividuale;
        } else if (strpos($tipoGara, 'squadra') !== false) {
            throw new Exception("Questo non dovrebbe esserci");
        } else {
            throw new Exception("Che tipo è? $nomeGara $tipoGara");
        }
    } else {
        throw new Exception("Che gara è? $nomeGara $tipoGara");
    }


    //-------------------------------------------------------
    // INDIVIDUALE

    if ($tipoGara === 'individuale') {
        if($individualeFinito) {
            throw new Exception("Comportamento non previsto. Le squadre vengono dopo tutti gli individuali");
        }
        
        $curIdIscrizione = $curId;
    
        $query = "INSERT INTO iscrizione
            (id, eseguitaIl, pettorale, idOrdine, idGara)
            VALUES ($curIdIscrizione, '$DEFAULT_DATE', $pettorale, $idOrdine, $temp);";
        if (!$conn->query($query)) {
            throw new Exception("$conn->error ($query)");
        }

        $query = "INSERT INTO iscrizione__adesione_personale
	(idIscrizione, idAdesionePersonale)
	VALUES ($curId, $curId);";
        if (!$conn->query($query)) {
            throw new Exception("$conn->error ($query)");
        }
        
        $query = "INSERT INTO risultato
            (idIscrizione,
            codiceConclusioneGara,
            posizione,
            posizioneInSesso,
            posizioneInCategoria,
            tempo,
            tempoDopoNuoto,
            posizioneDopoNuoto,
            tempoFrazioneBici,
            posizioneFrazioneBici,
            tempoDopoBici,
            posizioneDopoBici,
            tempoFrazioneCorsa,
            posizioneFrazioneCorsa)
	VALUES ($curIdIscrizione,"
            . ($conclusioneGara!==''?"'$conclusioneGara'":"'COM'") .","
            . ($posizione!==NULL?"$posizione":'NULL') .','
            . ($posizioneInSesso!==NULL?"$posizioneInSesso":'NULL') .','
            . ($posizioneInCategoria!==NULL?"$posizioneInCategoria":'NULL') .','
            . ($tempo!==NULL?"'$tempo'":'NULL') .','
            . ($tempoDopoNuoto!==NULL?"'$tempoDopoNuoto'":'NULL') .','
            . ($posizioneDopoNuoto!==NULL?"$posizioneDopoNuoto":'NULL') .','
            . ($tempoFrazioneBici!==NULL?"'$tempoFrazioneBici'":'NULL') .','
            . ($posizioneFrazioneBici!==NULL?"$posizioneFrazioneBici":'NULL') .','
            . ($tempoDopoBici!==NULL?"'$tempoDopoBici'":'NULL') .','
            . ($posizioneDopoBici!==NULL?"$posizioneDopoBici":'NULL') .','
            . ($tempoFrazioneCorsa!==NULL?"'$tempoFrazioneCorsa'":'NULL') .','
            . ($posizioneFrazioneCorsa!==NULL?"$posizioneFrazioneCorsa":'NULL') .');';
        if (!$conn->query($query)) {
            throw new Exception("$conn->error ($query)");
        }
        
    //-------------------------------------------------------
    // SQUADRA
    } else if ($tipoGara === 'in squadra') {
        $individualeFinito = true;
        // atleti di una stessa squadra sono uno dopo l'altro
        if ($ultimoNomeSquadra !== $nomeSquadra) {
            //-------------------------------------------------------
            // NUOVA SQUADRA
            $ultimoNomeSquadra = $nomeSquadra;
            $curIdSquadra++;
            $curIdIscrizione++;
            
            $query = "INSERT INTO squadra
                (id, nome)
                VALUES ($curIdSquadra, '$nomeSquadra');";
            if (!$conn->query($query)) {
                throw new Exception("$conn->error ($query)");
            }
            
            $query = "INSERT INTO iscrizione
                (id, eseguitaIl, pettorale, idOrdine, idGara)
                VALUES ($curIdIscrizione, '$DEFAULT_DATE', $pettorale, $idOrdine, $temp);";
            if (!$conn->query($query)) {
                throw new Exception("$conn->error ($query)");
            }
            
            $query = "INSERT INTO iscrizione__squadra
                (idIscrizione, idSquadra)
                VALUES ($curIdIscrizione, $curIdSquadra);";
            if (!$conn->query($query)) {
                throw new Exception("$conn->error ($query)");
            }
            
            $query = "INSERT INTO risultato
                (idIscrizione,
                codiceConclusioneGara,
                posizione,
                posizioneInSesso,
                posizioneInCategoria,
                tempo,
                tempoDopoNuoto,
                posizioneDopoNuoto,
                tempoFrazioneBici,
                posizioneFrazioneBici,
                tempoDopoBici,
                posizioneDopoBici,
                tempoFrazioneCorsa,
                posizioneFrazioneCorsa)
            VALUES ($curIdIscrizione,"
                . ($conclusioneGara!==''?"'$conclusioneGara'":"'COM'") .","
                . ($posizione!==NULL?"$posizione":'NULL') .","
                . ('NULL') .","
                . ($posizioneInCategoria!==NULL?"$posizioneInCategoria":'NULL') .","
                . ($tempo!==NULL?"'$tempo'":'NULL') .","
                . ($tempoDopoNuoto!==NULL?"'$tempoDopoNuoto'":'NULL') .","
                . ($posizioneDopoNuoto!==NULL?"$posizioneDopoNuoto":'NULL') .","
                . ($tempoFrazioneBici!==NULL?"'$tempoFrazioneBici'":'NULL') .","
                . ($posizioneFrazioneBici!==NULL?"$posizioneFrazioneBici":'NULL') .","
                . ($tempoDopoBici!==NULL?"'$tempoDopoBici'":'NULL') .","
                . ($posizioneDopoBici!==NULL?"$posizioneDopoBici":'NULL') .","
                . ($tempoFrazioneCorsa!==NULL?"'$tempoFrazioneCorsa'":'NULL') .","
                . ($posizioneFrazioneCorsa!==NULL?"$posizioneFrazioneCorsa":'NULL' ) .")";
            if (!$conn->query($query)) {
                throw new Exception("$conn->error [$query]");
            }
        }        

        $query = "INSERT INTO adesione_personale__squadra
            (idAdesionePersonale, idSquadra)
            VALUES ($curId, $curIdSquadra);";
        if (!$conn->query($query)) {
            throw new Exception("$conn->error ($query)");
        }
        
    } else {
        throw new Exception('Tipo imprevisto ' . $tipoGara);
    }
    $curId++;
}

$conn->close();
