<?php
function f($a) {
    for ($i = 0; $i < 10; $i++) {
        for ($j = 0; $j < strlen($a); $j++) {
            if ($a[$j] !== '#') {
                $a = substr($a, $j);
                break;
            }
        }
        if ($j == strlen($a)) {
            $a = "";
            break;
        }
    }
    
    while ($a[strlen($a) - 1] == '#') {
        $a = substr($a, 0, -1);
    }
    
    return $a;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("##fiu##nk#he###wumun##") !== "fiu##nk#he###wumun") { throw new Exception("Test failed!"); }
}

test();
