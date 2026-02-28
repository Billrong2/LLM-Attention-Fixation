<?php
function f($line) {
    $a = [];
    for ($i = 0; $i < strlen($line); $i++) {
        $c = $line[$i];
        if (ctype_alnum($c)) {
            $a[] = $c;
        }
    }
    return implode('', $a);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("\"\%$ normal chars $%~ qwet42'") !== "normalcharsqwet42") { throw new Exception("Test failed!"); }
}

test();
