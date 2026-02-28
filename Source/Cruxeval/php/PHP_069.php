<?php
function f($student_marks, $name) {
    if (array_key_exists($name, $student_marks)) {
        $value = $student_marks[$name];
        unset($student_marks[$name]);
        return $value;
    }
    return 'Name unknown';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("882afmfp" => 56), "6f53p") !== "Name unknown") { throw new Exception("Test failed!"); }
}

test();
