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
	
	//Ouve e 
	socket.on('usuarioOnline', function(data){
		
		//enviar ao browser o apelido do usuário logado, irá aparece somente na lista do usuário q se logou.
		socket.emit('gravaUsuOnline', {apelido: data.apelido})

		//enviar ao browser o apelido do usuário logado, irá aparece na lista de todos os usuário logados.
		socket.broadcast.emit('gravaUsuOnline', {apelido: data.apelido});

	});


	//Ouvindo algum usuário se conectar
	socket.on('disconnect', function(){
		console.log('O usuário se desconectado!');
	});

	//Ouvindo alguma mesnagem de texto e apelido.
	socket.on('msgParaServidor', function(data){
		//Envia as informações para a pessoa que enviou o data(apelido, msgm)
		socket.emit('msgCliente', {
			apelido: data.apelido,
			msg: data.msg
		});

		//Envia a mensagem (apelido, msgm) para todos que estão conectados no socket.
		socket.broadcast.emit('msgCliente', {
			apelido: data.apelido,
			msg: data.msg			
		});
	});

});

