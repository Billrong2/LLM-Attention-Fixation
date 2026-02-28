<?php
function f($simpons) {
    while (!empty($simpons)) {
        $pop = array_pop($simpons);
        if ($pop === ucfirst($pop)) {
            return $pop;
        }
    }
    return $pop;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("George", "Michael", "George", "Costanza")) !== "Costanza") { throw new Exception("Test failed!"); }
}

test();
