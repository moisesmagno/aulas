module.exports.index = function(application, req, res){
	res.render('index', {validacao: {}});
}

module.exports.autenticar = function(application, req, res){

	var dadosForm = req.body;

	req.assert('usuario', 'Informar o usuário é obrigatório!').notEmpty();
	req.assert('senha', 'A senha é obrigatório!').notEmpty();

	var erros = req.validationErrors();

	if(erros){
		res.render('index', {validacao: erros, dadosForm: dadosForm});
		return;
	}

	var connection = application.config.dbConnection;
	var usuarioModel = new application.app.models.UsuariosModel(connection);

	usuarioModel.autenticar(dadosForm, req, res);

}