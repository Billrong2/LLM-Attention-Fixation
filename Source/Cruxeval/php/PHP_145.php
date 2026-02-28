<?php
function f($price, $product) {
    $inventory = ['olives', 'key', 'orange'];
    if (!in_array($product, $inventory)) {
        return $price;
    } else {
        $price *= 0.85;
        unset($inventory[array_search($product, $inventory)]);
    }
    return $price;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(8.5, "grapes") !== 8.5) { throw new Exception("Test failed!"); }
}

test();
