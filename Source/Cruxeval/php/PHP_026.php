<?php
function f($items, $target) {
    $item_arr = explode(" ", $items);
    
    foreach ($item_arr as $i) {
        if (strpos($target, $i) !== false) {
            return strpos($items, $i) + 1;
        }
        if (strpos($i, '.') == strlen($i) - 1 || strpos($i, '.') == 0) {
            return 'error';
        }
    }
    
    return '.';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("qy. dg. rnvprt rse.. irtwv tx..", "wtwdoacb") !== "error") { throw new Exception("Test failed!"); }
}

test();
