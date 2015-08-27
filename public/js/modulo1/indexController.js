
/* global angular */
angular.module("testFilter")
.controller("indexCtrl",["$location", function ($location){
     
    var vm;
    vm = this;            
    
    vm.changeView = function (){
        console.log("ooo");
        $location.path("/results");
    };
                
}]);


