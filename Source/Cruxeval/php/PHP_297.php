<?php
function f($num) {
    if (0 < $num && $num < 1000 && $num !== 6174) {
        return 'Half Life';
    }
    return 'Not found';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(6173) !== "Not found") { throw new Exception("Test failed!"); }
}

test();
