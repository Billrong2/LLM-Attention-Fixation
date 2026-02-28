<?php
function f($c, $index, $value) {
    $c[$index] = $value;
    if ($value >= 3) {
        $c['message'] = 'xcrWt';
    } else {
        unset($c['message']);
    }
    return $c;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1 => 2, 3 => 4, 5 => 6, "message" => "qrTHo"), 8, 2) !== array(1 => 2, 3 => 4, 5 => 6, 8 => 2)) { throw new Exception("Test failed!"); }
}

test();
