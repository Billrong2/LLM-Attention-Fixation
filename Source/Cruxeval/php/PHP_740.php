<?php
function f($plot, $delin) {
    if (in_array($delin, $plot)) {
        $split = array_search($delin, $plot);
        $first = array_slice($plot, 0, $split);
        $second = array_slice($plot, $split + 1);
        return array_merge($first, $second);
    } else {
        return $plot;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3, 4), 3) !== array(1, 2, 4)) { throw new Exception("Test failed!"); }
}

test();
