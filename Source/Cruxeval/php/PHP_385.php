<?php
function f($lst) {
    $i = 0;
    $new_list = [];
    while ($i < count($lst)) {
        if (in_array($lst[$i], array_slice($lst, $i + 1))) {
            $new_list[] = $lst[$i];
            if (count($new_list) == 3) {
                return $new_list;
            }
        }
        $i++;
    }
    return $new_list;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(0, 2, 1, 2, 6, 2, 6, 3, 0)) !== array(0, 2, 2)) { throw new Exception("Test failed!"); }
}

test();
