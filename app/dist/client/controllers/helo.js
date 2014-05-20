"use strict";
app.controller("HeloController", function($scope, webstorage) {
  $scope.helohelomessage = 'hellon!';
  webstorage.bind($scope, 'helohelomessage');
  return $scope.hello = function() {
    return $scope.helohelomessage = 'welcome!';
  };
});
