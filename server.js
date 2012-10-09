//==============================================================================
var express = require('express'),
    instances = require('./routes/instances');

var app = express();

app.get('/instances/:name.tar.gz', instances.findByName);

app.listen(1337);
console.log("Listening on port 1337...");
//==============================================================================
