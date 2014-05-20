"use strict"

app.controller "HeloController", ($scope, webstorage) ->

  $scope.helohelomessage = 'hellon!'

  webstorage.bind $scope, 'helohelomessage'

  $scope.hello = ->
    $scope.helohelomessage = 'welcome!'
