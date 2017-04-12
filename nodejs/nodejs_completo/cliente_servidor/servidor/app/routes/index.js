module.exports = function(application){
	application.get('/', function(req, res){

		res.format({
			html: function(){
				res.send('Bem vindo a sua app NodeJS!');
			},

			json: function(){
				var data = {
					msg: 'Bem vindo a sua app NodeJS!'
				}

				res.json(data);
			}
		});

		res.send('Bem vindo a sua app NodeJS!');
	});
}