<?php
function f($n, $l) {
    $archive = array();
    for ($i = 0; $i < $n; $i++) {
        $archive = array();
        foreach ($l as $x) {
            $archive[$x + 10] = $x * 10;
        }
    }
    return $archive;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(0, array("aaa", "bbb")) !== array()) { throw new Exception("Test failed!"); }
}

test();
