<?php
function f($text) {
    $a = explode("\n", $text);
    $b = [];
    foreach($a as $line) {
        $c = str_replace("\t", "    ", $line);
        $b[] = $c;
    }
    return implode("\n", $b);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("			tab tab tabulates") !== "            tab tab tabulates") { throw new Exception("Test failed!"); }
}

test();
