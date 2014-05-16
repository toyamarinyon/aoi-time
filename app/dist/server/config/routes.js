"use strict";
module.exports = function(app) {
  return app.get("/hello", function(req, res) {
    return res.send("Hello World");
  });
};
