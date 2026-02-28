<?php
function f($dict) {
    $even_keys = [];
    foreach(array_keys($dict) as $key) {
        if ($key % 2 === 0) {
            $even_keys[] = $key;
        }
    }
    return $even_keys;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(4 => "a")) !== array(4)) { throw new Exception("Test failed!"); }
}

test();
