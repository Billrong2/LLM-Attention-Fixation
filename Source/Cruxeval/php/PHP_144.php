<?php
function f($vectors) {
    $sorted_vecs = [];
    foreach ($vectors as $vec) {
        sort($vec);
        $sorted_vecs[] = $vec;
    }
    return $sorted_vecs;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();
