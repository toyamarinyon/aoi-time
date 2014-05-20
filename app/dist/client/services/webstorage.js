'use strict';
app.factory('webstorage', function($window, $parse, $log) {
  var localStorage, webstorageService;
  localStorage = $window.localStorage;
  return webstorageService = {
    get: function(key) {
      return JSON.parse(localStorage.getItem(key));
    },
    remove: function(key) {
      return localStorage.removeItem(key);
    },
    set: function(key, value) {
      return localStorage.setItem(key, JSON.stringify(value));
    },
    bind: function($scope, key, options) {
      var default_options;
      default_options = {
        default_value: '',
        object_equality: false
      };
      if (options == null) {
        options = default_options;
      }
      if (webstorageService.get(key) != null) {
        if (options.update_function != null) {
          $scope[key][options.update_function](webstorageService.get(key));
        } else {
          $parse(key).assign($scope, webstorageService.get(key));
        }
      } else if (options.default_value) {
        $parse(key).assign($scope, options.default_value);
      }
      return $scope.$watch(key, function(value) {
        return webstorageService.set(key, value);
      }, options.object_equality);
    }
  };
});
