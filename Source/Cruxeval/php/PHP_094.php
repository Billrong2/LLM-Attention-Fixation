<?php
function f($a, $b) {
    return array_merge($a, $b);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("w" => 5, "wi" => 10), array("w" => 3)) !== array("w" => 3, "wi" => 10)) { throw new Exception("Test failed!"); }
}

test();
