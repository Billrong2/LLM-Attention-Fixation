<?php
function f($dictionary, $key) {
    unset($dictionary[$key]);
    if (min(array_keys($dictionary)) === $key) {
        $dictionaryKeys = array_keys($dictionary);
        $key = $dictionaryKeys[0];
    }
    return $key;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("Iron Man" => 4, "Captain America" => 3, "Black Panther" => 0, "Thor" => 1, "Ant-Man" => 6), "Iron Man") !== "Iron Man") { throw new Exception("Test failed!"); }
}

test();
