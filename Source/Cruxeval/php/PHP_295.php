<?php
function f($fruits) {
    if (end($fruits) == reset($fruits)) {
        return 'no';
    } else {
        array_shift($fruits);
        array_pop($fruits);
        array_shift($fruits);
        array_pop($fruits);
        return $fruits;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("apple", "apple", "pear", "banana", "pear", "orange", "orange")) !== array("pear", "banana", "pear")) { throw new Exception("Test failed!"); }
}

test();
