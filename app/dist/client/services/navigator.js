'use strict';
app.factory('navigator', function($window, $rootScope) {
  $rootScope.online = navigator.onLine;
  $window.addEventListener('offline', function() {
    return $rootScope.$apply(function() {
      return $rootScope.online = false;
    });
  }, false);
  return $window.addEventListener('online', function() {
    return $rootScope.$apply(function() {
      return $rootScope.online = true;
    });
  }, false);
});
