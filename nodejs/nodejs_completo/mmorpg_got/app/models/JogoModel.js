//Transforma uma variável com informação em objeto.
var ObjectID = require('mongoDB').ObjectId;

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
JogoModel.prototype.iniciarJogo = function(res, usuario, casa, msg){
	this._connection.open(function(error, mongoclient){
		mongoclient.collection('jogo', function(error, collection){
			collection.find({usuario:usuario}).toArray(function(error, result){
				res.render('jogo', {img_casa: casa, jogo: result[0], msg: msg});
				mongoclient.close();
			}); 
		});
	});
}

JogoModel.prototype.acao = function(acao){
	this._connection.open(function(error, mongoclient){
		mongoclient.collection('acao', function(error, collection){
			
			var date = new Date();

			var tempo = null;

			switch(parseInt(acao.acao)){
				case 1: tempo = 1 * 60 * 60000; break;
				case 2: tempo = 2 * 60 * 60000; break;
				case 3: tempo = 5 * 60 * 60000;	break;
				case 4: tempo = 5 * 60 * 60000; break;
			}

			acao.acao_termina_em = date.getTime() + tempo;

			collection.insert(acao);
		});

		mongoclient.collection('jogo', function(error, collection){

			var moedas = '';
			switch(parseInt(acao.acao)){
				case 1: moedas = -2 * acao.quantidade; break; 
				case 2: moedas = -3 * acao.quantidade; break;
				case 3: moedas = -1 * acao.quantidade; break; 
				case 4: moedas = -1 * acao.quantidade; break;
			}

			collection.update(
				{usuario: acao.usuario},
				{$inc: {moeda: moedas}}
			);

			mongoclient.close();
		});
	});
}

JogoModel.prototype.getAcoes = function(usuario, res){
	this._connection.open(function(erro, mongoclient){	
		mongoclient.collection('acao', function(error, collection){

			var date = new Date();
			var momento_atual = date.getTime();

			collection.find({usuario: usuario, acao_termina_em: {$gt: momento_atual}}).toArray(function(error, result){
				
				res.render('pergaminhos', {acoes: result});

				mongoclient.close();
			});
		});
	});
}

JogoModel.prototype.revogarAcao = function(_id, res){
	this._connection.open(function(error, mongoclient){
		mongoclient.collection('acao', function(error, collection){
			collection.remove(
					{_id: ObjectID(_id)},
					function(error, result){

						res.redirect('jogo?msg=D');
						mongoclient.close();
					}
				);
		});
	});
}

//Exporta o método(classe) jogomodel.
module.exports =function(){
	return JogoModel;
}
