<?php
function f() {
    $d = [
        'Russia' => [['Moscow', 'Russia'], ['Vladivostok', 'Russia']],
        'Kazakhstan' => [['Astana', 'Kazakhstan']],
    ];
    return array_keys($d);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate() !== array("Russia", "Kazakhstan")) { throw new Exception("Test failed!"); }
}

test();
