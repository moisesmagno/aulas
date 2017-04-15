<?php

Route::name('posts_path')->get('/posts', 'PostController@index');
Route::name('create_post_path')->get('/posts/create', 'PostController@create');
Route::name('store_post_path')->post('/post', 'PostController@store');
Route::name('post_path')->get('/posts/{post}', 'PostController@show');