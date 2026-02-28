<?php
function f($text) {
    $nums = str_split(preg_replace('/\D/', '', $text));
    if (count($nums) > 0) {
        return implode('', $nums);
    } else {
        // Handle the case where there are no numeric characters
        // You can throw an exception, return a default value, etc.
        return '';
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("-123   	+314") !== "123314") { throw new Exception("Test failed!"); }
}

test();
