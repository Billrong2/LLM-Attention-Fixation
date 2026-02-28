<?php
function f($obj) {
    foreach ($obj as $k => $v) {
        if ($v >= 0) {
            $obj[$k] = -$v;
        }
    }
    return $obj;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("R" => 0, "T" => 3, "F" => -6, "K" => 0)) !== array("R" => 0, "T" => -3, "F" => -6, "K" => 0)) { throw new Exception("Test failed!"); }
}

test();
