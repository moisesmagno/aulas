function UsuariosModel(connection){
	this._connection = connection();
}

UsuariosModel.prototype.inserirUsusario = function(usuario){
	//Abre a conexão com o servidor.
	this._connection.open(function(error, mongoclient){
		//Acessa a collection	
		mongoclient.collection('usuario', function(error, collection){
			collection.insert(usuario);

			//Sempre fechar a conexão.
			mongoclient.save();
		});
	});
}

UsuariosModel.prototype.autenticar = function(usuario, req, res){
	this._connection.open(function(error, mongoclient){
		mongoclient.collection('usuario', function(error, collection){
			// collection.find(usuario: {$eq: usuario.usuario}, senha: {$eq: usuario.senha}).toArray(...);

			// usuario  = {nome: 'Moisés', senha: '123'}
			collection.find(usuario).toArray(function(error, result){

				if(result[0] != undefined){
					req.session.autorizado = true;
					req.session.usuario = result[0].usuario;
					req.session.casa = result[0].casa;
				}

				if(req.session.autorizado){
					res.redirect('jogo');
				}{
					res.render('index', {validacao: {}});
				}

			}); 
		});
	});
}

module.exports = function(){
	return UsuariosModel;
}