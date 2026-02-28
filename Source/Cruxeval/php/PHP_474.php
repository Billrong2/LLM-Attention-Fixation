<?php
function f($txt, $marker) {
    $a = [];
    $lines = explode('\n', $txt);
    foreach ($lines as $line) {
        $a[] = str_pad($line, $marker, ' ', STR_PAD_BOTH);
    }
    return implode('\n', $a);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("#[)[]>[^e>\n 8", -5) !== "#[)[]>[^e>\n 8") { throw new Exception("Test failed!"); }
}

test();
