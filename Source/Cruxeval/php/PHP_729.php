<?php
function f($s1, $s2) {
    $res = [];
    $i = strrpos($s1, $s2);
    while ($i !== false) {
        array_push($res, $i+strlen($s2)-1);
        $i = strrpos(substr($s1, 0, $i), $s2);
    }
    return $res;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("abcdefghabc", "abc") !== array(10, 2)) { throw new Exception("Test failed!"); }
}

test();
