<?php
function f($d) {
    $result = [];
    foreach ($d as $ki => $li) {
        $result[$ki] = [];
        foreach ($li as $dj) {
            $result[$ki][] = [];
            foreach ($dj as $kk => $l) {
                $result[$ki][array_key_last($result[$ki])][$kk] = $l;
            }
        }
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();
