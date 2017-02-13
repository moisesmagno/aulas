module.exports = function(app){
	//Rota para o index.
	app.get('/', function(req, res){
		res.render('home/index');
	});
}

