var http = require('http');

var server = http.createServer(function(req, res){
	
	var url = req.url;
	console.log(url);


	if(url == '/tecnologia'){
		res.end('URL de tecnologia!');
	} else if (url == '/culinaria'){
		res.end('URL de Culinária!');
	} else if (url == '/beleza'){
		res.end('URL de Beleza!');
	} else {
		res.end('Portal de urls');
	}
});

server.listen(8000);