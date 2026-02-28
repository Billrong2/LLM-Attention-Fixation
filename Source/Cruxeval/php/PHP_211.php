<?php
function f($s) {
    $count = 0;
    for ($i = 0; $i < strlen($s); $i++) {
        if (strrpos($s, $s[$i]) !== strpos($s, $s[$i])) {
            $count++;
        }
    }
    return $count;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("abca dea ead") !== 10) { throw new Exception("Test failed!"); }
}

test();
