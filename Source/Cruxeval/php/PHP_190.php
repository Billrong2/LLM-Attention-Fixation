<?php
function f($text) {
    $short = '';
    for ($i = 0; $i < strlen($text); $i++) {
        $c = $text[$i];
        if (ctype_lower($c)) {
            $short .= $c;
        }
    }
    return $short;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("980jio80jic kld094398IIl ") !== "jiojickldl") { throw new Exception("Test failed!"); }
}

test();
