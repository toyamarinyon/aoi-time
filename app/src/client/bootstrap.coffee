"use strict"

app = angular.module("aoichan", ['ngRoute'])
  .config ($routeProvider) ->
    $routeProvider
      .when "/",
        templateUrl: "views/index.html"
        controller : "IndexController"
      .when "/helo",
        templateUrl: "views/helo.html"
        controller : "HeloController"
      .otherwise "/",
        redirectTo: "/"
