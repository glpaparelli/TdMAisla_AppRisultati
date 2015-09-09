
/* global angular */
angular.module("testFilter")
//TODO QUESTO FILTRO NON SERVE è quello per il tipo della gara, individuale e a squadre
.filter("garePresenti", function (){
    return function (gare){
        if(angular.isArray(gare)){
            var controlloGare = [];
            var trovato = false;
            for(var i = 0;i<gare.length;i++){
                trovato = false;
                for(var j = 0; j<controlloGare.length && trovato == false;j++){
                    if(angular.equals(controlloGare[j],gare[i].tipoGara))
                        trovato = true;           
                }
                if(trovato === false)
                    controlloGare.push(gare[i].tipoGara);
            }
            return controlloGare;
        }
        else{
            return gare;
        }
    };
})
.filter("categoriaPresente", function(){
    return function (risultato){
        if(angular.isArray(risultato) && risultato.squadra == null){
            var controlloCategoria = [];
            var trovato = false;
            for(var i = 0;i<risultato.length;i++){
                trovato = false;
                  for(var j = 0; j < controlloCategoria.length && trovato == false;j++){
                    if(controlloCategoria[j] == risultato[i].atleta.categoriaFitri){
                        trovato = true;                     
                    }
                }
                if(trovato == false && !risultato[i].squadra ){
                    controlloCategoria.push(risultato[i].atleta.categoriaFitri);
                }
            }
            return controlloCategoria;
        }
        else{
            return risultato;
        }
    };
})
.filter("sessoPresente", function (){
    return function (risultato){
        if(angular.isArray(risultato)){
            var controlloSesso = [];
            var trovato = false;
            for(var i = 0; i <risultato.length; i++){
                trovato = false;
                for(var j = 0; j < controlloSesso.length && trovato == false;j++){
                    if(controlloSesso[j] == risultato[i].atleta.sesso){
                        trovato = true;                     
                    }
                }
                if(trovato == false && !risultato[i].squadra ){
                    controlloSesso.push(risultato[i].atleta.sesso);
                }
            }
            return controlloSesso;
        }
        else{
            return risultato;
        }
    };
})
.filter("nomeGara", function (){
    return function (gare){
        if(angular.isArray(gare)){
            var controlloGare = [];
            var trovato = false;
            for(var i = 0; i <gare.length; i++){
                trovato = false;
                for(var j = 0; j < controlloGare.length && trovato == false;j++){
                    if(controlloGare[j] == gare[i].nome){
                        trovato = true;                     
                    }
                }
                if(trovato == false){
                    controlloGare.push(gare[i].nome);
                }
            }
            return controlloGare;
        }
        else{
            return gare;
        }
    };
})
.filter("filtroSesso", function (){
    return function (risultato, sessoSelezionato){
        if(angular.isArray(risultato) && sessoSelezionato != null ){
            var filtratoPerSesso = [];            
            if(sessoSelezionato == "NS"){
                filtratoPerSesso = risultato;
            }else{
                for(var i = 0; i <risultato.length; i++){
                if(sessoSelezionato == risultato[i].atleta.sesso)
                    filtratoPerSesso.push(risultato[i]);
                }
            }
            
            return filtratoPerSesso;
        }else
            return risultato ;
    };
})
.filter("filtroCategoria", function (){
    return function (risultato, categoriaSelezionata){
        if(angular.isArray(risultato) && categoriaSelezionata != null){
            var filtratoPerCategoria = [];            
            if(categoriaSelezionata == "NC"){
                filtratoPerCategoria = risultato;
            }else{
                for (var i = 0; i<risultato.length; i++){
                    if(risultato[i].squadra != null){
                        categoriaSelezionata = null;
                    };
                }   
                for(var i = 0; i <risultato.length; i++){
                    if(categoriaSelezionata == risultato[i].atleta.categoriaFitri){
                        filtratoPerCategoria.push(risultato[i]);
                    }
                }
            }
            
            return filtratoPerCategoria;
        }else
            return risultato ;
    };
})
.filter("filtroRicerca", function(){
    return  function (risultato, stringaDiRicerca){
        stringaDiRicerca = angular.uppercase(stringaDiRicerca);
        if(angular.isArray(risultato) && stringaDiRicerca != null){
            var risultatoCongruo = [];
            
            for(var i = 0; i < risultato.length; i++){
                if(risultato[i].squadra == null){
                    var nome = angular.uppercase(risultato[i].atleta.nome);
                    var cognome = angular.uppercase(risultato[i].atleta.cognome);
                    if(risultato[i].atleta.societa == null){
                        if(nome.includes(stringaDiRicerca) || 
                            cognome.includes(stringaDiRicerca)){
                            risultatoCongruo.push(risultato[i]);
                        }
                    }else{
                        var societa = angular.uppercase(risultato[i].atleta.societa);
                        if(nome.includes(stringaDiRicerca) || cognome.includes(stringaDiRicerca)
                                || societa.includes(stringaDiRicerca)){
                            risultatoCongruo.push(risultato[i]);
                        }
                    }   
                }else{
                    for(var j = 0; j<risultato[i].squadra.componenti.length; j++){
                        var nomeSquadra = angular.uppercase(risultato[i].squadra.nome);
                        var nomeComponente = angular.uppercase(risultato[i].squadra.componenti[j].nome);
                        if(nomeSquadra.includes(stringaDiRicerca)){
                            risultatoCongruo.push(risultato[i]);
                            break;
                        }        
                    }
                }
                
            }
            return risultatoCongruo;
        }else
            return risultato;
    };
})
.filter("filtroSelezionato", function(){
    return function (risultato, visualizzaSelezionati){
        if(angular.isArray(risultato) && visualizzaSelezionati == true){
            var selezionati = [];
            for(var i = 0; i < risultato.length; i++){
                if(risultato[i].squadra == null){
                    var squadra = false;
                }else{
                    var squadra = true; 
                }
                
            }
            
            if(squadra == false){       
                for (var i = 0; i<risultato.length; i++){
                    if(risultato[i].atleta.selezionato == true){
                        selezionati.push(risultato[i]);
                    }
                }
            }else if(squadra == true){
                for (var i = 0; i<risultato.length; i++){
                    if(risultato[i].squadra.selezionato == true){
                        selezionati.push(risultato[i]);
                    }
                }
            }
            return selezionati;
        }else 
            return risultato;
        
    };
})
.filter("filtroDifferenziale", function(){
    return function (risultato, tempoDifferenziale, visualizzaSelezionati, gara){
        if(angular.isArray(risultato) && tempoDifferenziale == true 
                && visualizzaSelezionati == true && risultato.length > 0 ){
            
            
            if(risultato[0].squadra == null || risultato[0].squadra == "undefined"){
                var squadra = false;
            }else
                squadra = true;
            
            var tempiPiuVeloci = {
                   tempoDopoNuoto:     new Date(gara.disputataIl),
                   tempoFrazioneCorsa: new Date(gara.disputataIl),
                   tempoFrazioneBici:  new Date(gara.disputataIl)
               };
            var tempoDaConfrontare = {
                tempoDopoNuoto:     new Date(gara.disputataIl),
                tempoFrazioneCorsa: new Date(gara.disputataIl),
                tempoFrazioneBici:  new Date(gara.disputataIl)
            };
            var frazioniGare = 
                ["tempoDopoNuoto",
                 "tempoFrazioneCorsa",
                 "tempoFrazioneBici"
                ];
                
            
            if(squadra == false){
               
                for(var i = 0; i < frazioniGare.length; i++){
                    var split = risultato[0][frazioniGare[i]].split(":");
                    var hours = split[0];
                    var minutes = split[1];
                    var seconds = split[2];
                    tempiPiuVeloci[frazioniGare[i]].setHours(hours);
                    tempiPiuVeloci[frazioniGare[i]].setMinutes(minutes);
                    tempiPiuVeloci[frazioniGare[i]].setSeconds(seconds);  
                    
                }
                risultato[0].differenzialeNuoto = risultato[0].tempoDopoNuoto;
                risultato[0].differenzialeCorsa = risultato[0].tempoFrazioneCorsa;
                risultato[0].differenzialeBici = risultato[0].tempoFrazioneBici;
                //TODO, NON FA PER ERRORE NELLE API DI FT (NON CONCLUSIONE MA CONLUSIONE)
                console.log(tempiPiuVeloci);
                for(var i = 1; i < risultato.length; i++){
                    for (var j = 0; j < frazioniGare.length; j++){
                        console.log(risultato[i].conlusioneGara);
                            if(risultato[i].conclusioneGara == "COM"){
                                var splitI = risultato[i][frazioniGare[j]].split(":");
                                var hoursI = splitI[0];
                                var minutesI = splitI[1];
                                var secondsI = splitI[2];
                                tempoDaConfrontare[frazioniGare[j]].setHours(hoursI);
                                tempoDaConfrontare[frazioniGare[j]].setMinutes(minutesI);
                                tempoDaConfrontare[frazioniGare[j]].setSeconds(secondsI); 
                            }
                        }
                    if(risultato[i].conclusioneGara != "COM"){
                            risultato[i].differenzialeBici = risultato[i].conclusioneGara ;
                            risultato[i].differenzialeCorsa = risultato[i].conclusioneGara;
                            risultato[i].differenzialeNuoto = risultato[i].conclusioneGara;
                    }else{
                        risultato[i].differenzialeNuoto = 
                                Math.round(((tempoDaConfrontare.tempoDopoNuoto - tempiPiuVeloci.tempoDopoNuoto)/60000)*100)/100;
                        if(risultato[i].differenzialeNuoto > 0){
                            risultato[i].differenzialeNuoto = "+"+risultato[i].differenzialeNuoto;
                        }
                        risultato[i].differenzialeBici  = 
                                Math.round(((tempoDaConfrontare.tempoFrazioneBici - tempiPiuVeloci.tempoFrazioneBici)/60000)*100)/100;
                        if(risultato[i].differenzialeBici > 0){
                            risultato[i].differenzialeBici = "+"+risultato[i].differenzialeBici;
                        }
                        risultato[i].differenzialeCorsa = 
                                Math.round(((tempoDaConfrontare.tempoFrazioneCorsa - tempiPiuVeloci.tempoFrazioneCorsa)/60000)*100)/100;
                        if(risultato[i].differenzialeCorsa > 0){
                            risultato[i].differenzialeCorsa = "+"+risultato[i].differenzialeCorsa;
                        }
                    }
                }
            }    
            else{
                for(var i = 0; i < frazioniGare.length; i++){
                    var split = risultato[0][frazioniGare[i]].split(":");
                    var hours = split[0];
                    var minutes = split[1];
                    var seconds = split[2];
                    tempiPiuVeloci[frazioniGare[i]].setHours(hours);
                    tempiPiuVeloci[frazioniGare[i]].setMinutes(minutes);
                    tempiPiuVeloci[frazioniGare[i]].setSeconds(seconds);  
                    
                }
                risultato[0].differenzialeNuoto = risultato[0].tempoDopoNuoto;
                risultato[0].differenzialeCorsa = risultato[0].tempoFrazioneCorsa;
                risultato[0].differenzialeBici = risultato[0].tempoFrazioneBici;
                
                console.log(tempiPiuVeloci);
                for(var i = 1; i < risultato.length; i++){
                    for (var j = 0; j < frazioniGare.length; j++){
                        if(risultato[i].conclusioneGara == "COM"){
                            var splitI = risultato[i][frazioniGare[j]].split(":");
                            var hoursI = splitI[0];
                            var minutesI = splitI[1];
                            var secondsI = splitI[2];
                            tempoDaConfrontare[frazioniGare[j]].setHours(hoursI);
                            tempoDaConfrontare[frazioniGare[j]].setMinutes(minutesI);
                            tempoDaConfrontare[frazioniGare[j]].setSeconds(secondsI);
                        }
                    }
                    if(risultato[i].conclusioneGara != "COM"){
                        risultato[i].differenzialeBici = risultato[i].conclusioneGara ;
                        risultato[i].differenzialeCorsa = risultato[i].conclusioneGara;
                        risultato[i].differenzialeNuoto = risultato[i].conclusioneGara;
                    }else{
                        risultato[i].differenzialeNuoto = 
                            Math.round(((tempoDaConfrontare.tempoDopoNuoto - tempiPiuVeloci.tempoDopoNuoto)/60000)*100)/100;
                        if(risultato[i].differenzialeNuoto > 0){
                            risultato[i].differenzialeNuoto = "+"+risultato[i].differenzialeNuoto;
                        }
                        risultato[i].differenzialeBici  = 
                                Math.round(((tempoDaConfrontare.tempoFrazioneBici - tempiPiuVeloci.tempoFrazioneBici)/60000)*100)/100;
                        if(risultato[i].differenzialeBici > 0){
                            risultato[i].differenzialeBici = "+"+risultato[i].differenzialeBici;
                        }
                        risultato[i].differenzialeCorsa = 
                                Math.round(((tempoDaConfrontare.tempoFrazioneCorsa - tempiPiuVeloci.tempoFrazioneCorsa)/60000)*100)/100;
                        if(risultato[i].differenzialeCorsa > 0){
                            risultato[i].differenzialeCorsa = "+"+risultato[i].differenzialeCorsa;
                        }
                    }
                }
            }
        }
        return risultato;
    }; 
});


