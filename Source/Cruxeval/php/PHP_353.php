<?php
function f($x) {
    if (empty($x)) {
        return -1;
    } else {
        $cache = array();
        foreach ($x as $item) {
            if (array_key_exists($item, $cache)) {
                $cache[$item] += 1;
            } else {
                $cache[$item] = 1;
            }
        }
        return max($cache);
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 0, 2, 2, 0, 0, 0, 1)) !== 4) { throw new Exception("Test failed!"); }
}

test();
