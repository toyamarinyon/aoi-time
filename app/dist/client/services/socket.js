"use strict";
app.factory("socket", function($rootScope) {
  var socket, socketService;
  socket = io.connect();
  return socketService = {
    on: function(eventName, callback) {
      return socket.on(eventName, function() {
        var args;
        args = arguments;
        return $rootScope.$apply(function() {
          return callback.apply(socket, args);
        });
      });
    },
    emmit: function(eventName, data, callback) {
      return socket.emmit(eventName, data, function() {
        var args;
        args = arguments;
        return $rootScope.$apply(function() {
          if (callback) {
            return callback.apply(socket, args);
          }
        });
      });
    }
  };
});
