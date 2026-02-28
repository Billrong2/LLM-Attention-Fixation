<?php
function f($key, $value) {
    $dict_ = array($key => $value);
    return array($key, $value);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("read", "Is") !== array("read", "Is")) { throw new Exception("Test failed!"); }
}

test();
