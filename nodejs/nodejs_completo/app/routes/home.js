module.exports = function(application){
	//Rota para o index.
	application.get('/', function(req, res){
		application.app.controller.home.index(application, req, res);
	});

}

