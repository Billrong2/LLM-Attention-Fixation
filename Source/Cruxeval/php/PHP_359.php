<?php
function f($lines) {
    for ($i = 0; $i < count($lines); $i++) {
        $lines[$i] = str_pad($lines[$i], strlen(end($lines)), ' ', STR_PAD_BOTH);
    }
    return $lines;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("dZwbSR", "wijHeq", "qluVok", "dxjxbF")) !== array("dZwbSR", "wijHeq", "qluVok", "dxjxbF")) { throw new Exception("Test failed!"); }
}

test();
