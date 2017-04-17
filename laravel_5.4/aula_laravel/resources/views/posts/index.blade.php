@extends('templates.app')

@section('content')

    @foreach($posts as $post)

        <div class="row">
            <div class="col-md-12">
                <h3>
                    <a href="{{ route('post_path', ['post' => $post->id]) }}">{{$post->title}}</a>
                    <small class="pull-right">
                        <a href="{{ route('edit_post_path', ['post' => $post->id]) }}" class="btn btn-info">Edit</a>
                        <form action="{{ route('delete_post_path', ['id' => $post->id]) }}" method="post">

                            {{--Envia token via post--}}
                            {{ csrf_field() }}

                            {{--Informa o tipo de método será executado.--}}
                            {{ method_field('DELETE') }}

                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </small>
                </h3>
                <p>posted {{ $post->created_at->diffForHumans() }}</p>
            </div>
        </div>

        <br>
    @endforeach

    {{ $posts->render() }}

@endsection
    