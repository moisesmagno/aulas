var express = require('express'),
    bodyParser = require('body-parser'),
    mongodb = require('mongodb');

var app = express();

app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

app.listen(8080);

console.log('O servidor HTTP está escutando na porta:' + 8080);

app.get('/', function(req, res){
    res.send({msg: 'Olá :)'});
});
