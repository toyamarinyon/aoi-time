"use strict"

app.factory "socket", ($rootScope) ->
  socket = io.connect()
  socketService =
    on: (eventName, callback) ->
      socket.on eventName, ->
        args = arguments
        $rootScope.$apply ->
          callback.apply(socket, args)
    emmit: (eventName, data, callback) ->
      socket.emmit eventName, data,  ->
        args = arguments
        $rootScope.$apply ->
          callback.apply(socket, args) if callback
