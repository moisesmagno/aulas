<?php

namespace App\Http\Controllers;

use App\Post;
use Illuminate\Http\Request;
use App\Http\Requests\CreatePosRequest;

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
}
