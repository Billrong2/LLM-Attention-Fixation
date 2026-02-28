<?php
function f($s, $suffix) {
    if ($suffix === '') {
        return $s;
    }
    
    while (substr($s, -strlen($suffix)) === $suffix) {
        $s = substr($s, 0, -strlen($suffix));
    }
    
    return $s;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ababa", "ab") !== "ababa") { throw new Exception("Test failed!"); }
}

test();
