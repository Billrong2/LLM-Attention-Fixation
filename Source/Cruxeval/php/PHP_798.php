<?php
function f($text, $pre) {
    if (strpos($text, $pre) !== 0) {
        return $text;
    }
    return substr($text, strlen($pre));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("@hihu@!", "@hihu") !== "@!") { throw new Exception("Test failed!"); }
}

test();
