<?php
function f($text) {
    $ls = [];
    foreach ($text as $x) {
        $ls[] = explode("\n", $x);
    }
    return $ls;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("Hello World\n\"I am String\"")) !== array(array("Hello World", "\"I am String\""))) { throw new Exception("Test failed!"); }
}

test();
