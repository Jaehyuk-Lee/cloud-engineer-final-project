//nodejs_test.js
var http = require('http');
var content = function(req, res){
  res.writeHead(200);
  res.end("Welcome to JingO's Devlog!" + "\n");
}
var server = http.createServer(content);
server.listen(8000);
