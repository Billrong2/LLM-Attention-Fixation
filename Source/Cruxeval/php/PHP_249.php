<?php
function f($s) {
    $count = array();
    for ($i = 0; $i < strlen($s); $i++) {
        $char = strtolower($s[$i]);
        if (ctype_lower($char)) {
            $count[$char] = substr_count(strtolower($s), $char) + ($count[$char] ?? 0);
        } else {
            $count[$char] = substr_count(strtoupper($s), $char) + ($count[$char] ?? 0);
        }
    }
    return $count;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("FSA") !== array("f" => 1, "s" => 1, "a" => 1)) { throw new Exception("Test failed!"); }
}

test();
