<?php
function f($nums, $rmvalue) {
    $res = $nums;
    while (in_array($rmvalue, $res)) {
        $index = array_search($rmvalue, $res);
        $popped = array_splice($res, $index, 1)[0];
        if ($popped != $rmvalue) {
            $res[] = $popped;
        }
    }
    return $res;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(6, 2, 1, 1, 4, 1), 5) !== array(6, 2, 1, 1, 4, 1)) { throw new Exception("Test failed!"); }
}

test();
