<?php
function f($years) {
    $a10 = count(array_filter($years, function($x) {
        return $x <= 1900;
    }));
    $a90 = count(array_filter($years, function($x) {
        return $x > 1910;
    }));

    if ($a10 > 3) {
        return 3;
    } elseif ($a90 > 3) {
        return 1;
    } else {
        return 2;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1872, 1995, 1945)) !== 2) { throw new Exception("Test failed!"); }
}

test();
