<?php
function f($x) {
    return implode(' ', array_reverse(str_split($x)));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("lert dna ndqmxohi3") !== "3 i h o x m q d n   a n d   t r e l") { throw new Exception("Test failed!"); }
}

test();
