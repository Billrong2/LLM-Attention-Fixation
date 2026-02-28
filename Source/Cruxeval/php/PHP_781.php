<?php
function f($s, $ch) {
    if (strpos($s, $ch) === false) {
        return '';
    }
    $s = strrev(substr(strstr($s, $ch), strlen($ch)));
    for ($i = 0; $i < strlen($s); $i++) {
        $s = strrev(substr(strstr($s, $ch), strlen($ch)));
    }
    return $s;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("shivajimonto6", "6") !== "") { throw new Exception("Test failed!"); }
}

test();
