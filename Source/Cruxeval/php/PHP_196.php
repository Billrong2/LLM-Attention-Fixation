<?php
function f($text) {
    $text = str_replace(' x', ' x.', $text);
    if (ucwords($text) === $text) {
        return 'correct';
    }
    $text = str_replace(' x.', ' x', $text);
    return 'mixed';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("398 Is A Poor Year To Sow") !== "correct") { throw new Exception("Test failed!"); }
}

test();
