<?php
function f($text, $chars) {
    if ($chars != '') {
        $text = rtrim($text, $chars);
    } else {
        $text = rtrim($text);
    }
    if ($text === '') {
        return '-';
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("new-medium-performing-application - XQuery 2.2", "0123456789-") !== "new-medium-performing-application - XQuery 2.") { throw new Exception("Test failed!"); }
}

test();
