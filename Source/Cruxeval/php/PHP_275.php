<?php
function f($dic) {
    $dic2 = array_flip($dic);
    return $dic2;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-1 => "a", 0 => "b", 1 => "c")) !== array("a" => -1, "b" => 0, "c" => 1)) { throw new Exception("Test failed!"); }
}

test();
