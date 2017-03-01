module.exports = function(application){
	application.get('/', function(req, res){
		application.app.controllers.IndexController.home(application, req, res);
	});
}