var express = require('express'); // Chama o modulo express e retorna uma função que não é executada.

var msg = require('./mod_teste'); // Módulo requerido
var msg2 = require('./mod_teste_2'); // Módulo requerido

var app = express();

app.set('view engine', 'ejs'); // Estamos dizendo ao node.js que o ejs irá gerar nossas views html.

app.get('/', function(req, res){
	res.render('home/index');
});

app.get('/formulario-inclusao-noticia', function(req, res){
	res.render('admin/form_add_noticia');
});

app.get('/noticias', function(req, res){
	res.render('noticias/noticia');
});

app.listen(3000, function(){
	console.log('Servidor rodando com express!');
	console.log(msg);
	console.log(msg2()); /* Toda vez que um módulo exporta uma função, a função tem que ser executada assim como consta dentro do console.log 
						 ou executar diretamente na hora que está sendo execudo o require "require('modulo')()"*/
});
