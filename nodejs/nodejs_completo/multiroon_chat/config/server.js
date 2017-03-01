//Importar o módulo do framework express
var express = require('express');

//Importar o módulo consign
var consign = require('consign');

//Importar o módulo body-parcer
var bodyParser = require('body-parser');

//Imprtar o módulo express-validator
var expressValidator = require('express-validator');

//Iniciar o objeto express
var app = express();


//Setar as variáveis 'view engine' e 'views' do express
app.set('view engine', 'ejs');
app.set('views', './app/views');

//Configurar o middleware server.statics
app.use(express.static('./app/public'));

//Configurar o middleware mody-parser
app.use(bodyParser.urlencoded({extended: true}));

//Configurar o middleware express-validator
app.use(expressValidator());

//Configurarndo o autoload das rotas, controller, models, banco de dados, etc.
consign()
	.include('app/routes')
	.then('app/controllers')
	.then('app/models')
	.into(app);

//Exportar o objeto express
module.exports = app;