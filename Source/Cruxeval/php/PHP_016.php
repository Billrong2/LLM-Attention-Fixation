<?php
function f($text, $suffix) {
    if (substr($text, -strlen($suffix)) === $suffix) {
        return substr($text, 0, -strlen($suffix));
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("zejrohaj", "owc") !== "zejrohaj") { throw new Exception("Test failed!"); }
}

test();
