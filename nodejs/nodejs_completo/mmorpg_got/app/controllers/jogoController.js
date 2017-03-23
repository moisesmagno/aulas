module.exports.jogo = function(application, req, res){
	if(req.session.autorizado !== true){
		res.send('vc precisa se logar!');
		return;
	}

	var msg = "";
	if(req.query.msg != ''){
		msg = req.query.msg;
	}

	var usuario = req.session.usuario;
	var casa = req.session.casa;
	
	var connection = application.config.dbConnection;
	var jogoModel = new application.app.models.JogoModel(connection);

	jogoModel.iniciarJogo(res, usuario, casa, msg);

}

module.exports.sair = function(application, req, res){
	req.session.destroy(function(error){
		res.render('index', {validacao: {}});
	});
}

module.exports.suditos = function(application, req, res){
	
	if(req.session.autorizado !== true){
		res.send('Vc prescisa se logar!');
		return;
	}

	res.render('aldeoes', {validacao: {}});
}

module.exports.pergaminhos = function(application, req, res){

	if(req.session.autorizado !== true){
		res.send('Vc prescisa se logar!');
		return;
	}

	/* Recupera as ações inseirdas no banco de dados */
	var connection = application.config.dbConnection;
	var jogoModel = new application.app.models.JogoModel(connection);

	var usuario = req.session.usuario;

	jogoModel.getAcoes(usuario);

	res.render('pergaminhos', {validacao: {}});
}

module.exports.ordenar_acao_sudito = function(application, req, res){

	if(req.session.autorizado !== true){
		res.send('Vc prescisa se logar!');
		return;
	}

	var dadosForm = req.body;

	req.assert('acao', 'O campo ação é obrigatório').notEmpty();
	req.assert('quantidade', 'O campo quantidade é obrigatório').notEmpty();

	var erros = req.validationErrors();

	if(erros){
		res.redirect('jogo?msg=A');
		return;
	}

	var connection = application.config.dbConnection;
	var jogoModel = new application.app.models.JogoModel(connection);

	dadosForm.usuario = req.session.usuario;

	jogoModel.acao(dadosForm);

	res.redirect('jogo?msg=B');
}