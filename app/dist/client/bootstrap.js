"use strict";
var app;

app = angular.module("aoichan", ['ngRoute']).config(function($routeProvider) {
  return $routeProvider.when("/", {
    templateUrl: "views/index.html",
    controller: "IndexController"
  }).otherwise("/", {
    redirectTo: "/"
  });
});
