module.exports.cadastro = function(application, req, res){
	res.render('cadastro', {validacao: {}, dadosForm: {}});
}

module.exports.cadastrar = function(application, req, res){

	var dadosForm = req.body;

	req.assert('nome', 'O campo nome é obrigatório!').notEmpty();
	req.assert('usuario', 'O campo usuario é obrigatório!').notEmpty();
	req.assert('senha', 'O campo senha é obrigatório!').notEmpty();
	req.assert('casa', 'O campo casa é obrigatório!').notEmpty();

	var error = req.validationErrors();

	if(error){
		res.render('cadastro', {validacao: error, dadosForm: dadosForm});
		return
	}

	//Conectando com o banco db.
	var connection = application.config.dbConnection;

	//Instanciando o UsuariosModel
	var usuarioModel = new application.app.models.UsuariosModel(connection);

	usuarioModel.inserirUsusario(dadosForm);

	res.send('Vamos cadastrar!');
}