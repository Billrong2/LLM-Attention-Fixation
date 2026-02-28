<?php
function f($name) {
    return implode('*', explode(' ', $name));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Fred Smith") !== "Fred*Smith") { throw new Exception("Test failed!"); }
}

test();
