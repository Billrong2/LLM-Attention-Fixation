<?php
function f($text) {
    $new_text = str_split($text);
    foreach ($new_text as $index => $character) {
        $new_character = strtoupper($character) === $character ? strtolower($character) : strtoupper($character);
        $new_text[$index] = $new_character;
    }
    return implode('', $new_text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("dst vavf n dmv dfvm gamcu dgcvb.") !== "DST VAVF N DMV DFVM GAMCU DGCVB.") { throw new Exception("Test failed!"); }
}

test();
