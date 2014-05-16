"use strict";
var enviroment;

enviroment = require("" + __dirname + "/env/" + process.env.NODE_ENV);

module.exports = {
  root: require("path").normalize("" + __dirname + "/../../.."),
  port: process.env.PORT || 3000,
  hostname: enviroment.hostname,
  db: enviroment.db,
  clientDirectory: "/dist/client",
  vendorAssetsDirectory: "/vendor/assets",
  facebook: {
    clientID: enviroment.facebookAppID,
    clientSecret: enviroment.facebookSecretKey
  },
  sessionSecret: '8Ahs2j@ja',
  sessionCollection: 'sessions'
};
