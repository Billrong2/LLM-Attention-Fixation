<?php
function f($text, $width) {
    $result = "";
    $lines = explode("\n", $text);
    foreach ($lines as $l) {
        $result .= str_pad($l, $width, " ", STR_PAD_BOTH);
        $result .= "\n";
    }

    // Remove the very last empty line
    $result = substr($result, 0, -1);
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("l\nl", 2) !== "l \nl ") { throw new Exception("Test failed!"); }
}

test();
