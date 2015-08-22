<?php

class RisultatiApi extends MySqlRestApi {

    public function __construct($request, $mysqlConf) {
        parent::__construct($request, $mysqlConf);
    }

    protected function Gara() {
        if ($this->method == 'GET') {

            $query = 'SELECT '
                    . 'id, '
                    . 'nome, '
                    . 'disputataIl, '
                    . 'idTipoGara '
                    . 'FROM gara';
            $rs = $this->conn->query($query);
            if ($rs) {
                $array_risultati = $this->fetch_all_assoc($rs);
                foreach ($array_risultati as &$risultato) {
                    // tipo gara
                    $risultato['tipoGara'] = $this->getTipoGara($risultato['idTipoGara']);
                    unset($risultato['idTipoGara']);
                }
            } else {
                throw new Exception($this->conn->error);
            }
            return $array_risultati;
        } else {
            throw new MethodNotAllowedException();
        }
    }

    protected function Risultati() {
        if ($this->method == 'GET') {
            if (isset($this->request['idGara']) && is_numeric($this->request['idGara'])) {
                $idGara = $this->request['idGara'];
                $query = 'SELECT '
                    . 'iscrizione.pettorale, '
                    . 'iscrizione__adesione_personale.idAdesionePersonale, '
                    . 'iscrizione__squadra.idSquadra, '
                    . 'risultato.codiceConclusioneGara AS conlusioneGara, '
                    . 'risultato.posizione, '
                    . 'risultato.posizioneInSesso, '
                    . 'risultato.posizioneInCategoria, '
                    . 'risultato.tempo, '
                    . 'risultato.posizioneDopoNuoto, '
                    . 'risultato.tempoDopoNuoto, '
                    . 'risultato.posizioneDopoBici, '
                    . 'risultato.tempoDopoBici, '
                    . 'risultato.posizioneFrazioneBici, '
                    . 'risultato.tempoFrazioneBici, '
                    . 'risultato.posizioneFrazioneCorsa, '
                    . 'risultato.tempoFrazioneCorsa '
                    . 'FROM iscrizione INNER JOIN risultato ON iscrizione.id = risultato.idIscrizione '
                    . 'INNER JOIN gara ON gara.id = iscrizione.idGara '
                    . 'LEFT JOIN iscrizione__adesione_personale ON iscrizione__adesione_personale.idIscrizione = iscrizione.id '
                    . 'LEFT JOIN iscrizione__squadra ON iscrizione__squadra.idIscrizione = iscrizione.id '
                    . "WHERE gara.id = $idGara "
                    . 'ORDER BY risultato.codiceConclusioneGara ASC, risultato.posizione ASC';
                $rs = $this->conn->query($query);
                if ($rs) {
                    $array_risultati = $this->fetch_all_assoc($rs);
                    foreach ($array_risultati as &$risultato) {
                        if ($risultato['idAdesionePersonale'] !== NULL) {
                            $risultato['atleta'] = $this->getAtleta($risultato['idAdesionePersonale']);
                        } else if ($risultato['idSquadra'] !== NULL) {
                            $risultato['squadra'] = $this->getSquadra($risultato['idSquadra']);
                        } else {
                            throw new InconsistentDataException('Both idAdesionePersonale and idSquadra are null');
                        }

                        unset($risultato['idAdesionePersonale']);
                        unset($risultato['idSquadra']);
                    }
                } else {
                    throw new Exception($this->conn->error);
                }
                return $array_risultati;
            } else {
                throw new BadRequestException('idGara is required and must be numeric');
            }
        } else {
            throw new MethodNotAllowedException();
        }
    }

    private function getTipoGara($idTipoGara) {
        $r = NULL;
        if (isset($idTipoGara)) {
            $query = 'SELECT nome_it, nome_en '
                    . 'FROM tipo_gara '
                    . "WHERE id = $idTipoGara";
            $rs = $this->conn->query($query);
            if ($rs) {
                $r = $this->fetch_all_assoc($rs)[0];
            } else {
                throw new InconsistentDataException("No tipo_gara with id: $idTipoGara");
            }
        }
        return $r;
    }

    private function getAtleta($idAdesionePersonale) {
        $r = NULL;
        if (isset($idAdesionePersonale)) {
            $query = "SELECT 
                            utente.nome, 
                            utente.cognome, 
                            societa_fitri.nome as societa, 
                            adesione_personale.categoriaFitri, 
                            utente.sesso 
                    FROM 
                            adesione_personale 
                            INNER JOIN utente ON utente.id = adesione_personale.id 
                            INNER JOIN richiesta_tesseramento ON richiesta_tesseramento.idAdesionePersonale = adesione_personale.id 
                            INNER JOIN tesseramento ON tesseramento.idRichiestaTesseramento = richiesta_tesseramento.id 
                            LEFT JOIN tesseramento__societa_fitri ON tesseramento__societa_fitri.idTesseramento = tesseramento.id 
                            LEFT JOIN societa_fitri ON societa_fitri.codice = tesseramento__societa_fitri.codiceSocietaFitri
                    WHERE adesione_personale.id = $idAdesionePersonale";
            $rs = $this->conn->query($query);
            if ($rs) {
                $r = $this->fetch_all_assoc($rs)[0];

                if ($r['societa'] === NULL) {
                    unset($r['societa']);
                }
            } else {
                throw new InconsistentDataException("No adesione_personale with id: $idAdesionePersonale");
            }
        }
        return $r;
    }

    private function getSquadra($idSquadra) {
        $r = NULL;
        if (isset($idSquadra)) {
            $query = "SELECT nome
                    FROM squadra
                    WHERE id = $idSquadra";
            $rs = $this->conn->query($query);
            if ($rs) {
                $r = $this->fetch_all_assoc($rs)[0];

                $r['componenti'] = [];

                $query = "SELECT idAdesionePersonale
                    FROM adesione_personale__squadra
                    WHERE idSquadra = $idSquadra";
                $rs = $this->conn->query($query);

                if ($rs) {
                    $array_idAdesionePersonale = $this->fetch_all_assoc($rs);

                    foreach ($array_idAdesionePersonale as &$idAdesionePersonale) {
                        array_push($r['componenti'], $this->getAtleta($idAdesionePersonale['idAdesionePersonale']));
                    }
                }
            } else {
                throw new InconsistentDataException("No squadra with id: $idSquadra");
            }
        }
        return $r;
    }

}
