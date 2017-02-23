module.exports = function(application){

	//Rota Noticias
	application.get('/noticias', function(req, res){

		//Chama o controller.
		application.app.controllers.noticiasController.noticias(application, req, res);
	});

	//Rota Noticia
	application.get('/noticia', function(req, res){

		//Chama o controller.
		application.app.controllers.noticiasController.noticia(application, req, res);
	});
}