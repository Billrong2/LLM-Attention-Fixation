<?php
function f($text) {
    $b = true;
    for ($i = 0; $i < strlen($text); $i++) {
        if (is_numeric($text[$i])) {
            $b = true;
        } else {
            $b = false;
            break;
        }
    }
    return $b;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("-1-3") !== false) { throw new Exception("Test failed!"); }
}

test();
