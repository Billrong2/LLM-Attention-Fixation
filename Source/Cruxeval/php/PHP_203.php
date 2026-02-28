<?php
function f($d) {
    $d = [];
    return $d;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("a" => "3", "b" => "-1", "c" => "Dum")) !== array()) { throw new Exception("Test failed!"); }
}

test();
