module.exports = function(application){
	application.get('/excluir', function(req, res){
		application.app.controllers.adminController.excluir(application, req, res);
	});
}