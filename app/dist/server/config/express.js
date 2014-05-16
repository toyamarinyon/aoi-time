"use strict";

/*
Module dependencies.
 */
var express, flash, mongoStore;

express = require("express");

mongoStore = require("connect-mongo")(express);

flash = require("connect-flash");

module.exports = function(app, passport, db, config) {
  app.set("showStackError", true);
  app.locals.pretty = true;
  app.use(express.compress({
    filter: function(req, res) {
      return /json|text|javascript|css|html/.test(res.getHeader("Content-Type"));
    },
    level: 9
  }));
  if (process.env.NODE_ENV === "development") {
    app.use(express.logger("dev"));
  }
  return app.configure(function() {
    app.use(express.cookieParser());
    app.use(express.urlencoded());
    app.use(express.json());
    app.use(express.methodOverride());
    app.use(express.session({
      secret: config.sessionSecret,
      store: new mongoStore({
        db: db.connection.db,
        collection: config.sessionCollection
      })
    }));
    app.use(passport.initialize());
    app.use(passport.session());
    app.use(flash());
    app.use(app.router);
    app.use(express.favicon());
    app.use(express["static"](config.root + config.clientDirectory));
    app.use(express["static"](config.root + config.vendorAssetsDirectory));

    /*
    Assume "not found" in the error msgs is a 404. this is somewhat
    silly, but valid, you can do whatever you like, set properties,
    use instanceof etc.
     */
    app.use(function(err, req, res, next) {
      if (~err.message.indexOf("not found")) {
        return next;
      }
      console.error(err.stack);
      res.status(500);
      res.send("500");
      return console.log(err.stack);
    });
    return app.use(function(req, res, next) {
      res.status(404);
      res.send("404");
      return console.log({
        url: req.originalUrl,
        error: "Not found"
      });
    });
  });
};
