<?php
function f($names, $winners) {
    $ls = array_map(function($name) use ($names) {
        return array_search($name, $names);
    }, array_intersect($names, $winners));

    rsort($ls);
    return $ls;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("e", "f", "j", "x", "r", "k"), array("a", "v", "2", "im", "nb", "vj", "z")) !== array()) { throw new Exception("Test failed!"); }
}

test();
