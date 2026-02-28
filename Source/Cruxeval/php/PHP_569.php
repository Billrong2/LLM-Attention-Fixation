<?php
function f($txt) {
    $coincidences = array();
    for ($i = 0; $i < strlen($txt); $i++) {
        $c = $txt[$i];
        if (array_key_exists($c, $coincidences)) {
            $coincidences[$c] += 1;
        } else {
            $coincidences[$c] = 1;
        }
    }
    
    return array_sum($coincidences);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("11 1 1") !== 6) { throw new Exception("Test failed!"); }
}

test();
