<?php
function f($text) {
    $x = 0;
    if (ctype_lower($text)) {
        for ($i = 0; $i < strlen($text); $i++) {
            if (is_numeric($text[$i]) && (int)$text[$i] < 90) {
                $x++;
            }
        }
    }
    return $x;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("591237865") !== 0) { throw new Exception("Test failed!"); }
}

test();
