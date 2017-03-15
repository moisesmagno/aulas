/* Importar o módulo do framework express */
var express = require('express');

/* Importar o módulo do consign */
var consign = require('consign');

/* Importar o módulo do body-parser */
var bodyParser = require('body-parser');

/* Importar o módulo do express-validator */
var expressValidator = require('express-validator');

/* Importar o módulo do express-session */
var expressSession = require('express-session');

/* Iniciar o objeto do express */
var app = express();

/* Setar as variáveis 'view engine' e 'views' do express */
app.set('view engine', 'ejs');
app.set('views', './app/views');

/* Configurar o middleware express.static */
app.use(express.static('./app/public'));

/* Configurar o middleware body-parser */
app.use(bodyParser.urlencoded({extended: true}));

/* configurar o middleware express-validator */
app.use(expressValidator());

/* Configura o express-session */
app.use(expressSession({
	secret: 'moisdfkljsdfosdfoihdsf',
	resave: false,
	saveUninitialized: false
}));

/* efetua o autoload das rotas, dos models e dos controllers para o objeto app */
consign()
	.include('app/routes')
	.then('config/dbConnection.js')
	.then('app/models')
	.then('app/controllers')
	.into(app);

/* exportar o objeto app */
module.exports = app;