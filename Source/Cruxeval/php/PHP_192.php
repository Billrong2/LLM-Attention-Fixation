<?php
function f($text, $suffix) {
    $output = $text;
    while (substr($text, -strlen($suffix)) === $suffix) {
        $output = substr($text, 0, -strlen($suffix));
        $text = $output;
    }
    return $output;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("!klcd!ma:ri", "!") !== "!klcd!ma:ri") { throw new Exception("Test failed!"); }
}

test();
