module.exports = function(application){
	application.get('/', function(req, res){
		//Chamar o controller homeController
		application.app.controllers.homeController.index(application, req, res);
	});
}	