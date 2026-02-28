<?php
function f($text, $tabstop) {
    $text = str_replace("\n", "_____", $text);
    $text = str_replace("\t", str_repeat(" ", $tabstop), $text);
    $text = str_replace("_____", "\n", $text);
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("odes	code	well", 2) !== "odes  code  well") { throw new Exception("Test failed!"); }
}

test();
