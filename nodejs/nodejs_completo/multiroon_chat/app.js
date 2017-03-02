//Importar as configurações do servidor
var app = require('./config/server');

//Parametrizar a porta de escuta
var server = app.listen(8080,function(){
	console.log('Servidor online :)');
});

//Fala para o socket.io ouvir pela porta 8080 tmb.
var io = require('socket.io').listen(server);

app.set('io', io);

//Cria conexão via websocket
io.on('connection', function(socket){
	console.log('O usuário se conectou!');

	socket.on('disconnect', function(){
		console.log('O usuário se desconectado!');
	});
});

