"use strict"

app = angular.module("aoichan", ['ngRoute','ezfb','ngAnimate'])
  .config ($routeProvider, ezfbProvider) ->
    $routeProvider
      .when "/",
        templateUrl: "views/index.html"
        controller : "IndexController"
      .when "/helo",
        templateUrl: "views/helo.html"
        controller : "HeloController"
      .otherwise "/",
        redirectTo: "/"
    ezfbProvider.setInitParams
      appId: '584447998341772'
  .run ($rootScope, $q, ezfb, navigator, webstorage) ->
    $rootScope.run_level = 'bootstrapping'
    $rootScope.auth = false
    is_authentication = ->
      deferred = $q.defer()
      if $rootScope.online
        ezfb.getLoginStatus (res) ->
          if res.status == 'connected'
            $rootScope.auth = true
          deferred.resolve()
      else
        if webstorage.get('auth') == 'connected'
          $rootScope.auth = true
        deferred.resolve()
      deferred.promise

    $q.all([is_authentication()])
      .then (resolves) ->
        $rootScope.run_level = 'run'

