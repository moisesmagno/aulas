
var app = require('./config/server');

var routeHome = require('./app/routes/home')(app);
var routeNoticias = require('./app/routes/noticias')(app);
var routeFormInclusaoNoticias = require('./app/routes/formulario-inclusao-noticia.js')(app);

//Executa  o servidor na porta 3000
app.listen(3000, function(){
	console.log('Servidor ON :)');
});
