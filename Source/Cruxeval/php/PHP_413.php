<?php
function f($s) {
    return substr($s, 3) . $s[2] . substr($s, 5, 3);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("jbucwc") !== "cwcuc") { throw new Exception("Test failed!"); }
}

test();
