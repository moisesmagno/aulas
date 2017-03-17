module.exports.jogo = function(application, req, res){
	if(req.session.autorizado){
		res.render('jogo', {img_casa: req.session.casa});
	}else{
		res.send('vc precisa se logar!');
	}
}

module.exports.sair = function(application, req, res){
	req.session.destroy(function(error){
		res.render('index', {validacao: {}});
	});
}