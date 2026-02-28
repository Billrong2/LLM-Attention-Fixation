<?php
function f($arr, $d) {
    for ($i = 1; $i < count($arr); $i += 2) {
        $d[$arr[$i]] = $arr[$i - 1];
    }

    return $d;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("b", "vzjmc", "f", "ae", "0"), array()) !== array("vzjmc" => "b", "ae" => "f")) { throw new Exception("Test failed!"); }
}

test();
