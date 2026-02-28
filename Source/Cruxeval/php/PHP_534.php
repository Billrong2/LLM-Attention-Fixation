<?php
function f($sequence, $value) {
    $i = max(strpos($sequence, $value) - strlen($sequence) / 3, 0);
    $result = '';
    for ($j = 0; $j < strlen($sequence) - $i; $j++) {
        if ($sequence[$i + $j] == '+') {
            $result .= $value;
        } else {
            $result .= $sequence[$i + $j];
        }
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("hosu", "o") !== "hosu") { throw new Exception("Test failed!"); }
}

test();
