<?php
function f($a) {
    $a = str_replace('/', ':', $a);
    $z = explode(':', $a);
    return [$z[0], ':', $z[1]];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("/CL44     ") !== array("", ":", "CL44     ")) { throw new Exception("Test failed!"); }
}

test();
