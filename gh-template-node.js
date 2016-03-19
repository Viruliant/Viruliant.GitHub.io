//you may have to install nodejs & run 'npm install http-server --save-dev' to get this to run
var	httpServer = require('http-server');

var server = httpServer.createServer({});
server.listen(1337);

//var http = require('http');
//http.createServer(function (request, response) {
//	response.writeHead(200, {'Content-Type': 'text/plain'});
//	response.end('Hello World\n');
//}).listen(1337, '127.0.0.1');
//console.log('Server running at http://127.0.0.1:1337/');

