module.exports = function(application){

	//Rota Noticias
	application.get('/noticias', function(req, res){

		//Chama o controller.
		console.log('Estou na rota noticias.');
	});

	//Rota Noticia
	application.get('/noticia', function(req, res){

		//Chama o controller.
		console.log('Estou na rota noticia.');
	});
}