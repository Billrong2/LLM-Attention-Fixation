<?php
function f($full, $part) {
    $length = strlen($part);
    $index = strpos($full, $part);
    $count = 0;
    while ($index !== false) {
        $full = substr($full, $index + $length);
        $index = strpos($full, $part);
        $count += 1;
    }
    return $count;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("hrsiajiajieihruejfhbrisvlmmy", "hr") !== 2) { throw new Exception("Test failed!"); }
}

test();
