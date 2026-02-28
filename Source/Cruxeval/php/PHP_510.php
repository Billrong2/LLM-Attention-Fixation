<?php
function f($a, $b, $c, $d, $e) {
    $key = $d;
    if (array_key_exists($key, $a)) {
        $num = $a[$key];
        unset($a[$key]);
    }
    if ($b > 3) {
        return implode('', str_split($c));
    } else {
        return $num;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(7 => "ii5p", 1 => "o3Jwus", 3 => "lot9L", 2 => "04g", 9 => "Wjf", 8 => "5b", 0 => "te6", 5 => "flLO", 6 => "jq", 4 => "vfa0tW"), 4, "Wy", "Wy", 1.0) !== "Wy") { throw new Exception("Test failed!"); }
}

test();
