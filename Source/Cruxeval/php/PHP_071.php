<?php
function f($d, $n) {
    for ($i = 0; $i < $n; $i++) {
        end($d);
        $item = [key($d), current($d)];
        unset($d[$item[0]]);
        $d[$item[1]] = $item[0];
    }
    return $d;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1 => 2, 3 => 4, 5 => 6, 7 => 8, 9 => 10), 1) !== array(1 => 2, 3 => 4, 5 => 6, 7 => 8, 10 => 9)) { throw new Exception("Test failed!"); }
}

test();
