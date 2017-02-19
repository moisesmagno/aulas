module.exports.formulario_inclusao_noticia = function(application, req, res){
	res.render('admin/form_add_noticia', {validacao: {}, noticia: {}});
}

module.exports.noticia_salvar = function(application, req, res){
	var noticia = req.body;

	//Validando os campos.
	req.assert('titulo', 'Título é obrigatório!').notEmpty();
	req.assert('resumo', 'Resumo é obrigatório!').notEmpty();
	req.assert('resumo', 'O resumo deve contere entre 10 e 100 caracteres').len(10,100);
	req.assert('autor', 'O autor é obrigatório!').notEmpty();
	req.assert('data_noticia', 'A data é obrigatório!').notEmpty();
	req.assert('data_noticia', 'O formato da data está errada!' ).isDate({format: 'YYY-MM-DD'});
	req.assert('noticia', 'O campo notícia é obrigatório!').notEmpty();

	var erros = req.validationErrors();

	if(erros){
		res.render('admin/form_add_noticia', {validacao: erros, noticia: noticia});
		return;
	}


	var connection = application.config.dbConnection(); //Chama a conexão com o banco.
	var noticiaModel = new application.app.models.NoticiasDAO(connection); //Chama o model noticiaModel.

	//Envia a conexão, os dados inputados do formulário e o callback para o método salvarNoticia() no model noticiaModel.
	noticiaModel.salvarNoticia(noticia, function(error, result){
		res.redirect('/noticias');
	});
}