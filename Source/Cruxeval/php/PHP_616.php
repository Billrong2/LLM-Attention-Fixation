<?php
function f($body) {
    $ls = str_split($body);
    $dist = 0;
    for ($i = 0; $i < count($ls) - 1; $i++) {
        if (($i - 2) >= 0 && $ls[$i - 2] == '\t') {
            $dist += (1 + substr_count($ls[$i - 1], '\t')) * 3;
        }
        $ls[$i] = '[' . $ls[$i] . ']';
    }
    return str_replace('\t', '    ', implode('', $ls));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("\n\ny\n") !== "[\n][\n][y]\n") { throw new Exception("Test failed!"); }
}

test();
