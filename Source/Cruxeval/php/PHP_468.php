<?php
function f($a, $b, $n) {
    $result = $m = $b;
    for ($i = 0; $i < $n; $i++) {
        if (!empty($m)) {
            list($a, $m) = explode($m, $a, 2);
            $result = $m = $b;
        }
    }
    return implode($result, explode($b, $a));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("unrndqafi", "c", 2) !== "unrndqafi") { throw new Exception("Test failed!"); }
}

test();
