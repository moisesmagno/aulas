@extends('templates.app')

@section('content')

    @if(count($errors) > 0)
        <div class="alert alert-danger">
            <ul>
                @foreach($errors->all() as $error)
                    <li>{{ $error  }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <form method="post" action="{{ route('update_post_path', ['post' => $post->id]) }}">

        <!-- Token de segurança para envios post. -->
        {{ csrf_field() }}

        <!-- Define que o método de envio é PUT -->
        {{ method_field('PUT') }}

        <div class="form-group">
            <label for="title">Title</label>
            <input type="text" name="title" class="form-control" value="{{ $post->title }}">
        </div>

        <div class="form-group">
            <label for="description">Description</label>
            <textarea name="description" class="form-control" cols="5" rows="7">{{ $post->description }}</textarea>
        </div>

        <div class="form-group">
            <label for="url">Url</label>
            <input type="text" name="url" class="form-control" value="{{ $post->url }}">
        </div>

        <div class="form-group">
            <button type="submit" class="btn btn-primary"> Edit Post </button>
        </div>
    </form>
@endsection