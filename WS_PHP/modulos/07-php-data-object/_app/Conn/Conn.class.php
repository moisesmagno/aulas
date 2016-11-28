<?php

/**
 * Conn.class [ CONEXÃO ]
 * Classe abstrata de conexão. Padrão SingleTon.
 * Retorna um objeto PDO pelo método estático getConn();
 * 
 * @copyright (48756)(c) 2016, Robson V. Leite - UPINSIDE TREINAMENTOS
 */
class Conn {
    
    private static $Host = HOST;
    private static $User = USER;
    private static $Pass = PASS;
    private static $DBsa = DBSA;
    
    /* @var PDO */
    private static $Connect;
    
    /**
     * Conecta com o banco de dados com o pattern SingleTon.
     * Retorna um objeto PDO.
     */
    public static function getConn(){
        if(empty(self::$Connect)):
            self::$Connect = new PDO('mysql:host='.self::$Host.';dbname='.self::$DBsa.';',''.self::$User.'',''.self::$Pass.'');
        endif;
        
        return self::$Connect;

    }
    
}