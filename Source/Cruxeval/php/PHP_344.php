<?php
function f($lst) {
    $operation = function($x) { return array_reverse($x); };
    $new_list = $lst;
    sort($new_list);
    $new_list = $operation($new_list);
    return $lst;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(6, 4, 2, 8, 15)) !== array(6, 4, 2, 8, 15)) { throw new Exception("Test failed!"); }
}

test();
