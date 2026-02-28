<?php
function f($address) {
    $suffix_start = strpos($address, '@') + 1;
    if (substr_count(substr($address, $suffix_start), '.') > 1) {
        $split_address = explode('@', $address);
        $address = $split_address[0] . remove_suffix(implode('.', array_slice(explode('.', $split_address[1]), 0, 2)), $address);
    }
    return $address;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("minimc@minimc.io") !== "minimc@minimc.io") { throw new Exception("Test failed!"); }
}

test();
