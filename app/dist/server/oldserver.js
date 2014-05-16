
/*
Module dependencies.
 */
var app, config, db, exports, express, io, mongoose, port, server, socketRoutes;

express = require("express");


/*
Main application entry file.
Please note that the order of loading is important.
 */

process.env.NODE_ENV = process.env.NODE_ENV || "development";

config = require("./config/common");

mongoose = require("mongoose");

console.log(config.db);

db = mongoose.connect(config.db);

require("./models/user");

require("./config/passport")(passport, config);

app = express();

require("./config/express")(app, passport, db, config);

require("./config/routes")(app);

server = require("http").createServer(app);

io = require("socket.io").listen(server);

port = process.env.PORT || config.port;

server.listen(port);

console.log("Express app started on port " + port);

socketRoutes = require("./config/sockets");

io.sockets.on("connection", socketRoutes);

logger.init(app, passport, mongoose);

exports = module.exports = server;
