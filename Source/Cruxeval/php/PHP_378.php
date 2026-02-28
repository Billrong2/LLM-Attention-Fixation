<?php
function f($dic, $key) {
    $v = array_key_exists($key, $dic) ? $dic[$key] : 0;
    if ($v == 0) {
        return 'No such key!';
    }
    return intval(array_pop($dic));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("did" => 0), "u") !== "No such key!") { throw new Exception("Test failed!"); }
}

test();
