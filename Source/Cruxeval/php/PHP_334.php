<?php
function f($a, $b) {
    return implode($a, $b);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("00", array("nU", " 9 rCSAz", "w", " lpA5BO", "sizL", "i7rlVr")) !== "nU00 9 rCSAz00w00 lpA5BO00sizL00i7rlVr") { throw new Exception("Test failed!"); }
}

test();
