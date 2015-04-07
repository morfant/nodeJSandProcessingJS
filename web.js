var PORT = "/dev/ttyAMA0";
var sys = require("sys");
var fs = require('fs');
var my_http = require("http");
var url = require("url");
var mime = require('mime');
var SerialPort = require("serialport").SerialPort;
var sp = new SerialPort(PORT, { baudrate: 115200 });

var serialOpen = function() {
    sp.on("open", function () {
        console.log("serial port " + PORT + " open.");
        });
};

serialOpen();

my_http.createServer(function (request, response) {
    var path = url.parse(request.url).pathname;

    if (path == '/') {
        filepath = './index.html';
    } else if (path == '/coorval') {
        var data = url.parse(request.url, true).query;
        var buf = new Buffer([Number(data.x) + Number(48), Number(data.y) + Number(48), Number(data.press) + Number(48)]);
//        console.log(data);
//        console.log(buf);
       
        serialSend(buf);
        
        filepath = 'function';

    } else {
        filepath = "." + path;
    }
    
    var contentType = mime.lookup(filepath);

   fs.readFile(filepath, function (err, html) {
       if (filepath != 'function') {
            if (err) {
                response.writeHeader(500);
                response.end();
            }
        }
        response.writeHeader(200, { 'Content-Type': contentType });
        response.end(html, 'utf-8');
    });

}).listen(8080);

console.log("Server Running on 8080");


function serialSend(data)
{
 //   console.log('in sendTest()');
    sp.write(data, function(err, results) {
            if (err) console.log('err ' + err);
        });
}
