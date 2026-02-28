<?php
function f($text) {
    $uppercase_index = strpos($text, 'A');
    if ($uppercase_index !== false) {
        return substr($text, 0, $uppercase_index) . substr($text, strpos($text, 'a') + 1);
    } else {
        $arr = str_split($text);
        sort($arr);
        return implode('', $arr);
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("E jIkx HtDpV G") !== "   DEGHIVjkptx") { throw new Exception("Test failed!"); }
}

test();
