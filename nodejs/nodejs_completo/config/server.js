var express = require('express'); // Chama o modulo express e retorna uma função que não é executada.
var app = express();

app.set('view engine', 'ejs'); // Estamos dizendo ao node.js que o ejs irá gerar nossas views html.
app.set('views', './app/views') // Informa que o acesso padrão das views será feito através do novo caminhao informado.

module.exports = app;