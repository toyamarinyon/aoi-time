'use strict';
app.factory('webstorage', function($window) {
  var localStorage, webstorageService;
  localStorage = $window.localStorage;
  return webstorageService = {
    get: function(key) {
      return localStorage.getItem(key);
    },
    remove: function(key) {
      return localStorage.removeItem(key);
    },
    set: function(key, value) {
      return localStorage.setItem(key, value);
    },
    bind: function($scope, key) {
      return $scope.$watch(key, function(val) {
        return webstorageService.set(key, val);
      });
    }
  };
});
