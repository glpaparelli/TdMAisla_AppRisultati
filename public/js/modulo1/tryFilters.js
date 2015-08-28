
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
            for(var i = 0; i <risultato.length; i++){
                if(sessoSelezionato == risultato[i].atleta.sesso)
                    filtratoPerSesso.push(risultato[i]);
            }
            return filtratoPerSesso;
        }else
            return risultato ;
    };
})
.filter("filtroCategoria", function (){
    return function (risultato, categoriaSelezionata){
        for (var i = 0; i<risultato.length; i++){
            if(risultato[i].squadra != null){
                categoriaSelezionata = null
            };
        }
        if(angular.isArray(risultato) && categoriaSelezionata != null){
            var filtratoPerCategoria = [];            
            for(var i = 0; i <risultato.length; i++){
                if(categoriaSelezionata == risultato[i].atleta.categoriaFitri){
                    filtratoPerCategoria.push(risultato[i]);
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
                    console.log(risultato[i].atleta.selezionato);
                    var nome = angular.uppercase(risultato[i].atleta.nome);
                    var cognome = angular.uppercase(risultato[i].atleta.cognome);
                    if(risultato[i].atleta.societa == null){
                         if(nome.includes(stringaDiRicerca) || cognome.includes(stringaDiRicerca)){
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
            console.log("nel filtro");
            var atletiSelezionati = [];
            if(risultato.squadra == null){
                for (var i = 0; i<risultato.length; i++){
                    if(risultato[i].atleta.selezionato == true){
                        atletiSelezionati.push(risultato[i]);
                    }
                }
            }
            if(atletiSelezionati.length == 0){
                atletiSelezionati = risultato;
            }
            return atletiSelezionati;
         
        }else 
            return risultato;
        
    };
});


