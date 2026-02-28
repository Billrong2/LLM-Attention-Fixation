<?php
function f($text, $to_place) {
    $after_place = substr($text, 0, strpos($text, $to_place) + 1);
    $before_place = substr($text, strpos($text, $to_place) + 1);
    return $after_place . $before_place;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("some text", "some") !== "some text") { throw new Exception("Test failed!"); }
}

test();
