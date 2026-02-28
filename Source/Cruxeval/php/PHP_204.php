<?php
function f($name) {
    return [$name[0], strrev($name[1])[0]];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("master. ") !== array("m", "a")) { throw new Exception("Test failed!"); }
}

test();
