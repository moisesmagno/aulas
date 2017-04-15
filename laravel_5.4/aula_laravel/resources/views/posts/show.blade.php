@extends('templates.app')

@section('content')
    <div class="row">
        <div class="col-md-12">
            <h2>{{ $post->title }}</h2>
            <p>posted {{ $post->created_at->diffForHumans() }}</p>
            <p>{{ $post->description }}</p>
        </div>
    </div>

    <br>
@endsection
