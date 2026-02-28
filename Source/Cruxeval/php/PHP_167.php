<?php
function f($XAAXX, $s) {
    $count = 0;
    $idx = -1;
    while (strpos($XAAXX, 'XXXX', $idx+1) !== false) {
        $idx = strpos($XAAXX, 'XXXX', $idx+1);
        $count += 1;
    }
    $compound = str_repeat(ucwords(strtolower($s)), $count);
    return str_replace('XXXX', $compound, $XAAXX);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("aaXXXXbbXXXXccXXXXde", "QW") !== "aaQwQwQwbbQwQwQwccQwQwQwde") { throw new Exception("Test failed!"); }
}

test();
