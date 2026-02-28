<?php
function f($s, $sep) {
    $s .= $sep;
    $rpos = strrpos($s, $sep);
    if ($rpos !== false) {
        $s = substr($s, 0, $rpos);
    }
    return $s;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("234dsfssdfs333324314", "s") !== "234dsfssdfs333324314") { throw new Exception("Test failed!"); }
}

test();
