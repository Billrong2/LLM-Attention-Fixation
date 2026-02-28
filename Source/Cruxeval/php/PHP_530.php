<?php
function f($s, $ch) {
    $sl = $s;
    if (strpos($s, $ch) !== false) {
        $sl = ltrim($s, $ch);
        if (strlen($sl) == 0) {
            $sl = $sl . '!?';
        }
    } else {
        return 'no';
    }
    return $sl;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("@@@ff", "@") !== "ff") { throw new Exception("Test failed!"); }
}

test();
