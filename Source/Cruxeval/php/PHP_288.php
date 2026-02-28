<?php
function f($d) {
    $sorted_pairs = [];
    foreach ($d as $k => $v) {
        $len = strlen((string)$k . (string)$v);
        $sorted_pairs[$len][] = [$k, $v];
    }
    ksort($sorted_pairs);

    $ret = [];
    foreach($sorted_pairs as $pairs){
        foreach($pairs as list($k, $v)){
            if($k < $v){
                $ret[] = [$k, $v];
            }
        }
    }
    return $ret;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(55 => 4, 4 => 555, 1 => 3, 99 => 21, 499 => 4, 71 => 7, 12 => 6)) !== array(array(1, 3), array(4, 555))) { throw new Exception("Test failed!"); }
}

test();
