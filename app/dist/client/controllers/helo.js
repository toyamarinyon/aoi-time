"use strict";
app.controller("HeloController", function($scope, $log, webstorage, worked) {
  $scope.helohelomessage = 'hellon!';
  $scope.worked = worked;
  $scope.working_history = [];
  webstorage.bind($scope, 'worked', {
    update_function: 'update',
    object_equality: true
  });
  webstorage.bind($scope, 'working_history', {
    object_equality: true
  });
  $scope.hello = function() {
    return $scope.worked.from = new Date('2014-05-20 09:00:00').getTime();
  };
  return $scope.bye = function() {
    $scope.worked.to = new Date('2014-05-20 19:00:00').getTime();
    $scope.working_history.filter(function(item, index, array) {
      if (item.date === $scope.worked.date()) {
        return array.splice(index, 1);
      }
    });
    return $scope.working_history.push($scope.worked.to_object());
  };
});
