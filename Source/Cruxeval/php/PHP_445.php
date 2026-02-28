<?php
function f($names) {
    $parts = explode(',', $names);
    foreach ($parts as &$part) {
        $part = str_replace(' and', '+', $part);
        $part = ucwords($part);
        $part = str_replace('+', ' and', $part);
    }
    return implode(', ', $parts);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("carrot, banana, and strawberry") !== "Carrot,  Banana,  and Strawberry") { throw new Exception("Test failed!"); }
}

test();
