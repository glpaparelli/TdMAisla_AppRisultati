<?php

class RisultatiApi extends MySqlRestApi {

    public function __construct($request, $mysqlConf) {
        parent::__construct($request, $mysqlConf);
    }
    
    protected function risultato() {
        if ($this->method == 'GET') {
            $query = 'SELECT'
                    . 'gara.nome as nomeGara,'
                    . 'gara.disputataIl as garaDisputataIl,'
                    . 'gara.idTipoGara,'
                    . 'iscrizione.idAdesionePersonale,'
                    . 'iscrizione.idSquadra,'
                    . 'risultato.codiceConclusioneGara AS conlusioneGara,'
                    . 'risultato.posizione,'
                    . 'risultato.posizioneInSesso,'
                    . 'risultato.posizioneInCategoria,'
                    . 'risultato.tempo,'
                    . 'risultato.posizioneDopoNuoto,'
                    . 'risultato.tempoDopoNuoto,'
                    . 'risultato.posizioneDopoBici,'
                    . 'risultato.tempoDopoBici,'
                    . 'risultato.posizioneFrazioneBici,'
                    . 'risultato.tempoFrazioneBici,'
                    . 'risultato.posizioneFrazioneCorsa,'
                    . 'risultato.tempoFrazioneCorsa'
                    . 'FROM iscrizione INNER JOIN risultato ON iscrizione.id = risultato.idIscrizione'
                    . 'INNER JOIN gara ON gara.id = iscrizione.idGara';
            $result = $this->conn->query($query);
            if($result) {
                $risultato = $result->fetch_all(MYSQLI_ASSOC);
                $result->free();
            }
            else {
                $risultato = [];
            }           
            
            return $risultato;
        } else {
            throw new MethodNotAllowedException();
        }
    }

}
