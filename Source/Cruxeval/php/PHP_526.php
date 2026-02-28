<?php
function f($label1, $char, $label2, $index) {
    $m = strrpos($label1, $char);
    if ($m >= $index) {
        return substr($label2, 0, $m - $index + 1);
    }
    return $label1 . substr($label2, $index - $m - 1);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ekwies", "s", "rpg", 1) !== "rpg") { throw new Exception("Test failed!"); }
}

test();
