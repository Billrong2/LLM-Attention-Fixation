function f($xs) {
    for ($i = -1; $i >= -count($xs)-1; $i--) {
        array_push($xs, $xs[$i], $xs[$i]);
    }
    return $xs;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(4, 8, 8, 5)) !== array(4, 8, 8, 5, 5, 5, 5, 5, 5, 5, 5, 5)) { throw new Exception("Test failed!"); }
}

test();
