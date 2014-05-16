"use strict";

/*
Module dependencies.
 */
var FacebookStrategy, LocalStrategy, User, mongoose;

mongoose = require("mongoose");

LocalStrategy = require("passport-local").Strategy;

FacebookStrategy = require("passport-facebook").Strategy;

User = mongoose.model("User");

module.exports = function(passport, config) {
  passport.serializeUser(function(user, done) {
    return done(null, user.id);
  });
  passport.deserializeUser(function(id, done) {
    return User.findOne({
      _id: id
    }, "-salt -hashed_password", function(err, user) {
      return done(err, user);
    });
  });
  return passport.use(new FacebookStrategy({
    clientID: config.facebook.clientID,
    clientSecret: config.facebook.clientSecret,
    callbackURL: "http://" + config.hostname + "/auth/facebook/callback"
  }, function(accessToken, refreshToken, profile, done) {
    return User.findOne({
      "facebook.id": profile.id
    }, function(err, user) {
      if (err) {
        return done(err);
      }
      if (!user) {
        user = new User({
          name: profile.displayName,
          provider: "facebook",
          facebook: profile._json
        });
        return user.save(function(err) {
          if (err) {
            console.log(err);
          }
          return done(err, user);
        });
      } else {
        return done(err, user);
      }
    });
  }));
};
