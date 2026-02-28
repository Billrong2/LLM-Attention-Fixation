<?php
function f($ip, $n) {
    $i = 0;
    $out = '';
    for ($j=0; $j<strlen($ip); $j++) {
        $c = $ip[$j];
        if ($i == $n) {
            $out .= "\n";
            $i = 0;
        }
        $i += 1;
        $out .= $c;
    }
    return $out;
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("dskjs hjcdjnxhjicnn", 4) !== "dskj\ns hj\ncdjn\nxhji\ncnn") { throw new Exception("Test failed!"); }
}

test();
