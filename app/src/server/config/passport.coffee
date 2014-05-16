"use strict"

###
Module dependencies.
###

mongoose         = require("mongoose")
LocalStrategy    = require("passport-local").Strategy
FacebookStrategy = require("passport-facebook").Strategy
User             = mongoose.model("User")

module.exports = (passport, config) ->

  # Serialize the user id to push into the session
  passport.serializeUser (user, done) ->
    done(null, user.id)

  # Deserialize the user object based on a pre-serialized token
  passport.deserializeUser (id, done) ->
    User.findOne
      _id: id
    , "-salt -hashed_password"
    , (err, user) ->
      done(err, user)

  # Use facebook strategy
  passport.use new FacebookStrategy
    clientID     : config.facebook.clientID
    clientSecret : config.facebook.clientSecret
    callbackURL  : "http://#{config.hostname}/auth/facebook/callback"
  , (accessToken, refreshToken, profile, done) ->
    User.findOne
      "facebook.id": profile.id
    , (err, user) ->
      return done(err) if err

      if !user
        user = new User
          name: profile.displayName
          provider: "facebook"
          facebook: profile._json

        user.save (err) ->
          console.log(err) if err
          done(err, user)

      else
        done(err, user)
