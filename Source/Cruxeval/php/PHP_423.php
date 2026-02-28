<?php
function f($selfie) {
    $lo = count($selfie);
    for ($i = $lo-1; $i >= 0; $i--) {
        if ($selfie[$i] === $selfie[0]) {
            unset($selfie[$lo-1]);
        }
    }
    return array_values($selfie);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(4, 2, 5, 1, 3, 2, 6)) !== array(4, 2, 5, 1, 3, 2)) { throw new Exception("Test failed!"); }
}

test();
