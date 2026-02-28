<?php
function f($s) {
    $s = str_replace('"', '', $s);
    $lst = str_split($s);
    $col = 0;
    $count = 1;
    while ($col < count($lst) && in_array($lst[$col], ['.', ':', ','])) {
        if ($lst[$col] == ".") {
            $count = $lst[$col] + 1;
        }
        $col++;
    }
    return substr($s, $col + $count);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("\"Makers of a Statement\"") !== "akers of a Statement") { throw new Exception("Test failed!"); }
}

test();
