<?php
function f($d) {
    $items = [];
    foreach ($d as $key => $value) {
        $items[] = ['key' => $key, 'value' => $value];
    }
    usort($items, function ($a, $b) {
        return $b['key'] <=> $a['key'];
    });
    $key1 = $items[0]['key'];
    $val1 = $d[$key1];
    unset($d[$key1]);
    $key2 = $items[1]['key'];
    $val2 = $d[$key2];
    unset($d[$key2]);
    return [$key1 => $val1, $key2 => $val2];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(2 => 3, 17 => 3, 16 => 6, 18 => 6, 87 => 7)) !== array(87 => 7, 18 => 6)) { throw new Exception("Test failed!"); }
}

test();
