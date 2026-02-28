<?php
function f($text, $ch) {
    return substr_count($text, $ch);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("This be Pirate's Speak for 'help'!", " ") !== 5) { throw new Exception("Test failed!"); }
}

test();
