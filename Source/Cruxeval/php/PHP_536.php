<?php
function f($cat) {
    $digits = 0;
    for ($i = 0; $i < strlen($cat); $i++) {
        if (is_numeric($cat[$i])) {
            $digits += 1;
        }
    }
    return $digits;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("C24Bxxx982ab") !== 5) { throw new Exception("Test failed!"); }
}

test();
