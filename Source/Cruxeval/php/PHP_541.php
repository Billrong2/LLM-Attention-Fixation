<?php
function f($text) {
    $textArray = str_split($text);
    $joinedText = implode('', $textArray);
    return !ctype_space($joinedText);
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(" 	  　") !== true) { throw new Exception("Test failed!"); }
}

test();
