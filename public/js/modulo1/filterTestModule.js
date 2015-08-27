
/* global angular */
angular.module("testFilter", ["ngRoute"])
.config(["$routeProvider", function($routeProvider){
     $routeProvider.otherwise({
        templateUrl: "result.html"
    });       
}]);
    

