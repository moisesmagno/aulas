 module.exports = function(application){

	//Rota para as notícias
	application.get('/noticias', function(req, res){

		application.app.controller.noticias.noticias(application, req, res);

	});

	//Rota para notícia
	application.get('/noticia', function(req, res){

		application.app.controller.noticias.noticia(application, req, res);

	});
}

