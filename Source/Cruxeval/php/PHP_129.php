<?php
function f($text, $search_string) {
    $indexes = [];
    while (strpos($text, $search_string) !== false) {
        $indexes[] = strrpos($text, $search_string);
        $text = substr($text, 0, strrpos($text, $search_string));
    }
    return $indexes;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ONBPICJOHRHDJOSNCPNJ9ONTHBQCJ", "J") !== array(28, 19, 12, 6)) { throw new Exception("Test failed!"); }
}

test();
