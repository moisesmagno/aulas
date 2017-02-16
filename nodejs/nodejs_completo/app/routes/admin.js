module.exports = function(app){
	//Rota para o formulário de inclusão da noticia
	app.get('/formulario-inclusao-noticia', function(req, res){
		res.render('admin/form_add_noticia');
	});

	app.post('/noticias/salvar', function(req, res){
		
		var noticia = req.body;

		var connection = app.config.dbConnection(); //Chama a conexão com o banco.
		var noticiaModel = app.app.models.noticiasModel; //Chama o model noticiaModel.

		//Envia a conexão, os dados inputados do formulário e o callback para o método salvarNoticia() no model noticiaModel.
		noticiaModel.salvarNoticia(noticia, connection, function(error, result){
			res.redirect('/noticias');
		});
		
	});
}
