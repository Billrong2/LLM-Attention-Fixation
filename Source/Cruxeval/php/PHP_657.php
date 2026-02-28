<?php
function f($text) {
    foreach (str_split('!.?,:;') as $punct) {
        if (substr_count($text, $punct) > 1) {
            return 'no';
        }
        if (substr($text, -1) === $punct) {
            return 'no';
        }
    }
    return ucfirst($text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("djhasghasgdha") !== "Djhasghasgdha") { throw new Exception("Test failed!"); }
}

test();
