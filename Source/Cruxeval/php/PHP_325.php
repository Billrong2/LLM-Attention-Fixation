<?php
function f($s) {
    if ($s == "") {
        return true;
    }
    $l = str_split($s);
    foreach($l as &$i) {
        $i = strtolower($i);
        if(!is_numeric($i)) {
            return False;
        }
    }
    return True;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("") !== true) { throw new Exception("Test failed!"); }
}

test();
