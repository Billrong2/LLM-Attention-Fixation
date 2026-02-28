<?php
function f($n, $array) {
    $final = [$array]; 
    for ($i = 0; $i < $n; $i++) {
        $arr = $array;
        $arr = array_merge($arr, end($final));
        $final[] = $arr;
    }
    return $final;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(1, array(1, 2, 3)) !== array(array(1, 2, 3), array(1, 2, 3, 1, 2, 3))) { throw new Exception("Test failed!"); }
}

test();
