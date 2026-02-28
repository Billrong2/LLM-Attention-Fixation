<?php
function f($text) {
    $my_list = explode(" ", $text);
    rsort($my_list);
    return implode(" ", $my_list);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("a loved") !== "loved a") { throw new Exception("Test failed!"); }
}

test();
