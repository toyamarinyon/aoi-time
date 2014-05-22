"use strict"

app.controller "HeloController", ($scope, $rootScope, $log, ezfb, webstorage, worked, navigator) ->

  $scope.helohelomessage = 'hellon!'

  $scope.worked = worked

  $scope.working_history = []

  webstorage.bind $scope, 'worked',
    update_function: 'update'
    object_equality: true

  webstorage.bind $scope, 'working_history',
    object_equality: true

  $scope.hello = ->
    $scope.worked.from = new Date('2014-05-20 09:00:00').getTime()

  $scope.bye = ->
    $scope.worked.to = new Date('2014-05-20 19:00:00').getTime()
    $scope.working_history.filter (item, index, array) ->
      array.splice index, 1 if item.date == $scope.worked.date()
    $scope.working_history.push $scope.worked.to_object()

  $scope.facebook_login = ->
    ezfb.login (res) ->
      if res.status == 'connected'
        $scope.auth = true
        webstorage.set 'auth', true
    , {scope: 'email,public_profile'}
