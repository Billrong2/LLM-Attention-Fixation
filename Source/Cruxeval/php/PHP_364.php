<?php
function f($nums) {
    $verdict = function($x) { return $x < 2; };
    $res = array_filter($nums, function($x) { return $x != 0; });
    $result = array();
    foreach($res as $x) {
        $result[] = [$x, $verdict($x)];
    }
    if(empty($result)) {
        return 'error - no numbers or all zeros!';
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(0, 3, 0, 1)) !== array(array(3, false), array(1, true))) { throw new Exception("Test failed!"); }
}

test();
