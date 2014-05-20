"use strict"

app.controller "HeloController", ($scope, $log, webstorage, worked) ->

  $scope.helohelomessage = 'hellon!'

  $scope.worked = worked

  $scope.working_history = []

  webstorage.bind $scope, 'worked',
    update_function: 'update'
    object_equality: true

  webstorage.bind $scope, 'working_history',
    object_equality: true

  $scope.hello = ->
    $scope.worked.from = new Date('2014-05-20 08:54:11').getTime()

  $scope.bye = ->
    $scope.worked.to = new Date('2014-05-20 20:54:11').getTime()
    $scope.working_history.push $scope.worked.to_obj
