module.exports.iniciarChat = function(application, req, res){
	
	var dadosForm = req.body;

	req.assert('apelido', 'O nome ou aplido é obrigatório!').notEmpty();
	req.assert('apelido', 'O nome ou apelido tem que term entre 3 ou 10 caracteres!').len(3, 10);

	var erros = req.validationErrors();

	if(erros){
		res.render('index', {validacao: erros});
		return;
	}

	res.render('chat');
}