<?php
function f($out, $mapping) {
    foreach ($mapping as $key => $value) {
        $out = strtr($out, $value);
        if (preg_match_all('/{\w}/', $out, $matches) == 0) {
            break;
        }
        $mapping[$key][1] = strrev($value[1]);
    }
    return $out;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("{{{{}}}}", array()) !== "{{{{}}}}") { throw new Exception("Test failed!"); }
}

test();
