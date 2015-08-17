<?php

class TestAPI extends RESTfulAPI {

    protected $User;

    public function __construct($request, $origin) {
        parent::__construct($request);

//        // Abstracted out for example
//        $APIKey = new Models\APIKey();
//        $User = new Models\User();
//
//        if (!array_key_exists('apiKey', $this->request)) {
//            throw new Exception('No API Key provided');
//        } else if (!$APIKey->verifyKey($this->request['apiKey'], $origin)) {
//            throw new Exception('Invalid API Key');
//        } else if (array_key_exists('token', $this->request) &&
//             !$User->get('token', $this->request['token'])) {
//
//            throw new Exception('Invalid User Token');
//        }
//
//        $this->User = $User;
    }

    /**
     * Example of an Endpoint
     */
    protected function example() {
        if ($this->method == 'GET') {
            $auth_conf = parse_ini_file('config.ini', true)['auth'];
            $auth_cookie_name = $auth_conf['cookie-name'];
            $auth_session_expiration_minutes = $auth_conf['session-expiration-minutes'];
            if (isset($_COOKIE[$auth_cookie_name])) {
                $auth = $_COOKIE[$auth_cookie_name];
                $mysql_dbms_conf = parse_ini_file('config.ini', true)['mysql-dbms'];
                $db = new mysqli(
                        $mysql_dbms_conf['servername'], $mysql_dbms_conf['username'], $mysql_dbms_conf['password'], $mysql_dbms_conf['database']);
                $rs = $db->query("SELECT * FROM user WHERE auth = '$auth' AND authExpires > NOW()");
                if ($rs->num_rows == 1) {
                    // refreshing expiration

                    $sql = "UPDATE user SET authExpires=DATE_ADD(NOW(),  INTERVAL $auth_session_expiration_minutes MINUTE)  WHERE auth = '$auth'";
                    $r = $db->query($sql);
                    if ($r === false) {
                        return "Error in updating db";
                    }
                    //setcookie($auth_cookie_name, $auth, $auth_session_expiration_minutes * 60);
                    return "Your token is $auth and is valid";
                } else {
                    setcookie($auth_cookie_name, $auth, time() - 24 * 3600);
                    return "Your token is $auth and is expired";
                }
                $db->close();
            } else {
                return "No token cookie seems defined";
            }
        } else {
            return "Only accepts GET requests";
        }
    }

    protected function login() {
        $mysql_dbms_conf = parse_ini_file('config.ini', true)['mysql-dbms'];
        $auth_conf = parse_ini_file('config.ini', true)['auth'];
        $auth_cookie_name = $auth_conf['cookie-name'];
        $db = new mysqli(
                $mysql_dbms_conf['servername'], $mysql_dbms_conf['username'], $mysql_dbms_conf['password'], $mysql_dbms_conf['database']);
        if ($db->connect_errno) {
            return "Connection failed: " . $conn->connect_error;
        }

        if (array_key_exists('username', $this->request) &&
                array_key_exists('password', $this->request)) {
            $username = $this->request['username'];
            $password = $this->request['password'];
            $auth_cookie_name = $auth_conf['cookie-name'];
            $auth_session_expiration_minutes = $auth_conf['session-expiration-minutes'];
            $rs = $db->query("SELECT * FROM user WHERE username = '$username' AND password = '$password'");
            if ($rs->num_rows == 1) {
                $auth = sha1($username . $password . time());
                // TODO Verify unicity of the auth token
                $sql = "UPDATE user SET auth='$auth', authExpires=DATE_ADD(NOW(),  INTERVAL $auth_session_expiration_minutes MINUTE)  WHERE username = '$username'";
                $r = $db->query($sql);
                if ($r === false) {
                    return "Error in updating db";
                }
                setcookie($auth_cookie_name, $auth);
                return "User found";
            } else {
                return "No user found";
            }
            $db->close();
        } else {
            return "Please specify username and password";
        }
    }

    protected function logout() {
        $mysql_dbms_conf = parse_ini_file('config.ini', true)['mysql-dbms'];
        $auth_conf = parse_ini_file('config.ini', true)['auth'];
        $auth_cookie_name = $auth_conf['cookie-name'];
        $db = new mysqli(
                $mysql_dbms_conf['servername'], $mysql_dbms_conf['username'], $mysql_dbms_conf['password'], $mysql_dbms_conf['database']);
        if ($db->connect_errno) {
            return "Connection failed: " . $conn->connect_error;
        }
        if (isset($_COOKIE[$auth_cookie_name])) {

            $auth = $_COOKIE[$auth_cookie_name];
            $sql = "UPDATE user SET auth=NULL, authExpires=NULL  WHERE auth = '$auth'";
            $r = $db->query($sql);
            if ($r === false) {
                return "Error in updating db";
            }
            setcookie($auth_cookie_name, $auth, time() - 3600 * 24);
            return "Logged out";
        } else {
            return "No auth token set";
        }
        $db->close();
    }

    protected function me() {
        $mysql_dbms_conf = arse_ini_file('config.ini', true)['mysql-dbms'];
        $auth_conf = parse_ini_file('config.ini', true)['auth'];


        $auth_cookie_name = $auth_conf['cookie-name'];
        $auth_session_expiration_minutes = $auth_conf['session-expiration-minutes'];
        
        $db = new mysqli(
                $mysql_dbms_conf['servername'], $mysql_dbms_conf['username'], $mysql_dbms_conf['password'], $mysql_dbms_conf['database']);
        if ($db->connect_errno) {
            return "Connection failed: " . $conn->connect_error;
        }
        if (isset($_COOKIE[$auth_cookie_name])) {

            $auth = $_COOKIE[$auth_cookie_name];

            $sql = "SELECT username, email FROM user WHERE auth = '$auth'";
            $rs = $db->query($sql);
            if ($rs->num_rows == 1) {
                $me = $rs->fetch_all(MYSQLI_ASSOC)[0];
                $sql = "UPDATE user SET auth='$auth', authExpires=DATE_ADD(NOW(),  INTERVAL $auth_session_expiration_minutes MINUTE)  WHERE auth = '$auth'";
                $r = $db->query($sql);
                if ($r === false) {
                    return "Error in updating db";
                }
            }
            else {
                
            }
            return $me;
        } else {
            return "No auth token set";
        }
        $db->close();
    }

}
