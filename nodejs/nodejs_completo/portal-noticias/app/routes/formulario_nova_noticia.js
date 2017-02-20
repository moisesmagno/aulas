module.exports = function(application){
	application.get('/formulario-nova-noticia', function(req, res){
		//Chama o controller.
		console.log('Estou na rota formulario-nova-noticia');
	});
}