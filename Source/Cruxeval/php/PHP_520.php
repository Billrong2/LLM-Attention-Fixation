<?php
function f($album_sales) {
    while(count($album_sales) != 1) {
        $album_sales[] = array_shift($album_sales);
    }
    return $album_sales[0];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(6)) !== 6) { throw new Exception("Test failed!"); }
}

test();
