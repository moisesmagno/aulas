@extends('templates.app')

@section('content')

    @foreach($posts as $post)

        <div class="row">
            <div class="col-md-12">
                <h3><a href="{{ route('post_path', ['post' => $post->id]) }}">{{$post->title}}</a></h3>
                <p>posted {{ $post->created_at->diffForHumans() }}</p>
            </div>
        </div>

        <br>
    @endforeach

    {{ $posts->render() }}

@endsection
