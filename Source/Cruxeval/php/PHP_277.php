<?php
function f($lst, $mode) {
    $result = $lst;
    if ($mode) {
        $result = array_reverse($result);
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3, 4), 1) !== array(4, 3, 2, 1)) { throw new Exception("Test failed!"); }
}

test();
