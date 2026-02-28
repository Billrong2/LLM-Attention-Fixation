<?php
function f($s, $x) {
    $count = 0;
    while(substr($s, 0, strlen($x)) === $x && $count < strlen($s) - strlen($x)) {
        $s = substr($s, strlen($x));
        $count += strlen($x);
    }
    return $s;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("If you want to live a happy life! Daniel", "Daniel") !== "If you want to live a happy life! Daniel") { throw new Exception("Test failed!"); }
}

test();
