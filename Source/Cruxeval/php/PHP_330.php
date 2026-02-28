<?php
function f($text) {
    $ans = '';
    for ($i = 0; $i < strlen($text); $i++) {
        if (is_numeric($text[$i])) {
            $ans .= $text[$i];
        } else {
            $ans .= ' ';
        }
    }
    return $ans;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("m4n2o") !== " 4 2 ") { throw new Exception("Test failed!"); }
}

test();
