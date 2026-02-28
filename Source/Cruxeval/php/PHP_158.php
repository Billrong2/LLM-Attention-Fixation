<?php
function f($arr) {
    $n = array_filter($arr, function($item) {
        return $item % 2 === 0;
    });
    $m = array_merge($n, $arr);
    
    foreach ($m as $i) {
        if (array_search($i, $m) >= count($n)) {
            unset($m[array_search($i, $m)]);
        }
    }
    
    return array_values($m);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(3, 6, 4, -2, 5)) !== array(6, 4, -2, 6, 4, -2)) { throw new Exception("Test failed!"); }
}

test();
