"use strict";
module.exports = function(socket) {
  socket.emmit("init", {
    message: "init",
    users: ['taro', 'jiro', 'saburo']
  });
  return socket.on("awesome:handler", function(data) {
    return console.log("on awesome handling!");
  });
};
