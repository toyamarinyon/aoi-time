"use strict";
var app;

app = angular.module("aoichan", ['ngRoute']).config(function($routeProvider) {
  return $routeProvider.when("/", {
    templateUrl: "views/index.html",
    controller: "IndexController"
  }).when("/helo", {
    templateUrl: "views/helo.html",
    controller: "HeloController"
  }).otherwise("/", {
    redirectTo: "/"
  });
});
