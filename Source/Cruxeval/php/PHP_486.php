<?php
function f($dic) {
    $dic_op = $dic;
    foreach ($dic as $key => $val) {
        $dic_op[$key] = $val * $val;
    }
    return $dic_op;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1 => 1, 2 => 2, 3 => 3)) !== array(1 => 1, 2 => 4, 3 => 9)) { throw new Exception("Test failed!"); }
}

test();
