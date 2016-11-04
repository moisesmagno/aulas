$(document).ready(function(){
	
	var contatos = {
		contatos: [],
		contatosRetorno: [],
		cadastrar: function(contato){
			var emailValido = /^(\w+[._-]?)+@\w+(\w+[.]?)+$/; //ailton.santos@email.com
			var telefoneValido = /^\d{5}-\d{4}$/; // 98765-8765

			//Adiciona noDadosFormulario as informações que o usuário inseriu no formulário.
			var DadosFormulario = contato;

			if(DadosFormulario.id && DadosFormulario.nome && DadosFormulario.email && DadosFormulario.telefone){
				
				if(!emailValido.test(contato.email)){
					alert('E-mail incorreto!');
					return false;
				}

				if(!telefoneValido.test(contato.telefone)){
					alert('Telefone incorreto! Correto: 96481-6215');
					return false;
				}

				if(localStorage.getItem('localContatos')){
					
					this.recuperarContatos();

					//Verifica se o e-mail já existe no locaStorage.
					for (index in this.contatosRetorno){
						var dadosContato = this.contatosRetorno[index];
						if(dadosContato.email === DadosFormulario.email){
							alert('O e-mail informado já existe, por favor escolha outro!');
							// this.contatoTemp = [];
							return false;
						}		
					}


					this.contatos.push(DadosFormulario);	

					//Recupera os resgistros do que estão na localStorage e concatena com o novo registro
					this.recuperarContatos();
					this.contatosRetorno.push(this.contatos[0]);

					//Salva todos os registros no localStorage novamente;
					this.salvarContatos(this.contatosRetorno); 

					var montaRegistro = "<li data-id=\""+DadosFormulario.id+"\" class=\"liContato\"><div><span>"+DadosFormulario.nome+"</span><span>"+DadosFormulario.email+"</span><span>"+DadosFormulario.telefone+"</span></div><div><a href=\"#\" id=\"editarContato\">Editar</a><a href=\"#\" id=\"excluirContato\">Excluir</a></div></li>";
					$('.listaContatos').append(montaRegistro);	

					//Mostra o total de registros.
					this.exibirTotalRegistros();	

					// this.listar();
					DadosFormulario = '';
				}else{
					this.contatos.push(DadosFormulario);
					this.salvarContatos(this.contatos);

					var montaRegistro = "<li data-id=\""+DadosFormulario.id+"\" class=\"liContato\"><div><span>"+DadosFormulario.nome+"</span><span>"+DadosFormulario.email+"</span><span>"+DadosFormulario.telefone+"</span></div><div><a href=\"#\" id=\"editarContato\">Editar</a><a href=\"#\" id=\"excluirContato\">Excluir</a></div></li>";
					$('.listaContatos').append(montaRegistro);	

					//Mostra o total de registros.
			        this.exibirTotalRegistros();
				}

				$("#id").val(Math.floor(Math.random() * 256));

				//Limpa os campos
				$("#name").val("");
				$("#email").val("");
				$("#telefone").val(""); 

			}else{
				alert('Por favor preencher todos os campos!');
			}
		},
		exibirTotalRegistros: function(){
			if(localStorage.getItem('localContatos')){
				this.recuperarContatos();
				var contador = this.contatosRetorno.length;
				
				$("#contatorContatos").html("<h3>"+contador+" contato(s)</h3>");
			}
		},
		salvarContatos: function(contatos){
			//Transforma o json em uma cadeia de texto que contem json e o armazena na localStorage.
			var jsonContatos = JSON.stringify(contatos);	
			localStorage.localContatos = jsonContatos;	
		},
		recuperarContatos: function(){
			//Recupera os contatos da locaStorage e os transforma em array de jsons
			this.contatosRetorno = JSON.parse(localStorage.localContatos);
		},
		listar: function(){

			$("#id").val(Math.floor(Math.random() * 256));

			//Mostra o total de registros.
			this.exibirTotalRegistros();

			this.recuperarContatos();

			for(index in this.contatosRetorno){
				var montaRegistro = "<li data-id=\""+this.contatosRetorno[index].id+"\" class=\"liContato\"><div><span>"+this.contatosRetorno[index].nome+"</span><span>"+this.contatosRetorno[index].email+"</span><span>"+this.contatosRetorno[index].telefone+"</span></div><div><a href=\"#\" id=\"editarContato\">Editar</a><a href=\"#\" id=\"excluirContato\">Excluir</a></div></li>";

				$('.listaContatos').append(montaRegistro);

			}
		},
		remover: function(id){

			this.recuperarContatos();

			for(index in this.contatosRetorno){
				if(this.contatosRetorno[index].id === id){	
					this.contatosRetorno.splice(index, 1);

					this.salvarContatos(this.contatosRetorno);
					return true;
				}
			}

		},
		atualizar: function(contato){

			this.recuperarContatos();

			for(index in this.contatosRetorno){
				if(this.contatosRetorno[index].id ===  contato.id){
					this.contatosRetorno[index].nome = contato.nome;		
					this.contatosRetorno[index].email = contato.email;		
					this.contatosRetorno[index].telefone = contato.telefone;		
				}
			}

			this.salvarContatos(this.contatosRetorno);

			location.reload();

		}
	}

	//Pega e limpa os dasdos do formulário
	$("#formulario").submit(function(event){
		event.preventDefault();

		//Pega os dados
		var contato = {
			id: $("#id").val(),
			nome: $("#name").val(),
			email: $("#email").val(),
			telefone: $("#telefone").val() 
		}

		if($("#submit").val() === 'Cadastrar'){
			contatos.cadastrar(contato);
		}else{
			contatos.atualizar(contato);
		}

	});

	//Editar contato
	$(document).delegate('#editarContato', 'click', function(event){
		event.preventDefault();
	 	
	 	var contatoArray = [];

	 	$(this).parents('li').find('span').each(function(index){
	 		contatoArray[index] = $(this).text();
	 	}); 
		
	 	var id = $(this).parents('li').attr("data-id");
		
		$("#id").val(id);
	 	$("#name").val(contatoArray[0]);
		$("#email").val(contatoArray[1]);
		$("#telefone").val(contatoArray[2]);
		$("#submit").val('Atualizar');
	});

	//Remover contato
	$(document).delegate('#excluirContato', 'click', function(event){
		event.preventDefault();

		if(confirm("Deseja excluir este contato?")){
			var idContato = $(this).parents('li').attr("data-id");
			if(contatos.remover(idContato)){
				$(this).parents('li').hide(function(){
					alert('Contato removido com sucesso!');	
				});
				contatos.exibirTotalRegistros();
			}else{
				alert('Ocorreu uma falha na exclusão do contato!');
			}
		}
	});

	contatos.listar();

});


