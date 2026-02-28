<?php
function f($d) {
    $size = count($d);
    $v = array_fill(0, $size, 0);
    if ($size == 0) {
        return $v;
    }
    $i = 0;
    foreach ($d as $e) {
        $v[$i] = $e;
        $i++;
    }
    return $v;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("a" => 1, "b" => 2, "c" => 3)) !== array(1, 2, 3)) { throw new Exception("Test failed!"); }
}

test();
