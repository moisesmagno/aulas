function JogoModel(connection){
	this._connection = connection();
}

JogoModel.prototype.gerarParametros = function(usuario){

	//Abre a conexão com o servidor.
	this._connection.open(function(error, mongoclient){
		//Acessa a collection	
		mongoclient.collection('jogo', function(error, collection){

			var dados = {
				usuario: usuario,
				moeda: 10,
				suditos: 100,
				temor: Math.floor(Math.random() * 1000),
				sabedoria: Math.floor(Math.random() * 1000),
				comercio: Math.floor(Math.random() * 1000),
				magia: Math.floor(Math.random() * 1000)
			}	

			collection.insert(dados);

			//Sempre fechar a conexão.
			mongoclient.close();
		});
	});
}

//Recupera os dados do jogo.
JogoModel.prototype.iniciarJogo = function(res, usuario, casa, comando_invalido){
	this._connection.open(function(error, mongoclient){
		mongoclient.collection('jogo', function(error, collection){
			collection.find({usuario:usuario}).toArray(function(error, result){
				res.render('jogo', {img_casa: casa, jogo: result[0], comando_invalido: comando_invalido});
				mongoclient.close();
			}); 
		});
	});
}

JogoModel.prototype.acao = function(acao){
	this._connection.open(function(error, mongoclient){
		mongoclient.collection('acao', function(error, collection){
			collection.insert(acao);

			mongoclient.close();
		});
	});
}

module.exports =function(){
	return JogoModel;
}
