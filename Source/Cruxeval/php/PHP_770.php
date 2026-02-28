<?php
function f($line, $char) {
    $count = substr_count($line, $char);
    for ($i = $count+1; $i > 0; $i--) {
        $line = str_pad($line, strlen($line)+$i / strlen($char), $char, STR_PAD_BOTH);
    }
    return $line;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("$78", "$") !== "$$78$$") { throw new Exception("Test failed!"); }
}

test();
