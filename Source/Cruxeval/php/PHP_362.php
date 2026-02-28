<?php
function f($text) {
    for($i = 0; $i < strlen($text)-1; $i++) {
        if (ctype_lower(substr($text, $i))) {
            return substr($text, $i + 1);
        }
    }
    return '';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("wrazugizoernmgzu") !== "razugizoernmgzu") { throw new Exception("Test failed!"); }
}

test();
