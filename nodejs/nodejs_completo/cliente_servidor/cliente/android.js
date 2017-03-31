var http = require('http');

var buffer_corpo_resonse = [];

var opcoes = {
    hostname: 'localhost',
    port: 8080,
    path: '/',
    headers: {
        // 'Accept': 'application/json';
        'Acept': 'text/html'
    }
}

http.get(opcoes, function(res){

    res.on('data', function(pedaco){
        buffer_corpo_resonse.push(pedaco);
    });

    res.on('end', function(){
        var corpo_response = Buffer.concat(buffer_corpo_resonse).toString();
        console.log(corpo_response);
    });

});
