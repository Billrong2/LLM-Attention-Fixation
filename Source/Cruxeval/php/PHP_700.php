<?php
function f($text) {
    return strlen($text) - substr_count($text, 'bot');
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Where is the bot in this world?") !== 30) { throw new Exception("Test failed!"); }
}

test();
