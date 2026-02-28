<?php
function f($playlist, $liker_name, $song_index) {
    if (!isset($playlist[$liker_name])) {
        $playlist[$liker_name] = [];
    }
    $playlist[$liker_name][] = $song_index;
    return $playlist;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("aki" => array("1", "5")), "aki", "2") !== array("aki" => array("1", "5", "2"))) { throw new Exception("Test failed!"); }
}

test();
