<?php
function f($ls, $n) {
    $answer = 0;
    foreach ($ls as $i) {
        if ($i[0] == $n) {
            $answer = $i;
        }
    }
    return $answer;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(array(1, 9, 4), array(83, 0, 5), array(9, 6, 100)), 1) !== array(1, 9, 4)) { throw new Exception("Test failed!"); }
}

test();
