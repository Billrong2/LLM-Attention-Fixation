<?php
function f($text) {
    $a = 0;
    if (strpos(substr($text, 1), $text[0]) !== false) {
        $a += 1;
    }
    for ($i = 0; $i < strlen($text)-1; $i++) {
        if (strpos(substr($text, $i+1), $text[$i]) !== false) {
            $a += 1;
        }
    }
    return $a;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("3eeeeeeoopppppppw14film3oee3") !== 18) { throw new Exception("Test failed!"); }
}

test();
