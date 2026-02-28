<?php
function f($text, $new_ending) {
    $result = str_split($text);
    $result = array_merge($result, str_split($new_ending));
    return implode('', $result);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("jro", "wdlp") !== "jrowdlp") { throw new Exception("Test failed!"); }
}

test();
