<?php
function f($row) {
    return array(substr_count($row, '1'), substr_count($row, '0'));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("100010010") !== array(3, 6)) { throw new Exception("Test failed!"); }
}

test();
