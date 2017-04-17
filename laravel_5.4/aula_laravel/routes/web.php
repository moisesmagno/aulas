<?php

Route::name('posts_path')->get('/posts', 'PostController@index');
Route::name('create_post_path')->get('/posts/create', 'PostController@create');
Route::name('store_post_path')->post('/post', 'PostController@store');
Route::name('post_path')->get('/posts/{post}', 'PostController@show');
Route::name('edit_post_path')->get('/post/{post}/edit', 'PostController@edit');
Route::name('update_post_path')->put('/post/{post}/update', 'PostController@update');
Route::name('delete_post_path')->delete('post/{post}/delete', 'PostController@delete');