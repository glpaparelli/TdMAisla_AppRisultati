<?php

spl_autoload_register(function ($class) {
    include 'classes/' . $class . '.php';
});

try {
    $conf = parse_ini_file('config.ini', true);
    $mysqlConf = $conf['mysql'];
    $API = new RisultatiApi($_REQUEST['request'], $mysqlConf);
    $API->processAPI();
} catch (BadRequestException $e) {
    $error = new Error(400, $e->getMessage());
    $API->response($error, 400);
} catch (UnauthorizedException $e) {
    $error = new Error(401, $e->getMessage());
    $API->response($error, 401);
} catch (NotFoundException $e) {
    $error = new Error(404, $e->getMessage());
    $API->response($error, 404);
} catch (MethodNotAllowedException $e) {
    $error = new Error(405, $e->getMessage());
    $API->response($error, 405);
} catch (InconsistentDataException $e) {
    $error = new Error(500, $e->getMessage());
    $API->response($error, 500);
} catch (Exception $e) {
    header("HTTP/1.1 500 Internal Server Error");
    header("Content-Type: text/html");
    echo $e->getMessage();
}