
/* global angular, vm */
angular.module("testFilter")
.constant("gara","http://localhost/app-risultati/rest-api/Gara")
    .constant("risultato", "http://localhost/app-risultati/rest-api/Risultati?idGara=")

.controller("resultsController",["$location","$http","gara","risultato", function ($location,$http,gara, risultato){
        var vm = this;
        vm.garaSelezionata = {};
        vm.atletiSelezionati = [];
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
                                vm.squadra = true;
                            }else{
                                vm.squadra = false;
                            }    
                            vm.garaSelezionata = risultato;
                            if(vm.squadra == false){
                                for(var j=0; j<vm.garaSelezionata.length;j++){
                                    vm.garaSelezionata[j].atleta.selezionato = false;
                                }
                                
                            }
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
        vm.mostraSelezionati = function (visualizzaSelezionati){
            console.log("nella funzione");
            console.log("var nel vm");
            console.log(visualizzaSelezionati)
            if(visualizzaSelezionati != true && visualizzaSelezionati != false){
                vm.visualizzaSelezionati = true;
                
            }else if(visualizzaSelezionati == true){
                vm.visualizzaSelezionati = true;
            }else{
                vm.visualizzaSelezionati = false;
            }
            
            console.log("VisualizzaSelezionati");
            console.log(vm.visualizzaSelezionati);
                
        };
        vm.seleziona = function (ris){
            if(ris.atleta.selezionato == false){
                ris.atleta.selezionato = true;
                vm.isSelected = true;
            }else{
                ris.atleta.selezionato = false;
                vm.isSelected = false;

            }
                
        };
        
}]);
