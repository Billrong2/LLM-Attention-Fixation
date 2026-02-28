<?php
function f($l, $c) {
    return implode($c, $l);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("many", "letters", "asvsz", "hello", "man"), "") !== "manylettersasvszhelloman") { throw new Exception("Test failed!"); }
}

test();
