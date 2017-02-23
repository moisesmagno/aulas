//Controla a exibição do formulário de inclusão de uma nova notícia.
module.exports.formularioInclusaoNoticia = function(application, req, res){
	res.render('admin/formulario-inclusao-noticia', {validacao: {}, noticia: {}});
}

//Controla o registro de uma nova notícia.
module.exports.salvarNoticia = function(application, req, res){
	//Pegando todos os dados submetidos via post.
	var dadosNoticia = req.body;

	//Validando os campos com express-validator.
	req.assert('titulo', 'O campo titulo é obrigatório!').notEmpty();
	req.assert('resumo', 'O campo resumo é obrigatório!').notEmpty();
	req.assert('resumo', 'O resumo tem que ter entre 10 e 100 caracteres!').len(10,100);
	req.assert('autor', 'O campo autor é obrigatório!').notEmpty();
	req.assert('data_noticia', 'A data é obrigatória!').notEmpty();
	req.assert('data_noticia', 'O formato da data está incorreto!').isDate({formato: 'YYYY-MM-DD'});
	req.assert('noticia', 'O campo notícia é obrigatório!').notEmpty();

	var erros = req.validationErrors();

	if(erros){
		 res.render('admin/formulario-inclusao-noticia', {validacao: erros, noticia: dadosNoticia});
	}

	var connection = application.config.dbConnection(); //Chama a conexão com o banco de dados.
	var noticiasModel = new application.app.models.noticiasModel(connection); //Chama o model noticiaModel e envia a conexão com o banco para o model.

	noticiasModel.salvaNoticia(dadosNoticia, function(error, result){

		if(result.affectedRows == 1){
			res.redirect('/noticias');
		}else{
			console.log('Ocorreu um erro ao gravar a notícia no banco.');
		}
		
	});
}