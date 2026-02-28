<?php
function f($text, $characters) {
    $character_list = str_split($characters);
    $character_list[] = ' ';
    $character_list[] = '_';

    $i = 0;
    while ($i < strlen($text) && in_array($text[$i], $character_list)) {
        $i++;
    }

    return substr($text, $i);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("2nm_28in", "nm") !== "2nm_28in") { throw new Exception("Test failed!"); }
}

test();
