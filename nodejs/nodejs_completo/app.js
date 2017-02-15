var app = require('./config/server'); //Requisita o módulo Server.js

//Executa  o servidor na porta 3000
app.listen(3000, function(){
	console.log('Servidor ON :)');
});
