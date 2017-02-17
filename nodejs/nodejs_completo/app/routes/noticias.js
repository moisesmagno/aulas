 module.exports = function(app){

	//Rota para as notícias
	app.get('/noticias', function(req, res){

		var connection = app.config.dbConnection(); //Atribui o método de conexão com o banco de dados em uma variável.
		
		var noticiasModel = new app.app.models.NoticiasDAO(connection);

		noticiasModel.getNoticias(function(error, result){
			res.render('noticias/noticias', {noticias: result});
		});
	});
}

