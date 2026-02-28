<?php
function f($text) {
    $result_list = ['3', '3', '3', '3'];
    if (!empty($result_list)) {
        $result_list = [];
    }
    return strlen($text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("mrq7y") !== 5) { throw new Exception("Test failed!"); }
}

test();
