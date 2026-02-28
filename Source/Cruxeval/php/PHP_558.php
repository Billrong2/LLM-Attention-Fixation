<?php
function f($nums, $mos) {
    foreach ($mos as $num) {
        $index = array_search($num, $nums);
        if ($index !== false) {
            array_splice($nums, $index, 1);
        }
    }
    sort($nums);

    foreach ($mos as $num) {
        $nums[] = $num;
    }

    for ($i = 0; $i < count($nums) - 1; $i++) {
        if ($nums[$i] > $nums[$i + 1]) {
            return false;
        }
    }

    return true;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(3, 1, 2, 1, 4, 1), array(1)) !== false) { throw new Exception("Test failed!"); }
}

test();
