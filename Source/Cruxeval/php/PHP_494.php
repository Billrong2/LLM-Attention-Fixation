<?php
function f($num, $l) {
    $t = "";
    while ($l > strlen($num)) {
        $t .= '0';
        $l--;
    }
    return $t . $num;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("1", 3) !== "001") { throw new Exception("Test failed!"); }
}

test();
