<?php
function f($L) {
    $N = count($L);
    for ($k = 1; $k <= intval($N/2); $k++) {
        $i = $k - 1;
        $j = $N - $k;
        while ($i < $j) {
            // swap elements:
            $temp = $L[$i];
            $L[$i] = $L[$j];
            $L[$j] = $temp;
            // update i, j:
            $i++;
            $j--;
        }
    }
    return $L;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(16, 14, 12, 7, 9, 11)) !== array(11, 14, 7, 12, 9, 16)) { throw new Exception("Test failed!"); }
}

test();
