<?php
function f($str, $toget) {
    if (substr($str, 0, strlen($toget)) === $toget) {
        return substr($str, strlen($toget));
    } else {
        return $str;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("fnuiyh", "ni") !== "fnuiyh") { throw new Exception("Test failed!"); }
}

test();
