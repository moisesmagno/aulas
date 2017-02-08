var express = require('express'); // Chama o express e retorna uma função que não é executada.
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
});
