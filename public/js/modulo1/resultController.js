
/* global angular, vm */
angular.module("testFilter")
.constant("gara","http://localhost/app-risultati/rest-api/Gara")
.constant("risultato", "http://localhost/app-risultati/rest-api/Risultati?idGara=")

.controller("resultsController",["$location","$window","$http","gara","risultato", function ($location,$window,$http,gara, risultato){
        var vm = this;

        vm.reload = function (){
           $window.location.reload();
        };
        vm.risultatoGaraSelezionata = null;
        vm.atletiSelezionati = [];
        //TODO: gestire errori delle richieste in get al server
        $http.get(gara)
            .success(function (gare){
                vm.gare = gare;
            }).error(function (data){ 
                vm.errorResults = true;
            });
        
        vm.selezionaGara = function (ris){
            vm.mostraFiltri = false;
            for(var i = 0; i < vm.gare.length; i++){
                if(ris == vm.gare[i].nome){
                    vm.gara = vm.gare[i];
                    $http.get(risultato + vm.gare[i].id)
                        .success(function (risultato){
                            vm.visualizzaSelezionati = false;
                            vm.tempoDifferenziale = false;
                            vm.categoriaSelezionata = null;
                            vm.sessoSelezionato = null;
                            vm.tuttiSelezionati = false;
                            vm.mostraFiltri = true;
                            vm.stringaDiRicerca = "";
                            if(angular.isDefined(risultato[i].squadra)){
                                vm.squadra = true;
                            }else{
                                vm.squadra = false;
                            }    
                            vm.risultatoGaraSelezionata = risultato;
                            if(vm.squadra == false){
                                for(var j=0; j<vm.risultatoGaraSelezionata.length;j++){
                                    vm.risultatoGaraSelezionata[j].atleta.selezionato = false;
                                }
                            }
                            if(vm.squadra==true){
                                for(var j=0; j<vm.risultatoGaraSelezionata.length;j++){
                                    vm.risultatoGaraSelezionata[j].squadra.selezionato = false;
                                }
                            }
                        })
                        .error(function (data){
                            vm.errorResults = true;
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
        vm.filtroRicerca = function (){
            if(vm.risultatoGaraSelezionata == null){
                vm.stringaDiRicerca = null;
            }
                
            
        };
        vm.mostraSelezionati = function (){
            if(vm.risultatoGaraSelezionata == null){
                vm.visualizzaSelezionati = false;
            }
            if(vm.visualizzaSelezionati == false){
                vm.tempoDifferenziale = false;
            }            
        };
        
        vm.selezionaTutti = function (){
            if(vm.risultatoGaraSelezionata == null){
                vm.tuttiSelezionati = false;
            }else{
            
                if(vm.tuttiSelezionati == true){
                    for (var j = 0; j < vm.risultatoGaraSelezionata.length; j++){
                        if(vm.risultatoGaraSelezionata[j].squadra == null){
                            vm.risultatoGaraSelezionata[j].atleta.selezionato = true;
                            vm.risultatoGaraSelezionata[j].isSelected = true;                            
                        }else{
                            vm.risultatoGaraSelezionata[j].squadra.selezionato = true;
                            vm.risultatoGaraSelezionata[j].isSelected = true;
                        }
                    }
                }else{
                    for (var j = 0; j < vm.risultatoGaraSelezionata.length; j++){
                        if(vm.risultatoGaraSelezionata[j].squadra == null){
                            vm.risultatoGaraSelezionata[j].atleta.selezionato = false;
                            vm.risultatoGaraSelezionata[j].isSelected = false;                            
                        }else{
                            vm.risultatoGaraSelezionata[j].squadra.selezionato = false;
                            vm.risultatoGaraSelezionata[j].isSelected = false;
                        }
                    }
                }
                
            
            }
            
        };
        vm.selezionaAtletaOSquadra = function (ris){
            
            
            if(vm.squadra == false){
                 if(ris.atleta.selezionato == false){
                    ris.atleta.selezionato = true;
                    vm.isSelected = true;
                }else{
                    if(vm.tuttiSelezionati == true){
                        vm.tuttiSelezionati = false;
                    }
                    ris.atleta.selezionato = false;
                    vm.isSelected = false;
                }
            }
            if(vm.squadra == true){
                if(ris.squadra.selezionato == false){
                    ris.squadra.selezionato = true;
                    vm.isSelected = true;
                }else{
                    if(vm.tuttiSelezionati == true){
                        vm.tuttiSelezionati = false;
                    }
                    ris.squadra.selezionato = false;
                    vm.isSelected = false;
                }
            }
        };
        vm.differenziale = function (){
            if(vm.risultatoGaraSelezionata == null){
                vm.tempoDifferenziale = false;
            }
            else{
                if((vm.tempoDifferenziale == true) && (vm.visualizzaSelezionati == false)){
                    vm.tempoDifferenziale = false;
                }   
            }          
        };
}]);
