module.exports.noticias = function(application, req, res){

	var connection = application.config.dbConnection();
	var noticiasModel = new application.app.models.noticiasModel(connection);

	noticiasModel.recuperarNoticias(function(error, result){
		res.render('noticias/noticias', {noticias: result});
	});
}

module.exports.noticia = function(application, req, res){

	var connection = application.config.dbConnection();
	var noticiaModel = new application.app.models.noticiasModel(connection);

	var idNoticia = req.query.id_noticias;

	noticiaModel.recuperarNoticia(idNoticia, function(error, result){
		res.render('noticias/noticia', {noticia: result});
	});

}