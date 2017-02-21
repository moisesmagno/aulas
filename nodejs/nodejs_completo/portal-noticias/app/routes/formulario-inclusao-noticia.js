module.exports = function(application){
	
	//Rota que direciona ao formulário de notícias
	application.get('/formulario-inclusao-noticia', function(req, res){
		//Envia informações para o controller
		application.app.controllers.adminController.formularioInclusaoNoticia(application, req, res);
	});

	//Rota que salva os dados da notícia
	application.post('/salvar-noticia', function(req, res){
		//Envia informações para o controller
		application.app.controllers.adminController.salvarNoticia(application, req, res);
	});

}
