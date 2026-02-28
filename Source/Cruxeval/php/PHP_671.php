<?php
function f($text, $char1, $char2) {
    for ($i = 0; $i < strlen($char1); $i++) {
        $t1a[] = $char1[$i];
        $t2a[] = $char2[$i];
    }
    $t1 = array_combine($t1a, $t2a);
    $t1 = strtr($text, $t1);
    return $t1;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ewriyat emf rwto segya", "tey", "dgo") !== "gwrioad gmf rwdo sggoa") { throw new Exception("Test failed!"); }
}

test();
