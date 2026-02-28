<?php
function f($text, $sep) {
    return explode($sep, $text, 3);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("a-.-.b", "-.") !== array("a", "", "b")) { throw new Exception("Test failed!"); }
}

test();
