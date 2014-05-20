'use strict'

app.factory 'webstorage', ($window, $parse, $log) ->
  localStorage = $window.localStorage

  webstorageService =

    get: (key) ->
      JSON.parse localStorage.getItem key

    remove: (key) ->
      localStorage.removeItem key

    set: (key, value) ->
      localStorage.setItem key, JSON.stringify value

    bind: ($scope, key, options) ->

      default_options =
        default_value: '',
        object_equality: false

      if not options?
        options = default_options

      if webstorageService.get(key)?
        if options.update_function?
          $scope[key][options.update_function] webstorageService.get key
        else
          $parse(key).assign $scope, webstorageService.get key
      else if options.default_value
        $parse(key).assign $scope, options.default_value

      $scope.$watch key, (value) ->
        webstorageService.set key, value
      ,options.object_equality
