var http = require('http');
var url = require('url');

var server = http.createServer(function(req, res) {
  var page = url.parse(req.url).pathname;
  console.log("LOG page : " + page);
  res.writeHead(200);
  res.end('Salut tout le monde !');
});
server.listen(8080);