function JogoModel(connection){
	this._connection = connection();
}

JogoModel.prototype.gerarParametros = function(usuario){
	//Abre a conexão com o servidor.
	this._connection.open(function(error, mongoclient){
		//Acessa a collection	
		mongoclient.collection('jogo', function(error, collection){
			collection.insert({
				usuario: usuario,
				moeda: 10,
				suditos: 100,
				temor: Math.floor(Math.randon() * 1000),
				sabedoria: Math.floor(Math.randon() * 1000),
				comercio: Math.floor(Math.randon() * 1000),
				magia: Math.floor(Math.randon() * 1000)
			});

			//Sempre fechar a conexão.
			mongoclient.close();
		});
	});
}


module.exports =function(){
	return JogoModel;
}
