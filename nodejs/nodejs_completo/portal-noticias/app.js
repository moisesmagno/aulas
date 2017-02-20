// Requerindo o server.js que contém dependências.
var app = require('./config/server');

//Incializa o servidor na porta 3000.
app.listen(3000, function(){
	console.log('Servidor ON :)');
});