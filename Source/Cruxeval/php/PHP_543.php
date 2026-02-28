<?php
function f($item) {
    $modified = str_replace(array('. ', '&#33; ', '. ', '. '), array(' , ', '! ', '? ', '. '), $item);
    return ucfirst($modified);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(".,,,,,. منبت") !== ".,,,,, , منبت") { throw new Exception("Test failed!"); }
}

test();
