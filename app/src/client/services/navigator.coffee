'use strict'

app.factory 'navigator', ($window, $rootScope) ->
  $rootScope.online = navigator.onLine
  $window.addEventListener 'offline', ->
    $rootScope.$apply ->
      $rootScope.online = false
  ,false
  $window.addEventListener 'online', ->
    $rootScope.$apply ->
      $rootScope.online = true
  ,false
