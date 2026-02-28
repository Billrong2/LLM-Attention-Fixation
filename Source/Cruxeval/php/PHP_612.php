<?php
function f($d) {
    return $d;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("a" => 42, "b" => 1337, "c" => -1, "d" => 5)) !== array("a" => 42, "b" => 1337, "c" => -1, "d" => 5)) { throw new Exception("Test failed!"); }
}

test();
