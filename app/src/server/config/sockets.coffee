"use strict"

module.exports = (socket) ->

  socket.emmit "init",
    message: "init"
    users: ['taro','jiro','saburo']

  socket.on "awesome:handler", (data) ->
    console.log "on awesome handling!"
