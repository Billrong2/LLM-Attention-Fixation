<?php
function f($text) {
    if (preg_match('~[\\x00-\\x7F]~', $text) === 1) {
        return 'ascii';
    } else {
        return 'non ascii';
    }
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("<<<<") !== "ascii") { throw new Exception("Test failed!"); }
}

test();
