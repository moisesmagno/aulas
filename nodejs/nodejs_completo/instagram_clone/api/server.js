var express = require('express'),
    bodyParser = require('body-parser'),
    mongodb = require('mongodb'),
    objectId = require('mongodb').ObjectId;

var app = express();

app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

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
    var dados = req.body;

    db.open(function(error, mongoclient){
        mongoclient.collection('postagens', function(error, collection){
            collection.insert(dados, function(error, result){
                if(error){
                    res.json(error);
                }else{
                    res.json(result);
                }

                mongoclient.close();

            });
        });
    });
});


// GET
app.get('/api', function(req,res){
    db.open(function(error, mongoclient){
        mongoclient.collection('postagens', function(error, collection){
            collection.find().toArray(function(error, result){
                if(error){
                    res.json(error);
                }else {
                    res.json(result);
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
                    res.json(result);
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
                    res.json(result);
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
                {$set: {url_imagem: req.body.url_imagem}},
                {},
                function(error, result){
                    if(error){
                        res.json(error);
                    }else{
                        res.json(result);
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
            collection.remove(
                {_id: objectId(req.params.id)},
                function(error, result){
                    if(error){
                        res.json(error);
                    }else{
                        res.json(result);
                    }

                    mongoclient.close();
                }
            );
        });
    });
});