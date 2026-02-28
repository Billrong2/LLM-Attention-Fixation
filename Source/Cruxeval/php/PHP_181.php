<?php
function f($s) {
    $count = 0;
    $digits = "";
    for ($i = 0; $i < strlen($s); $i++) {
        $c = $s[$i];
        if (is_numeric($c)) {
            $count++;
            $digits .= $c;
        }
    }
    return [$digits, $count];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("qwfasgahh329kn12a23") !== array("3291223", 7)) { throw new Exception("Test failed!"); }
}

test();
