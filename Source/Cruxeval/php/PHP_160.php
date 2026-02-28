<?php
function f($dictionary) {
    while (!isset($dictionary[1]) && count($dictionary) > 0) {
        $dictionary = [];
        break;
    }
    return $dictionary;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1 => 47698, 1 => 32849, 1 => 38381, 3 => 83607)) !== array(1 => 38381, 3 => 83607)) { throw new Exception("Test failed!"); }
}

test();
