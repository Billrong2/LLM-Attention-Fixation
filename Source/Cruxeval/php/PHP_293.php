<?php
function f($text) {
    $s = strtolower($text);
    for ($i = 0; $i < strlen($s); $i++) {
        if ($s[$i] == 'x') {
            return 'no';
        }
    }
    return ctype_upper($text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("dEXE") !== "no") { throw new Exception("Test failed!"); }
}

test();
