var mysql = require('mysql');

// Armazena conexão em um variável para não ser executado desnecessariamente ao rodar ou autoload.
var connMySQL = function(){
	return connection = mysql.createConnection({
		host: 'localhost',
		user: 'root',
		password: '',
		database: 'portal_noticias'
	});
}

module.exports = function(){
	//Retorna uma variável contendo uma função que pode ser executada quando necessário.
	return connMySQL;
}