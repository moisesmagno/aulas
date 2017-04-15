<?php
/**
 * Created by PhpStorm.
 * User: Moisés
 * Date: 15/04/2017
 * Time: 13:51
 */

namespace App;


use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
   protected $table = 'posts';
   protected $fillable = ['title', 'description', 'url'];
}