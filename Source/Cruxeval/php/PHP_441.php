<?php
function f($base, $k, $v) {
    $base[$k] = $v;
    return $base;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(37 => "forty-five"), "23", "what?") !== array(37 => "forty-five", "23" => "what?")) { throw new Exception("Test failed!"); }
}

test();
