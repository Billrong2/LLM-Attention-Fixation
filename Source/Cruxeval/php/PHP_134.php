<?php
function f($n) {
    $t = 0;
    $b = '';
    $digits = array_map('intval', str_split((string)$n));
    foreach ($digits as $d) {
        if ($d == 0) {
            $t += 1;
        } else {
            break;
        }
    }
    for ($i = 0; $i < $t; $i++) {
        $b .= '1' . '0' . '4';
    }
    $b .= (string)$n;
    return $b;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(372359) !== "372359") { throw new Exception("Test failed!"); }
}

test();
