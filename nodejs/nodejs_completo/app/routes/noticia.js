module.exports = function(application){

	application.get('/noticia', function(req, res){

		var connection = application.config.dbConnection();

		var noticiaModel = new application.app.models.NoticiasDAO(connection);

		noticiaModel.getNoticia(function(error, result){
			res.render('noticias/noticia', {noticia: result});
		});
	});
}

