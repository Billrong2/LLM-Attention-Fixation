<?php
function f($text, $value) {
    $indexes = array();
    for($i = 0; $i < strlen($text); $i++) {
        if($text[$i] == $value) {
            $indexes[] = $i;
        }
    }

    $new_text = str_split($text);
    foreach($indexes as $index) {
        unset($new_text[$index]);
    }
    
    return implode("", $new_text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("scedvtvotkwqfoqn", "o") !== "scedvtvtkwqfqn") { throw new Exception("Test failed!"); }
}

test();
