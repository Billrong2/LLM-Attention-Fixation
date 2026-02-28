<?php
function f($txt, $alpha) {
    sort($txt);
    if (array_search($alpha, $txt) % 2 == 0) {
        return array_reverse($txt);
    }
    return $txt;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("8", "9", "7", "4", "3", "2"), "9") !== array("2", "3", "4", "7", "8", "9")) { throw new Exception("Test failed!"); }
}

test();
