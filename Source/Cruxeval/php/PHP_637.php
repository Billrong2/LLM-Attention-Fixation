<?php
function f($text) {
    $text = explode(' ', $text);
    foreach ($text as $t) {
        if (!is_numeric($t)) {
            return 'no';
        }
    }
    return 'yes';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("03625163633 d") !== "no") { throw new Exception("Test failed!"); }
}

test();
