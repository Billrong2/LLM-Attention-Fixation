<?php
function f($text, $elem) {
    if ($elem !== '') {
        while (strpos($text, $elem) === 0) {
            $text = str_replace($elem, '', $text);
        }
        while (strpos($elem, $text) === 0) {
            $elem = str_replace($text, '', $elem);
        }
    }
    return [$elem, $text];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("some", "1") !== array("1", "some")) { throw new Exception("Test failed!"); }
}

test();
