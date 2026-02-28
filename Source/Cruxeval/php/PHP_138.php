<?php
function f($text, $chars) {
    $listchars = str_split($chars);
    $first = array_pop($listchars);
    foreach ($listchars as $i) {
        $text = substr_replace($text, $i, strpos($text, $i), 1);
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("tflb omn rtt", "m") !== "tflb omn rtt") { throw new Exception("Test failed!"); }
}

test();
