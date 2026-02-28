<?php
function f($update, $starting) {
    $d = $starting;
    foreach($update as $k => $v) {
        if (array_key_exists($k, $d)) {
            $d[$k] += $v;
        } else {
            $d[$k] = $v;
        }
    }
    return $d;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(), array("desciduous" => 2)) !== array("desciduous" => 2)) { throw new Exception("Test failed!"); }
}

test();
