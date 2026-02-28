<?php
function f($cart) {
    while (count($cart) > 5) {
        array_pop($cart);
    }
    return $cart;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();
