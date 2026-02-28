<?php
function f($letters) {
    $a = [];
    for ($i = 0; $i < count($letters); $i++) {
        if (in_array($letters[$i], $a)) {
            return 'no';
        }
        $a[] = $letters[$i];
    }
    return 'yes';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("b", "i", "r", "o", "s", "j", "v", "p")) !== "yes") { throw new Exception("Test failed!"); }
}

test();
