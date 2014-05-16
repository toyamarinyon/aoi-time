"use strict"

app.controller "IndexController", ($scope) ->
  $scope.aoimessage = "おはよう！今日は早いね！！"
  $scope.helloaoi = ->
    $scope.aoimessage = "今日も1日頑張ってね！"
    console.log $scope.aoimessage
