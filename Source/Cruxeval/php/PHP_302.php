<?php
function f($string) {
    return str_replace('needles', 'haystacks', $string);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("wdeejjjzsjsjjsxjjneddaddddddefsfd") !== "wdeejjjzsjsjjsxjjneddaddddddefsfd") { throw new Exception("Test failed!"); }
}

test();
