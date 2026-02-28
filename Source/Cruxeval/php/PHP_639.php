<?php
function f($perc, $full) {
    $reply = '';
    $i = 0;
    while ($i < strlen($full) && $i < strlen($perc) && $perc[$i] == $full[$i]) {
        if ($perc[$i] == $full[$i]) {
            $reply .= "yes ";
        } else {
            $reply .= "no ";
        }
        $i++;
    }
    return $reply;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("xabxfiwoexahxaxbxs", "xbabcabccb") !== "yes ") { throw new Exception("Test failed!"); }
}

test();
