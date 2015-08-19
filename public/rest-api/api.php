<?php

spl_autoload_register(function ($class) {
    include 'classes/' . $class . '.php';
});

try {
    $conf = parse_ini_file('config.ini', true);
    $mysqlConf = $conf['mysql'];
    $API = new RisultatiApi($_REQUEST['request'], $mysqlConf);
    $API->processAPI();
} catch (UnauthorizedException $e) {
    $API->response(NULL, 401);
} catch (MethodNotAllowedException $e) {
    $API->response(NULL, 405);
} catch (Exception $e) {
    header("HTTP/1.1 500 Internal Server Error");
    header("Content-Type: text/html");
    //echo Array('error' => $e->getMessage());
    echo $e->getMessage();
}