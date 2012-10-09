//==============================================================================
var http = require('http'),
    fileSystem = require('fs'),
    path = require('path'),
    util = require('util');

var collectd_path = "collectd_scripts";
var collect_vm_stats_path = path.join(collectd_path, "collect_vm_stats.py")
//------------------------------------------------------------------------------
function serveFile(filepath, req, res) {
    
    var stat = fileSystem.statSync(filepath);
    console.log("length: " + stat.size);
    
    res.writeHead(200, {
        'Content-Type' : 'application/x-tar',
        'Content-Length' : stat.size,
    });

    var readStream = fileSystem.createReadStream(filepath);
    util.pump(readStream, res);
}
//------------------------------------------------------------------------------
function generateGraphs(instance_name, req, res) {
    var exec = require('child_process').exec;
    var cmd = collect_vm_stats_path + " " + instance_name;
    
    exec(cmd, function (error, stdout, stderr) {
        filepath = stdout.replace("\n", "");
        console.log('\nfilepath: %s', filepath);
        if (stderr == "") {
            serveFile(filepath, req, res);
        }
        else {
            console.log("stderr: %s", stderr)
            res.status(404);
            res.end();
        }
    });
}
//------------------------------------------------------------------------------
exports.findByName = function(req, res) {
    var instance_name = req.params.name
    generateGraphs(instance_name, req, res);
};
//==============================================================================
