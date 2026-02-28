<?php
function f($items) {
    $odd_positioned = [];
    while (count($items) > 0) {
        $position = array_search(min($items), $items);
        array_splice($items, $position, 1);
        if ($position < count($items)) {
            $item = $items[$position];
            array_splice($items, $position, 1);
            $odd_positioned[] = $item;
        }
    }
    return $odd_positioned;
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3, 4, 5, 6, 7, 8)) !== array(2, 4, 6, 8)) { throw new Exception("Test failed!"); }
}

test();
