module.exports = function(app){
	//Rota para o formulário de inclusão da noticia
	app.get('/formulario-inclusao-noticia', function(req, res){
		res.render('admin/form_add_noticia');
	});
}
