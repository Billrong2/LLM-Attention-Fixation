<?php
function f($s) {
    $a = str_split($s);
    $b = $a;
    foreach(array_reverse($a) as $c) {
        if($c == ' ') {
            array_pop($b);
        } else {
            break;
        }
    }
    return implode('', $b);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("hi ") !== "hi") { throw new Exception("Test failed!"); }
}

test();
