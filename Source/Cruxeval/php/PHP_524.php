<?php
function f($dict0) {
    $new = $dict0;
    for ($i = 0; $i < count($new) - 1; $i++) {
        $keys = array_keys($new);
        sort($keys);
        $new[$keys[$i]] = $i;
    }
    return $new;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(2 => 5, 4 => 1, 3 => 5, 1 => 3, 5 => 1)) !== array(2 => 1, 4 => 3, 3 => 2, 1 => 0, 5 => 1)) { throw new Exception("Test failed!"); }
}

test();
