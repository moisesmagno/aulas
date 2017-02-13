module.exports = function(app){

	//Rota para as notícias
	app.get('/noticias', function(req, res){

		
		var mysql = require('mysql');

		var connection = mysql.createConnection({
			host: 'localhost',
			user: 'root',
			password: '',
			database: 'portal_noticias'
		});

		connection.query('SELECT * FROM TB_NOTICIAS', function(erro, result){
			res.send(result);
		});

		//res.render('noticias/noticia');
	});
}

