<?php
function f($text) {
    $text = strtoupper($text);
    $count_upper = 0;
    for ($i = 0; $i < strlen($text); $i++) {
        $char = $text[$i];
        if (ctype_upper($char)) {
            $count_upper++;
        } else {
            return 'no';
        }
    }
    return $count_upper / 2;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ax") !== 1) { throw new Exception("Test failed!"); }
}

test();
