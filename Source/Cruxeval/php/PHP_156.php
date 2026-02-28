<?php
function f($text, $limit, $char) {
    if($limit < strlen($text)){
        return substr($text, 0, $limit);
    }
    return str_pad($text, $limit, $char, STR_PAD_RIGHT);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("tqzym", 5, "c") !== "tqzym") { throw new Exception("Test failed!"); }
}

test();
