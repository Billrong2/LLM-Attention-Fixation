<?php
function f($book) {
    $a = explode(':', $book);
    $parts1 = explode(' ', trim($a[0]));
    $parts2 = explode(' ', trim($a[1]));

    if ($parts1[count($parts1)-1] == $parts2[0]) {
        return f(implode(' ', array_slice($parts1, 0, -1)) . ' ' . $a[1]);
    }
    return $book;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("udhv zcvi nhtnfyd :erwuyawa pun") !== "udhv zcvi nhtnfyd :erwuyawa pun") { throw new Exception("Test failed!"); }
}

test();
