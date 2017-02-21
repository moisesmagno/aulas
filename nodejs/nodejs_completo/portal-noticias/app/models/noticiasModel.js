//Classe Nocias.
function noticiasModel(connection){
	this._connection = connection;
}

//Atribuindo métodos ao prototype do noticiasModel.
noticiasModel.prototype.salvaNoticia = function(noticia, callback){
	this._connection.query('INSERT INTO TB_NOTICIAS SET ?', noticia, callback);
}

module.exports = function(){
	return noticiasModel;
}