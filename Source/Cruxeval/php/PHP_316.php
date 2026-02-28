<?php
function f($name) {
    return '| ' . implode(' ', explode(' ', $name)) . ' |';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("i am your father") !== "| i am your father |") { throw new Exception("Test failed!"); }
}

test();
