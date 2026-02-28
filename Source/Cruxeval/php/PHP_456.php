<?php
function f($s, $tab) {
    return str_replace("\t", str_repeat(' ', $tab), $s);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Join us in Hungary", 4) !== "Join us in Hungary") { throw new Exception("Test failed!"); }
}

test();
