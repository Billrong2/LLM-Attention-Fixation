<?php
function f($items, $item) {
    while(end($items) === $item){
        array_pop($items);
    }
    array_push($items, $item);
    return count($items);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("bfreratrrbdbzagbretaredtroefcoiqrrneaosf"), "n") !== 2) { throw new Exception("Test failed!"); }
}

test();
