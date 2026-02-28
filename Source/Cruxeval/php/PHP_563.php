<?php
function f($text1, $text2) {
    $nums = [];
    for ($i = 0; $i < strlen($text2); $i++) {
        $nums[] = substr_count($text1, $text2[$i]);
    }
    return array_sum($nums);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("jivespdcxc", "sx") !== 2) { throw new Exception("Test failed!"); }
}

test();
