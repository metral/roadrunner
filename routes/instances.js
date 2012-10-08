var http = require('http'),
    fileSystem = require('fs'),
    path = require('path'),
    util = require('util');

var collectd_path = "/root/collectd/scripts";
var output_path = collectd_path + "/output/";

function serveFile(filename, req, res) {
    
    var filepath = path.join(output_path, filename);
    console.log("filepath: " + filepath);
    var stat = fileSystem.statSync(filepath);
    console.log("length: " + stat.size);
    
    res.writeHead(200, {
        'Content-Type' : 'application/x-tar',
        'Content-Length' : stat.size,
    });

    var readStream = fileSystem.createReadStream(filepath);
    util.pump(readStream, res);
}

function generateGraphs(instance_name, req, res) {
    var exec = require('child_process').exec;
    var cmd = collectd_path + "/collect_vm_stats.py " + instance_name;

    exec(cmd, function (error, stdout, stderr) {
        filename = stdout.replace("\n", "");
        console.log('filename: %s', filename);
        if (stderr == "") {
            serveFile(filename, req, res);
        }
        else {
            console.log("stderr: %s", stderr)
            res.status(404);
            res.end();
        }
    
    });
}

exports.findByName = function(req, res) {
    var instance_name = req.params.name
    generateGraphs(instance_name, req, res);
};

//exports.findAll = function(req, res) {
//    res.send("foo");
//    //res.send([{name:'foo1'}, {name:'foo2'}, {name:'foo3'}]);
//};
