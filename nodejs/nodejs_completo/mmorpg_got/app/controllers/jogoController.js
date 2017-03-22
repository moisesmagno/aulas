module.exports.jogo = function(application, req, res){
	if(req.session.autorizado !== true){
		res.send('vc precisa se logar!');
		return;
	}

	var comando_invalido = "N";
	if(req.query.comando_invalido == 'S'){
		comando_invalido = 'S';
	}

	var usuario = req.session.usuario;
	var casa = req.session.casa;
	
	var connection = application.config.dbConnection;
	var jogoModel = new application.app.models.JogoModel(connection);

	jogoModel.iniciarJogo(res, usuario, casa, comando_invalido);

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
		res.redirect('jogo?comando_invalido=S');
		return;
	}

	var connection = application.config.dbConnection;
	var jogoModel = new application.app.models.JogoModel(connection);

	dadosform.usuario = req.session.usuario;

	jogoModel.acao(dadosForm);

}