<?php
function f($ls) {
    return array_fill_keys($ls, 0);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("x", "u", "w", "j", "3", "6")) !== array("x" => 0, "u" => 0, "w" => 0, "j" => 0, "3" => 0, "6" => 0)) { throw new Exception("Test failed!"); }
}

test();
