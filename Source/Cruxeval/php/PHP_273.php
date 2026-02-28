<?php
function f($name) {
    $new_name = '';
    $name = strrev($name);
    for ($i = 0; $i < strlen($name); $i++) {
        $n = $name[$i];
        if ($n != '.' && substr_count($new_name, '.') < 2) {
            $new_name = $n . $new_name;
        } else {
            break;
        }
    }
    return $new_name;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(".NET") !== "NET") { throw new Exception("Test failed!"); }
}

test();
