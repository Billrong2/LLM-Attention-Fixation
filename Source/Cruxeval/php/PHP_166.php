<?php
function f($graph) {
    $new_graph = array();
    foreach ($graph as $key => $value) {
        $new_graph[$key] = array();
        foreach ($value as $subkey => $subvalue) {
            $new_graph[$key][$subkey] = '';
        }
    }
    return $new_graph;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();
