<?php
function f($num, $name) {
    $f_str = 'quiz leader = %s, count = %d';
    return sprintf($f_str, $name, $num);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(23, "Cornareti") !== "quiz leader = Cornareti, count = 23") { throw new Exception("Test failed!"); }
}

test();
