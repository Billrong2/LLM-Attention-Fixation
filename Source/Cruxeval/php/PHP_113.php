<?php
function f($line) {
    $count = 0;
    $a = [];
    for ($i = 0; $i < strlen($line); $i++) {
        $count += 1;
        if ($count % 2 == 0) {
            $a[] = ctype_lower($line[$i]) ? strtoupper($line[$i]) : strtolower($line[$i]);
        } else {
            $a[] = $line[$i];
        }
    }
    return implode('', $a);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("987yhNSHAshd 93275yrgSgbgSshfbsfB") !== "987YhnShAShD 93275yRgsgBgssHfBsFB") { throw new Exception("Test failed!"); }
}

test();
