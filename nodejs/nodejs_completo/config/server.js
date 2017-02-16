var express = require('express'); // Chama o modulo express e retorna uma função que não é executada.
var consign = require('consign');
var bodyParser = require('body-parser');

var app = express();

app.set('view engine', 'ejs'); // Estamos dizendo ao node.js que o ejs irá gerar nossas views html.
app.set('views', './app/views') // Informa que o acesso padrão das views será feito através do novo caminhao informado.

app.use(bodyParser.urlencoded({extended: true})); //Sempre antes dos includes das nossos arquivos, rotas, models, dbConnection, etc.

consign()
	.include('app/routes')
	.then('config/dbConnection.js')
	.then('app/models')
	.into(app); //Importante! Fazer este procedimento sempre depois da atribuição do express() a variável app (var app = exprex())



module.exports = app;