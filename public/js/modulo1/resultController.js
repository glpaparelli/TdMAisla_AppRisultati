
/* global angular, vm */
angular.module("testFilter")
.constant("gara","http://localhost/app-risultati/rest-api/Gara")
    .constant("risultato", "http://localhost/app-risultati/rest-api/Risultati?idGara=")

.controller("resultsController",["$location","$http","gara","risultato", function ($location,$http,gara, risultato){
        var vm = this;
        vm.garaSelezionata = {};
        //TODO: gestire errori delle richieste in get al server
        $http.get(gara)
            .success(function (gare){
                vm.gare = gare;
            }).error(function (data){
                
                console.log("ERROR");
            });
        
        vm.selezionaGara = function (ris){
            for(var i = 0; i < vm.gare.length; i++){
                if(ris == vm.gare[i].nome){
                    $http.get(risultato + vm.gare[i].id)
                        .success(function (risultato){
                            if(risultato[i].squadra != null){
                                for(var j = 0; j<risultato[i].squadra.componenti[j];j++ ){
                                    risultato[i].squadra.componenti[j].selezionato = false;
                                 }
                                vm.squadra = true;
                            }else{
                                risultato[i].atleta.selezionato = false;
                                vm.squadra = false;
                            }    
                            vm.garaSelezionata = risultato;
                        })
                        .error(function (data){
                            //TODO
                        });   
                }
            }
        };
        
        vm.selezionaSesso = function (ris){
            vm.sessoSelezionato = ris;
        };
        vm.selezionaCategoria = function (ris){
            vm.categoriaSelezionata = ris;
        };
        vm.filtroRicerca = function (stringaParametro){
            vm.stringaDaRicercare = stringaParametro;
        };
        
}]);
