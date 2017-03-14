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

module.exports = function(){
	return UsuariosModel;
}