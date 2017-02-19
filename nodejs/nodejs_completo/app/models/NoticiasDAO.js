// A função abaixo será nossa classe Noticias
function NoticiasDAO(connection){
	this._connection = connection; //Atributo da classe.
}

NoticiasDAO.prototype.getNoticias = function(callback){
	this._connection.query('SELECT * FROM TB_NOTICIAS', callback);
} 

NoticiasDAO.prototype.getNoticia = function(callback){
	this._connection.query('SELECT * FROM TB_NOTICIAS WHERE id_noticias = 2', callback);
}

NoticiasDAO.prototype.salvarNoticia = function(noticia, callback){
	this._connection.query('INSERT INTO TB_NOTICIAS SET ?', noticia, callback);
}

NoticiasDAO.prototype.get5UltimasNoticias = function(callback){
	this._connection.query('SELECT * FROM TB_NOTICIAS ORDER BY date_at DESC LIMIT 5', callback);
}

module.exports = function(){

	return NoticiasDAO; 
}
