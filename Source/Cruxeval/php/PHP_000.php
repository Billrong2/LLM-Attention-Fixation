<?php
function f($nums) {
    $output = [];
    foreach ($nums as $n) {
        $output[] = array(array_count_values($nums)[$n] ?? 0, $n);
    }
    usort($output, function($a, $b) {
        return $b[0] <=> $a[0];
    });
    return $output;
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 1, 3, 1, 3, 1)) !== array(array(4, 1), array(4, 1), array(4, 1), array(4, 1), array(2, 3), array(2, 3))) { throw new Exception("Test failed!"); }
}

test();
