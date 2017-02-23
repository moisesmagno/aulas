//Classe Nocias.
function noticiasModel(connection){
	this._connection = connection;
}

//Atribuindo métodos ao prototype do noticiasModel.
noticiasModel.prototype.salvaNoticia = function(noticia, callback){
	this._connection.query('INSERT INTO TB_NOTICIAS SET ?', noticia, callback);
}

//Recuperando todas as notícias.
noticiasModel.prototype.recuperarNoticias = function(callback){
	this._connection.query('SELECT * FROM TB_NOTICIAS ORDER BY date_at DESC', callback);
}

//Recupera uma notícia específica.
noticiasModel.prototype.recuperarNoticia = function(id_noticia, callback){
	this._connection.query('SELECT * FROM TB_NOTICIAS WHERE id_noticias = ' + id_noticia, callback);
}


module.exports = function(){
	return noticiasModel;
}