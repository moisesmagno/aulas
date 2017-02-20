module.exports = function(application){
	//Rota para o formulário de inclusão da noticia
	application.get('/formulario-inclusao-noticia', function(req, res){
		application.app.controller.admin.formulario_inclusao_noticia(application, req, res);
	});

	application.post('/noticias/salvar', function(req, res){
		
		application.app.controller.admin.noticia_salvar(application, req, res);
		
	});
}
