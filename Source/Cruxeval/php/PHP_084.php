<?php
function f($text) {
    $arr = explode(" ", $text);
    $result = [];
    foreach ($arr as $item) {
        if (substr($item, -3) === 'day') {
            $item .= 'y';
        } else {
            $item .= 'day';
        }
        $result[] = $item;
    }
    return implode(" ", $result);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("nwv mef ofme bdryl") !== "nwvday mefday ofmeday bdrylday") { throw new Exception("Test failed!"); }
}

test();
