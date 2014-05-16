"use strict"

module.exports = (app) ->

  # root
  app.get "/hello", (req, res) ->
    res.send "Hello World"
