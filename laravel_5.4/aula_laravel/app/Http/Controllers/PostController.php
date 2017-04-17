<?php

namespace App\Http\Controllers;

use App\Post;
use Illuminate\Http\Request;
use App\Http\Requests\CreatePosRequest;
use App\Http\Requests\UpdatePostRequest;

class PostController extends Controller
{
    //Lista os posts
    public function index(){

        $posts = Post::orderBy('id', 'desc')->paginate(5);

        return view('posts.index')->with(['posts' => $posts]);
    }

    //Lista apenas um post escolhido
    public function show(Post $post){

        return view('posts.show')->with(['post' => $post]);
    }

    //Chama a view do formulário
    public function create(){
        return view('posts.create');
    }

    //Registra um novo post
    public function store(CreatePosRequest $request){

//        $post = new Post;
//        $post->title = $request->get('title');
//        $post->description = $request->get('description');
//        $post->url = $request->get('url');
//        $post->save();

        $post = Post::create($request->only('title', 'description', 'url'));

        return redirect()->route('posts_path');
    }

    //Retorna a tela de editar post
    public function edit(Post $post){
        return view('posts.edit')->with(['post' => $post]);
    }

    //Atualiza os dados do post
    public function update(Post $post, UpdatePostRequest $request){
//        $post->title = $request->get('title');
//        $post->description = $request->get('description');
//        $post->url = $request->get('url');
//        $post->save();

        //Uma nova forma de atualizar dados.
        $post->update(
            $request->only('title', 'description', 'url')
        );

        return redirect()->route('post_path', ['post' => $post->id]);
    }

    //Exclui o post
    public function delete(Post $post){
        $post->delete();

        return redirect()->route('posts_path');
    }
}
