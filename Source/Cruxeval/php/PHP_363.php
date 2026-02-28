<?php
function f($nums) {
    sort($nums);
    $n = count($nums);
    $new_nums = [$nums[floor($n/2)]];
    
    if ($n % 2 == 0) {
        $new_nums = [$nums[floor($n/2) - 1], $nums[floor($n/2)]];
    }
    
    for ($i = 0; $i < floor($n/2); $i++) {
        array_unshift($new_nums, $nums[$n-$i-1]);
        array_push($new_nums, $nums[$i]);
    }
    
    return $new_nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1)) !== array(1)) { throw new Exception("Test failed!"); }
}

test();
