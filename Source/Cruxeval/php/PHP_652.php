<?php
function f($string) {
    if (empty($string) || !is_numeric($string[0])) {
        return 'INVALID';
    }
    $cur = 0;
    for ($i = 0; $i < strlen($string); $i++) {
        $cur = $cur * 10 + intval($string[$i]);
    }
    return strval($cur);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("3") !== "3") { throw new Exception("Test failed!"); }
}

test();
