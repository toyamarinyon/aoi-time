'use strict'

app.factory 'webstorage', ($window) ->
  localStorage = $window.localStorage
  webstorageService =
    get: (key) ->
      localStorage.getItem key
    remove: (key) ->
      localStorage.removeItem key
    set: (key, value) ->
      localStorage.setItem key, value
    bind: ($scope, key) ->
      $scope.$watch key, (val) ->
        webstorageService.set key,val
