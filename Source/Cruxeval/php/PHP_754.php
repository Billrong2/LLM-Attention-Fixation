<?php
function f($nums) {
    $width = (int)$nums[0];
    $fill = '0';
    $formatted_nums = array_map(function($val) use ($width, $fill) {
        return str_pad($val, $width, $fill, STR_PAD_LEFT);
    }, array_slice($nums, 1));
    
    return array_map('strval', $formatted_nums);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("1", "2", "2", "44", "0", "7", "20257")) !== array("2", "2", "44", "0", "7", "20257")) { throw new Exception("Test failed!"); }
}

test();
