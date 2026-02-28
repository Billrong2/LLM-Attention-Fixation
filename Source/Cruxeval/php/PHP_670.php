<?php
function f($a, $b) {
    $d = array_combine($a, $b);
    uksort($a, function($x, $y) use ($d) {
        return $d[$y] - $d[$x];
    });
    $result = [];
    foreach ($a as $x) {
        $result[] = $d[$x];
        unset($d[$x]);
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("12", "ab"), array(2, 2)) !== array(2, 2)) { throw new Exception("Test failed!"); }
}

test();
