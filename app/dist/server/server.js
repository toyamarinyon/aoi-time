'use strict';

/*
Module dependencies.
 */
var app, application_root, express;

express = require('express');

app = express();

application_root = require('path').normalize("" + __dirname + "/../../");

app.use(express["static"](application_root + '/dist/client'));

app.use(express["static"](application_root + '/vendor/assets'));

app.listen(3000);
