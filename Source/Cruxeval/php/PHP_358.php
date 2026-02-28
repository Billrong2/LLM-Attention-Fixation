<?php
function f($text, $value) {
    $indexes = array();
    for ($i=0; $i<strlen($text); $i++) {
        if ($text[$i] == $value && ($i == 0 || $text[$i-1] != $value)) {
            array_push($indexes, $i);
        }
    }
    if (count($indexes) % 2 == 1) {
        return $text;
    }
    return substr($text, $indexes[0]+1, $indexes[count($indexes)-1]-$indexes[0]-1);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("btrburger", "b") !== "tr") { throw new Exception("Test failed!"); }
}

test();
