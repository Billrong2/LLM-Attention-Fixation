<?php
function f($text, $res) {
    foreach (["*", "\n", "\""] as $c) {
        $text = str_replace($c, '!' . $res, $text);
    }
    if (strpos($text, '!') === 0) {
        $text = substr($text, strlen((string)$res));
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("\"Leap and the net will appear", 123) !== "3Leap and the net will appear") { throw new Exception("Test failed!"); }
}

test();
