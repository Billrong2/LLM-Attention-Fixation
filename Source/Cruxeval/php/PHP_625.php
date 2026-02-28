<?php
function f($text) {
    $count = 0;
    for ($i = 0; $i < strlen($text); $i++) {
        if (strpos('.?!.,', $text[$i]) !== false) {
            $count++;
        }
    }
    return $count;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("bwiajegrwjd??djoda,?") !== 4) { throw new Exception("Test failed!"); }
}

test();
