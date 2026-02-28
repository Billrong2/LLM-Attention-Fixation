<?php
function f($code) {
    $lines = explode(']', $code);
    $result = [];
    $level = 0;
    foreach ($lines as $line) {
        $result[] = $line[0] . ' ' . str_repeat('  ', $level) . substr($line, 1);
        $level += substr_count($line, '{') - substr_count($line, '}');
    }
    return implode("\n", $result);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("if (x) {y = 1;} else {z = 1;}") !== "i f (x) {y = 1;} else {z = 1;}") { throw new Exception("Test failed!"); }
}

test();
