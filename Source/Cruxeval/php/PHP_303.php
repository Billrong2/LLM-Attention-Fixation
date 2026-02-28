<?php
function f($text) {
    $i = (strlen($text) + 1) / 2;
    $result = str_split($text);
    while ($i < strlen($text)) {
        $t = strtolower($result[$i]);
        if ($t == $result[$i]) {
            $i += 1;
        } else {
            $result[$i] = $t;
        }
        $i += 2;
    }
    return implode('', $result);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("mJkLbn") !== "mJklbn") { throw new Exception("Test failed!"); }
}

test();
