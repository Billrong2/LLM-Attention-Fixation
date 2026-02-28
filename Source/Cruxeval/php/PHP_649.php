<?php
function f($text, $tabsize) {
    return implode("\n", array_map(function($t) use ($tabsize) {
        return str_replace("\t", str_repeat(' ', $tabsize), $t);
    }, explode("\n", $text)));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("	f9\n	ldf9\n	adf9!\n	f9?", 1) !== " f9\n ldf9\n adf9!\n f9?") { throw new Exception("Test failed!"); }
}

test();
