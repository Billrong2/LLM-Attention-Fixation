<?php
function f($text, $suffix) {
    if ($suffix == '') {
        $suffix = null;
    }
    return substr($text, -strlen($suffix)) === $suffix;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("uMeGndkGh", "kG") !== false) { throw new Exception("Test failed!"); }
}

test();
