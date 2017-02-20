var express = require('express');
var consign = require('consign');
var bodyParser = require('body-parser');
var expressValidator = require('express-validator');

var app = express();

app.set('view engine', 'ejs'); // Estamos dizendo ao node.js que o ejs irá gerar nossas views html.
app.set('views', './app/views'); // Informa que o acesso padrão das views será feito através do novo caminhao informado.

// middleware (Sempre antes dos includes das nossos arquivos, rotas, models, dbConnection, etc.)
app.use(express.static('./app/public')); //Carrega os arquivos estáticos
app.use(bodyParser.urlencoded({extended: true}));
app.use(expressValidator());

//Autoload com consign.
consign()
	.include('./app/routes')
	.then('./app/controllers')
	.then('./app/models')
	.then('./config/dbConnection.js')
	.into(app)

//Exportando a variável app que contúm o método express() e outras atribui.
module.exports = app;


