<?php
function f($string, $code) {
    $t = '';
    try {
        $t = iconv($code, 'UTF-8', $string);
        if (substr($t, -1) == "\n") {
            $t = substr($t, 0, -1);
        }
        return $t;
    } catch (Exception $e) {
        return $t;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("towaru", "UTF-8") !== "towaru") { throw new Exception("Test failed!"); }
}

test();
