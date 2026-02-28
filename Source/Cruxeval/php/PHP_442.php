<?php
function f($lst) {
    $res = array();
    foreach ($lst as $num) {
        if ($num % 2 === 0) {
            $res[] = $num;
        }
    }
    
    return $lst;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3, 4)) !== array(1, 2, 3, 4)) { throw new Exception("Test failed!"); }
}

test();
