"use strict"

###
Module dependencies.
###
mongoose = require("mongoose")
Schema = mongoose.Schema

###
User Schema
###
UserSchema = new Schema(
  name:
    type: String
    unique: true
    index: true

  provider: String
  facebook: {}
  twitter: {}
  github: {}
  google: {}
  guest: {}
  created_at: Date
)

###
Pre-save hook
###
UserSchema.pre "save", (next) ->
  return next()  unless @isNew
  @created_at = new Date()
  next()
  return

mongoose.model "User", UserSchema
