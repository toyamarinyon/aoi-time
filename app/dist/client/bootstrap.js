"use strict";
var app;

app = angular.module("aoichan", ['ngRoute', 'ezfb', 'ngAnimate']).config(function($routeProvider, ezfbProvider) {
  $routeProvider.when("/", {
    templateUrl: "views/index.html",
    controller: "IndexController"
  }).when("/helo", {
    templateUrl: "views/helo.html",
    controller: "HeloController"
  }).otherwise("/", {
    redirectTo: "/"
  });
  return ezfbProvider.setInitParams({
    appId: '584447998341772'
  });
}).run(function($rootScope, $q, ezfb, navigator, webstorage) {
  var is_authentication;
  $rootScope.run_level = 'bootstrapping';
  $rootScope.auth = false;
  is_authentication = function() {
    var deferred;
    deferred = $q.defer();
    if ($rootScope.online) {
      ezfb.getLoginStatus(function(res) {
        if (res.status === 'connected') {
          $rootScope.auth = true;
          return deferred.resolve();
        }
      });
    } else {
      if (webstorage.get('auth') === 'connected') {
        $rootScope.auth = true;
        deferred.resolve();
      }
    }
    return deferred.promise;
  };
  return $q.all([is_authentication()]).then(function(resolves) {
    return $rootScope.run_level = 'ready';
  });
});
