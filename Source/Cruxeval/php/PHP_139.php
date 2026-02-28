<?php
function f($first, $second) {
    if (count($first) < 10 || count($second) < 10) {
        return 'no';
    }
    
    for ($i = 0; $i < 5; $i++) {
        if ($first[$i] !== $second[$i]) {
            return 'no';
        }
    }
    
    $first = array_merge($first, $second);
    return $first;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 1), array(1, 1, 2)) !== "no") { throw new Exception("Test failed!"); }
}

test();
