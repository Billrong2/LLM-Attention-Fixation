<?php
function f($d) {
    $d = $d;
    array_pop($d);
    return $d;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("l" => 1, "t" => 2, "x:" => 3)) !== array("l" => 1, "t" => 2)) { throw new Exception("Test failed!"); }
}

test();
