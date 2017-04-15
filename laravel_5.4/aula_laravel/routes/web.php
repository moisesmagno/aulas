<?php

Route::get('/posts', 'PostController@index');
Route::get('/posts/{id}', 'PostController@show');