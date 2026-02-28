<?php
function f($a) {
    $s = array_reverse($a, true);
    $result = '';
    foreach ($s as $key => $value) {
        $result .= " ($key, '$value')";
    }
    return trim($result);
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(15 => "Qltuf", 12 => "Rwrepny")) !== "(12, 'Rwrepny') (15, 'Qltuf')") { throw new Exception("Test failed!"); }
}

test();
