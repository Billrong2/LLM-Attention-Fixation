<?php
function f($text, $value) {
    $ls = str_split($text);
    if ((array_count_values($ls)[$value] ?? 0) % 2 == 0) {
        while (($key = array_search($value, $ls)) !== false) {
            unset($ls[$key]);
        }
    } else {
        $ls = [];
    }
    return implode('', $ls);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("abbkebaniuwurzvr", "m") !== "abbkebaniuwurzvr") { throw new Exception("Test failed!"); }
}

test();
