module.exports = function(){

	this.getNoticias = function(connection, callback){
		connection.query('SELECT * FROM TB_NOTICIAS', callback);
	}

	this.getNoticia = function(connection, callback){	
		connection.query('SELECT * FROM TB_NOTICIAS WHERE id_noticias = 2', callback);

	}

	return this; 
}