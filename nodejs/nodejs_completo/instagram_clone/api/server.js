var express = require('express'),
    bodyParser = require('body-parser'),
    multiparty = require('connect-multiparty'),
    mongodb = require('mongodb'),
    objectId = require('mongodb').ObjectId,
    fs = require('fs');


var app = express();

app.use(bodyParser.urlencoded({extended: true})); //application/x-www-form-urlencode (Não está preparado para receber arquivos).
app.use(bodyParser.json()); //Recebe Json
app.use(multiparty()); //multipart/form-data (Está preparado para receber arquivos)
app.use(function(req, res, next){
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE");
    res.setHeader("Access-Control-Allow-Headers", "content-type");
    res.setHeader("Access-Control-Allow-Credentials", true);

    next();
});

app.listen(8080);

var db = new mongodb.Db(
    'instagram',
    new mongodb.Server('localhost', 27017, {}),
    {}
);

console.log('O servidor HTTP está escutando na porta:' + 8080);

app.get('/', function(req, res){
    res.send({msg: 'Olá :)'});
});

//POST
app.post('/api', function(req, res){
    
    //Libera o response para qualquer domínio
    res.setHeader("Access-Control-Allow-Origin", "*");
    //res.setHeader("Access-Control-Allo-Origin", "http://dominio.com"); Libera o response somente para um domínio.

    // console.log(req.files); //Este atritubo do request é setado toda vez que é enviado um anexo na requisição, usando o connect-multiparty.

    var date = new Date();
    time_stamp = date.getTime();

    var url_imagem = time_stamp + '_' + req.files.arquivo.originalFilename;

    var path_origin = req.files.arquivo.path;
    var path_destino = './uploads/' + url_imagem;

    fs.rename(path_origin, path_destino, function(err){
        if(err){
            res.status(500).json({error: err});
            return;
        }

        var dados = {
            url_imagem: url_imagem,
            titulo: req.body.titulo
        }

        db.open(function(error, mongoclient){
            mongoclient.collection('postagens', function(error, collection){
                collection.insert(dados, function(error, result){
                    if(error){
                        res.json(error);
                    }else{
                        // res.status(200).json(result);
                        res.json({'status': 'Inclusão resalizada com sucesso!'});
                    }

                    mongoclient.close();

                });
            });
        });

    });
    
});


// GET
app.get('/api', function(req,res){

    //Libera o response para qualquer domínio
    res.setHeader("Access-Control-Allow-Origin", "*");

    db.open(function(error, mongoclient){
        mongoclient.collection('postagens', function(error, collection){
            collection.find().toArray(function(error, result){
                if(error){
                    res.json(error);
                }else {
                    res.status(200).json(result);
                }

                mongoclient.close();
            });
        });
    });
});


//GET by Id (ready)
app.get('/api/:id', function(req, res){
    db.open(function(error, mongoclient){
        mongoclient.collection('postagens', function(error, collection){
            collection.find(objectId(req.params.id)).toArray(function(error, result){
                if(error){
                    res.json(error);
                }else{
                    res.status(200).json(result);
                }
                mongoclient.close();
            });
        });
    });
});


//GET by Id and titulo (ready)
app.get('/api/:id/:titulo', function(req, res){
    db.open(function(error, mongoclient){
        mongoclient.collection('postagens', function(error, collection){
            collection.find({'_id': objectId(req.params.id), 'titulo': req.params.titulo}).toArray(function(error, result){
                if(error){
                    res.json(error);
                }else{
                    res.status(200).json(result);
                }
                mongoclient.close();
            });
        });
    });
});


//PUT by Id (update)
app.put('/api/:id', function(req, res){
    db.open(function(error, mongoclient){
        mongoclient.collection('postagens', function(error, collection){
            collection.update(
                {_id: objectId(req.params.id)},
                {$push: {
                            comentarios: {
                                id_comentario: new objectId(),
                                comentario: req.body.comentario,
                            }
                        }
                },
                {},
                function(error, result){
                    if(error){
                        res.json(error);
                    }else{
                        res.status(200).json(result);
                    }

                    mongoclient.close();

                }
            );
        });
    });
});


//DELETE by Id (delete)
app.delete('/api/:id', function(req, res){
    db.open(function(error, mongoclient){
        mongoclient.collection('postagens', function(error, collection){
            collection.update(
                {},
                {
                    $pull: {
                        comentarios: {
                            id_comentario: objectId(req.params.id)
                        }
                    }
                },
                {
                    multi: true
                },
                function(error, result){
                    if(error){
                        res.json(error);
                    }else{
                        res.status(200).json(result);
                    }

                    mongoclient.close();
                }
            );
        });
    });
});

//Repera Imagem
app.get('/imagem/:imagem', function(req, res){

    var img = req.params.imagem; //Recupera os parámtros enviados pelo método GET.

    fs.readFile('./uploads/'+img, function(error, content){

        if(error){
            res.status(400).json(error);
            return;
        }

        res.writeHead(200, {'Content-type':'image/jpg'});
        res.end(content); //Processa binários, ex: Imagens.
    });

});