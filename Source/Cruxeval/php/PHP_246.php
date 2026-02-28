<?php
function f($haystack, $needle) {
    for ($i = strpos($haystack, $needle); $i >= 0; $i--) {
        if (substr($haystack, $i) === $needle) {
            return $i;
        }
    }
    return -1;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("345gerghjehg", "345") !== -1) { throw new Exception("Test failed!"); }
}

test();
