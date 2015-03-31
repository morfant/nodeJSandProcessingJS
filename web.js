var sys = require("sys");
var fs = require('fs');
var my_http = require("http");
var url = require("url");
var mime = require('mime');

var SerialPort = require("serialport").SerialPort;
var sp = new SerialPort("/dev/ttyAMA0", { baudrate: 115200 });

sp.on("open", function () {
        console.log('serial port open.');
//        sp.on('data', function(data) {
//            console.log('data received: ' + data);
//            });

//        sp.write("abcdefgiy\n", function(err, results) {
 //           console.log('err ' + err);
//            console.log('results ' + results);
//            });
        });

my_http.createServer(function (request, response) {
    var path = url.parse(request.url).pathname;

    if (path == '/') {
        filepath = './index.html';
    } else {
        filepath = "." + path;
    }
    
    var contentType = mime.lookup(filepath);

   fs.readFile(filepath, function (err, html) {
        if (err) {
            response.writeHeader(500);
            response.end();
        }
        response.writeHeader(200, { 'Content-Type': contentType });
        response.end(html, 'utf-8');
    });

}).listen(8080);

console.log("Server Running on 8080");


function updateClick ()
{
        sp.write("abcdefgiy\n", function(err, results) {
                if (err) console.log('err ' + err);
            });
 
}
