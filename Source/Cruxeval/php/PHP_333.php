<?php
function f($places, $lazy) {
    sort($places);
    foreach ($lazy as $l) {
        $key = array_search($l, $places);
        if ($key !== false) {
            unset($places[$key]);
        }
    }
    if (count($places) == 1) {
        return 1;
    }
    foreach ($places as $i => $place) {
        if (array_count_values($places)[$place + 1] == 0) {
            return $i + 1;
        }
    }
    return $i + 1;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(375, 564, 857, 90, 728, 92), array(728)) !== 1) { throw new Exception("Test failed!"); }
}

test();
