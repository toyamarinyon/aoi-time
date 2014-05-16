"use strict"

###
Module dependencies.
###

express    = require("express")
mongoStore = require("connect-mongo")(express)
flash      = require("connect-flash")

module.exports = (app, passport, db, config) ->
  app.set "showStackError", true

  # Prettify HTML
  app.locals.pretty = true

  # Should be placed before express.static
  # To ensure that all assets and data are compressed (utilize bandwidth)
  app.use express.compress
    filter: (req, res) ->
      /json|text|javascript|css|html/.test res.getHeader "Content-Type"

    # Levels are specified in a range of 0 to 9, where-as 0 is
    # no compression and 9 is best compression, but slowest
    level: 9

  # Only use logger for development enviroment
  app.use express.logger "dev" if process.env.NODE_ENV is "development"

  app.configure ->
    # The cookieParser should be above session
    app.use express.cookieParser()

    # Request body paring middleware should be above methodOverride
    app.use express.urlencoded()
    app.use express.json()
    app.use express.methodOverride()

    # Express/Mongo session storage
    app.use express.session
      secret: config.sessionSecret
      store: new mongoStore
        db: db.connection.db
        collection: config.sessionCollection

    # Use passport session
    app.use passport.initialize()
    app.use passport.session()

    # Connect flash for flash messages
    app.use flash()

    # Routes should be at the last
    app.use app.router

    # Setting the fav icon and static folder
    app.use express.favicon()
    app.use express.static(config.root + config.clientDirectory)
    app.use express.static(config.root + config.vendorAssetsDirectory)

    ###
    Assume "not found" in the error msgs is a 404. this is somewhat
    silly, but valid, you can do whatever you like, set properties,
    use instanceof etc.
    ###
    app.use (err, req, res, next) ->
      # Treat as 404
      return next if ~err.message.indexOf "not found"

      # Log it
      console.error err.stack

      # Error page
      res.status 500
      res.send "500"
      console.log err.stack

    # Assume 404 since no middleware responded
    app.use (req, res, next) ->
      res.status 404
      res.send "404"
      console.log
        url: req.originalUrl
        error: "Not found"
