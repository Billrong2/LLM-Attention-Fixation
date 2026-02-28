<?php
function f($phrase) {
    $ans = 0;
    $words = explode(" ", $phrase);
    foreach($words as $word) {
        for($i = 0; $i < strlen($word); $i++) {
            if($word[$i] == "0") {
                $ans += 1;
            }
        }
    }
    return $ans;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("aboba 212 has 0 digits") !== 1) { throw new Exception("Test failed!"); }
}

test();
