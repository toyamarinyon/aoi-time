"use strict"

app = angular.module("aoichan", ['ngRoute'])
  .config ($routeProvider) ->
    $routeProvider
      .when "/",
        templateUrl: "views/index.html"
        controller : "IndexController"
      .otherwise "/",
        redirectTo: "/"
