<?php
function f($s, $l) {
    return substr(str_pad($s, $l, '=', STR_PAD_RIGHT), 0, strrpos(str_pad($s, $l, '=', STR_PAD_RIGHT), '='));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("urecord", 8) !== "urecord") { throw new Exception("Test failed!"); }
}

test();
